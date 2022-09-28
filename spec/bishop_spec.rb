# frozen_string_literal: true

require_relative '../lib/rook'

RSpec.describe Bishop do
  let(:board) { Board.new }

  describe '#valid_moves' do
    context 'for fen string 1' do
      before do
        fen_str1 = 'rnbqk1nr/pppppp1p/7b/8/5p2/2B1P3/PPPP1PPP/RN1QKBNR w KQkq - 0 1'
        board.arrange_pieces_from_fen(fen_str1)
      end

      it 'c3 bishop has 7 moves' do
        pos = Position.for('c3')
        piece = board.square_at_position(pos).piece
        move_count = piece.valid_moves.length
        exp_count = 7
        expect(move_count).to eql(exp_count)
      end

      it 'f1 bishop has 5 moves' do
        pos = Position.for('f1')
        piece = board.square_at_position(pos).piece
        move_count = piece.valid_moves.length
        exp_count = 5
        expect(move_count).to eql(exp_count)
      end

      it 'h6 bishop has 3 moves' do
        pos = Position.for('h6')
        piece = board.square_at_position(pos).piece
        move_count = piece.valid_moves.length
        exp_count = 3
        expect(move_count).to eql(exp_count)
      end

      it 'c8 bishop has zero moves' do
        pos = Position.for('c8')
        piece = board.square_at_position(pos).piece
        move_count = piece.valid_moves.length
        exp_count = 0
        expect(move_count).to eql(exp_count)
      end
    end

    context 'for fen string 2' do
      before do
        fen_str1 = 'r2qk2r/pppppppp/n2b4/7n/3b4/3BPB1P/PPPP1P1P/RN1QK1NR w KQkq - 0 1'
        board.arrange_pieces_from_fen(fen_str1)
      end

      it 'd3 bishop has 9 moves' do
        pos = Position.for('d3')
        piece = board.square_at_position(pos).piece
        move_count = piece.valid_moves.length
        exp_count = 9
        expect(move_count).to eql(exp_count)
      end

      it 'f3 bishop has 8 moves' do
        pos = Position.for('f3')
        piece = board.square_at_position(pos).piece
        move_count = piece.valid_moves.length
        exp_count = 8
        expect(move_count).to eql(exp_count)
      end

      it 'd4 bishop has 7 moves' do
        pos = Position.for('d4')
        piece = board.square_at_position(pos).piece
        move_count = piece.valid_moves.length
        exp_count = 7
        expect(move_count).to eql(exp_count)
      end

      it 'd6 bishop has 7 moves' do
        pos = Position.for('d6')
        piece = board.square_at_position(pos).piece
        move_count = piece.valid_moves.length
        exp_count = 7
        expect(move_count).to eql(exp_count)
      end
    end
  end

  describe '#symbol' do
    context 'for white bishop' do
      it 'returns the correct symbol' do
        piece = Piece.for('B')
        exp_sym = "\u2657"
        expect(piece.symbol).to eql(exp_sym)
      end
    end

    context 'for black bishop' do
      it 'returns the correct symbol' do
        piece = Piece.for('b')
        exp_sym = "\u265d"
        expect(piece.symbol).to eql(exp_sym)
      end
    end
  end

  describe '#attack_moves' do
    context 'for fen string 1' do
      before do
        fen_str1 = 'rn1qkbnr/p4ppp/bp2p3/p7/1B6/1Pp3PB/P1PPPP1P/RN1QK1NR w KQkq - 0 1'
        board.arrange_pieces_from_fen(fen_str1)
      end

      it 'b4 bishop has 3 attack moves' do
        pos = Position.for('b4')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.attack_moves.length
        exp_count = 3
        expect(move_count).to eql(exp_count)
      end

      it 'h3 bishop has 1 attack move' do
        pos = Position.for('h3')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.attack_moves.length
        exp_count = 1
        expect(move_count).to eql(exp_count)
      end

      it 'a6 bishop has 1 attack moves' do
        pos = Position.for('a6')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.attack_moves.length
        exp_count = 1
        expect(move_count).to eql(exp_count)
      end

      it 'f8 bishop has 1 attack moves' do
        pos = Position.for('f8')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.attack_moves.length
        exp_count = 1
        expect(move_count).to eql(exp_count)
      end
    end
  end
end

