# frozen_string_literal: true

require_relative '../lib/board'

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#is_move_legal?' do
    context "when destination is not among piece's moves" do
      before do
        board.arrange_pieces
        pc_moves = [Position.for('a3'), Position.for('a4'), Position.for('b3')]
        dest_position = Position.for('a5')
        board.instance_variable_set(:@sel_pc_moves, pc_moves)
        board.instance_variable_set(:@destination_position, dest_position)
      end

      it 'returns false' do
        result = board.is_move_legal?
        expect(result).to be false
      end
    end

    context "when destination can be found among piece's moves" do
      before do
        board.arrange_pieces
        pc_moves = [Position.for('a3'), Position.for('a4'), Position.for('b3')]
        dest_position = Position.for('b3')
        board.instance_variable_set(:@sel_pc_moves, pc_moves)
        board.instance_variable_set(:@destination_position, dest_position)
      end

      it 'returns true' do
        result = board.is_move_legal?
        expect(result).to be true
      end
    end
  end

  describe '#square_at_position' do
    context 'when position does not exist on the board' do
      it 'returns nil' do
        pos = Position.for('f12')
        sqr = board.square_at_position(pos)
        expect(sqr).to be nil
      end
    end

    context 'when position exists on the board' do
      it 'returns the square' do
        pos = Position.for('f6')
        sqr = board.square_at_position(pos)
        expect(sqr).to be_a(Square)
      end
    end
  end

  describe '#update_targ_and_dest' do
    before do
      board.arrange_pieces
    end

    it 'stores square of target' do
      target = 'a2'
      destination = 'a4'
      targ_sqr = board.square_at_position(Position.for(target))
      board.update_targ_and_dest(target: target, destination: destination)
      inner_sel_square = board.instance_variable_get(:@selected_square)
      expect(inner_sel_square).to eql(targ_sqr)
    end

    it 'stores destination position' do
      target = 'a2'
      destination = 'a4'
      dest_pos = Position.for(destination)
      board.update_targ_and_dest(target: target, destination: destination)
      inner_dest_pos = board.instance_variable_get(:@destination_position)
      expect(inner_dest_pos).to eql(dest_pos)
    end

    it 'saves piece moves to board' do
      target = 'a2'
      destination = 'a4'
      a2_moves = Position.for(['a3', 'a4'])
      board.update_targ_and_dest(target: target, destination: destination)
      inner_sel_pc_moves = board.instance_variable_get(:@sel_pc_moves)
      expect(inner_sel_pc_moves).to eql(a2_moves)
    end
  end

  describe '#place_piece' do
    context 'when destination is valid' do
      before do
        target = 'a2'
        destination = 'a4'
        board.arrange_pieces
        board.update_targ_and_dest(target: target, destination: destination)
        @piece = board.instance_variable_get(:@selected_square).piece
      end

      it 'moves piece to destination square' do
        dest_sqr = board.send(:select_square_from_str, 'a4')
        expect do
          board.place_piece
        end.to change { dest_sqr.piece }.from(nil).to(@piece)
      end

      it 'marks piece as moved' do
        expect do
          board.place_piece
        end.to change { @piece.moved? }.from(false).to(true)
      end

      it 'empties previous square' do
        targ_sqr = board.send(:select_square_from_str, 'a2')
        expect do
          board.place_piece
        end.to change { targ_sqr.piece }.from(@piece).to(nil)
      end
    end

    context 'when destination is invalid' do
      before do
        target = 'a2'
        destination = 'a5'
        board.arrange_pieces
        board.update_targ_and_dest(target: target, destination: destination)
        @piece = board.instance_variable_get(:@selected_square).piece
      end

      it 'does not move piece to destination square' do
        dest_sqr = board.send(:select_square_from_str, 'a5')
        expect do
          board.place_piece
        end.to_not change { dest_sqr.piece }
      end

      it 'does not mark piece as moved' do
        expect do
          board.place_piece
        end.to_not change { @piece.moved? }
      end

      it 'leaves piece position unchanged' do
        targ_sqr = board.send(:select_square_from_str, 'a2')
        expect do
          board.place_piece
        end.to_not change { targ_sqr.piece }
      end
    end
  end

  describe '#can_promote?' do
    context 'when there is no pawn to promote' do
      before do
        fen_str = 'rnbqkb1r/1p2ppPp/2p2p2/1pR5/N2p3n/8/PPPPPP1P/1NBQKB1R w Kkq - 0 1'
        board.arrange_pieces_from_fen(fen_str)
      end

      it 'returns false' do
        expect(board.can_promote?).to be false
      end
    end

    context 'when there is a white pawn to promote' do
      before do
        fen_str = 'rnbqkbPr/1p2pp1p/2p2p2/1pR5/N2p3n/8/PPPPPP1P/1NBQKB1R w Kkq - 0 1'
        board.arrange_pieces_from_fen(fen_str)
      end

      it 'returns true' do
        expect(board.can_promote?).to be true
      end
    end

    context 'when there is a black pawn to promote' do
      before do
        fen_str = 'rnbqkb1r/1p3pPp/2p2p2/1pR5/N2p3n/2PR4/PPPPP1P1/1NBQKB1p w kq - 0 1'
        board.arrange_pieces_from_fen(fen_str)
      end

      it 'returns true' do
        expect(board.can_promote?).to be true
      end
    end
  end

  describe '#promote_pawn' do
    context 'for queening a black pawn at h1' do
      before do
        fen_str = 'rnbqkb1r/1p3pPp/2p2p2/1pR5/N2p3n/2PR4/PPPPP1P1/1NBQKB1p w kq - 0 1'
        board.arrange_pieces_from_fen(fen_str)
      end

      it 'replaces it with a black queen' do
        square = board.square_at_position(Position.for('h1'))
        choice = 'q'
        board.promote_pawn(choice: choice)
        exp_pc_letter = 'q'
        expect(square.piece.letter).to eql(exp_pc_letter)
      end
    end

    context 'for queening a white pawn at g8' do
      before do
        fen_str = 'rnbqkbPr/1p3p1p/2p2p2/1pR5/N2p3n/2PR4/PPPPP1Pp/1NBQKB2 w kq - 0 1'
        board.arrange_pieces_from_fen(fen_str)
      end

      it 'replaces it with a white queen' do
        square = board.square_at_position(Position.for('g8'))
        choice = 'Q'
        board.promote_pawn(choice: choice)
        exp_pc_letter = 'Q'
        expect(square.piece.letter).to eql(exp_pc_letter)
      end
    end

    context 'for promoting a white pawn at g8 to knight' do
      before do
        fen_str = 'rnbqkbPr/1p3p1p/2p2p2/1pR5/N2p3n/2PR4/PPPPP1Pp/1NBQKB2 w kq - 0 1'
        board.arrange_pieces_from_fen(fen_str)
      end

      it 'replaces it with a white knight' do
        square = board.square_at_position(Position.for('g8'))
        choice = 'N'
        board.promote_pawn(choice: choice)
        exp_pc_letter = 'N'
        expect(square.piece.letter).to eql(exp_pc_letter)
      end
    end

    context 'for promoting a black pawn at h1 to rook' do
      before do
        fen_str = 'rnbqkb1r/1p3pPp/2p2p2/1pR5/N2p3n/2PR4/PPPPP1P1/1NBQKB1p w kq - 0 1'
        board.arrange_pieces_from_fen(fen_str)
      end

      it 'replaces it with a black rook' do
        square = board.square_at_position(Position.for('h1'))
        choice = 'r'
        board.promote_pawn(choice: choice)
        exp_pc_letter = 'r'
        expect(square.piece.letter).to eql(exp_pc_letter)
      end
    end
  end

  describe '#king_in_check?' do
    context 'when black king is in check' do
      before do
        fen_str = 'rnbqkbnr/p1p1ppp1/3p1N1p/1p6/8/8/PPPPPPPP/R1BQKBNR w KQkq - 0 1'
        board.arrange_pieces_from_fen(fen_str)
      end

      it 'returns true' do
        result = board.king_in_check?
        expect(result).to be true
      end
    end

    context 'when there is no king in check' do
      before do
        fen_str = 'rnbqkbnr/p1p1pp2/3p1p1p/1p6/8/8/PPPPPPPP/R1BQKBNR w KQkq - 0 1'
        board.arrange_pieces_from_fen(fen_str)
      end

      it 'returns false' do
        result = board.king_in_check?
        expect(result).to be false
      end
    end

    context 'when white king is in check' do
      before do
        fen_str = 'r1bqkbnr/p1p1pppp/3p4/p7/2P4P/P4n2/1P1PPPP1/R1BQKBNR w KQkq - 0 1'
        board.arrange_pieces_from_fen(fen_str)
      end

      it 'returns true' do
        result = board.king_in_check?
        expect(result).to be true
      end
    end
  end

  describe '#checked_king' do
    context 'when black king is in check' do
      before do
        fen_str = 'rnbqkbnr/p1p1ppp1/3p1N1p/1p6/8/8/PPPPPPPP/R1BQKBNR w KQkq - 0 1'
        board.arrange_pieces_from_fen(fen_str)
      end

      it 'returns the black king' do
        piece = board.checked_king
        pl = piece.letter
        expect(pl).to eql('k')
      end
    end

    context 'when white king is in check' do
      before do
        fen_str = 'r1bqkbnr/p1p1pppp/3p4/p7/2P4P/P4n2/1P1PPPP1/R1BQKBNR w KQkq - 0 1'
        board.arrange_pieces_from_fen(fen_str)
      end

      it 'returns the white king' do
        piece = board.checked_king
        pl = piece.letter
        expect(pl).to eql('K')
      end
    end
  end

  describe '#checkmate?' do
    context 'when black king is checkmated' do
      before do
        fen_str = '3R2k1/5ppp/8/8/8/8/5PPP/6K1 w - - 0 1'
        board.arrange_pieces_from_fen(fen_str)
      end

      it 'returns true' do
        expect(board.checkmate?).to be true
      end
    end
  end
end

