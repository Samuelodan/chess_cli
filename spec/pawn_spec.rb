# frozen_string_literal: true

require_relative '../lib/pawn'

RSpec.describe Pawn do
  let(:board) { Board.new }

  describe '#valid_moves' do
    context 'for fen string 1' do
      before do
        fen_str1 = 'rnbqkb1r/1p2pppp/2p5/p1R5/1N1p1n2/6P1/PPPPPP1P/1NBQKB1R w Kkq - 0 1'
        board.arrange_pieces_from_fen(fen_str1)
      end

      it 'h2 pawn has 2 moves' do
        pos = Position.for('h2')
        piece = board.square_at_position(pos).piece
        move_count = piece.valid_moves.length
        exp_count = 2
        expect(move_count).to eql(exp_count)
      end

      it '(already moved) g3 pawn has 2 moves' do
        pos = Position.for('g3')
        piece = board.square_at_position(pos).piece
        piece.moved
        move_count = piece.valid_moves.length
        exp_count = 2
        expect(move_count).to eql(exp_count)
      end

      it 'd2 pawn has 1 moves' do
        pos = Position.for('d2')
        piece = board.square_at_position(pos).piece
        move_count = piece.valid_moves.length
        exp_count = 1
        expect(move_count).to eql(exp_count)
      end

      it '(already moved) a5 pawn has 2 moves' do
        pos = Position.for('a5')
        piece = board.square_at_position(pos).piece
        piece.moved
        move_count = piece.valid_moves.length
        exp_count = 2
        expect(move_count).to eql(exp_count)
      end

      it '(already moved) c6 pawn has 0 moves' do
        pos = Position.for('c6')
        piece = board.square_at_position(pos).piece
        piece.moved
        move_count = piece.valid_moves.length
        exp_count = 0
        expect(move_count).to eql(exp_count)
      end

      it 'f7 pawn has 2 moves' do
        pos = Position.for('f7')
        piece = board.square_at_position(pos).piece
        move_count = piece.valid_moves.length
        exp_count = 2
        expect(move_count).to eql(exp_count)
      end
    end

    context 'for fen string 2' do
      before do
        fen_str2 = 'rnbqkb1r/1p2pppp/2p5/1pR5/N2p3n/6P1/PPPPPP1P/1NBQKB1R w Kkq - 0 1'
        board.arrange_pieces_from_fen(fen_str2)
      end

      it '(already moved) b5 pawn has 2 moves' do
        pos = Position.for('b5')
        piece = board.square_at_position(pos).piece
        piece.moved
        move_count = piece.valid_moves.length
        exp_count = 2
        expect(move_count).to eql(exp_count)
      end

      it '(already moved) g3 pawn has 2 moves' do
        pos = Position.for('g3')
        piece = board.square_at_position(pos).piece
        piece.moved
        move_count = piece.valid_moves.length
        exp_count = 2
        expect(move_count).to eql(exp_count)
      end
    end
  end

  describe '#symbol' do
    context 'for white pawn' do
      it 'returns the correct symbol' do
        piece = Piece.for('P')
        exp_sym = "\u2659"
        expect(piece.symbol).to eql(exp_sym)
      end
    end

    context 'for black pawn' do
      it 'returns the correct symbol' do
        piece = Piece.for('p')
        exp_sym = "\u265f"
        expect(piece.symbol).to eql(exp_sym)
      end
    end
  end

  describe '#attack_moves' do
    context 'for fen string 1' do
      before do
        fen_str1 = 'rnbqkbn1/p3pp1p/1N5P/4r3/pppPp3/1P4P1/2PPPP2/R1BQKBNR w KQq - 0 1'
        board.arrange_pieces_from_fen(fen_str1)
      end

      it 'b3 bishop has 2 attack moves' do
        pos = Position.for('b3')
        piece = board.square_at_position(pos).piece
        move_count = piece.attack_moves.length
        exp_count = 2
        expect(move_count).to eql(exp_count)
      end

      it 'd4 bishop has 1 attack move' do
        pos = Position.for('d4')
        piece = board.square_at_position(pos).piece
        move_count = piece.attack_moves.length
        exp_count = 1
        expect(move_count).to eql(exp_count)
      end

      it 'a7 bishop has 1 attack moves' do
        pos = Position.for('a7')
        piece = board.square_at_position(pos).piece
        move_count = piece.attack_moves.length
        exp_count = 1
        expect(move_count).to eql(exp_count)
      end

      it 'c4 bishop has 1 attack moves' do
        pos = Position.for('c4')
        piece = board.square_at_position(pos).piece
        move_count = piece.attack_moves.length
        exp_count = 1
        expect(move_count).to eql(exp_count)
      end
    end
  end

  describe '#legal_moves' do
    context 'for fen string 1' do
      before do
        fen_str1 = '8/3q4/4k3/8/2P3P1/7B/8/3K4 w - - 0 1'
        board.arrange_pieces_from_fen(fen_str1)
      end

      it 'c4 pawn has zero moves' do
        pos = Position.for('c4')
        piece = board.square_at_position(pos).piece
        move_count = piece.legal_moves.length
        exp_count = 0
        expect(move_count).to eql(exp_count)
      end

      it 'g4 pawn has zero moves' do
        pos = Position.for('g4')
        piece = board.square_at_position(pos).piece
        move_count = piece.legal_moves.length
        exp_count = 0
        expect(move_count).to eql(exp_count)
      end
    end

    context 'for fen string 1' do
      before do
        fen_str1 = '8/3q4/8/4k3/3P2P1/7B/8/3K4 w - - 0 1'
        board.arrange_pieces_from_fen(fen_str1)
      end

      it '(already moved) d4 pawn has 1 moves' do
        pos = Position.for('d4')
        piece = board.square_at_position(pos).piece
        piece.moved
        move_count = piece.legal_moves.length
        exp_count = 1
        expect(move_count).to eql(exp_count)
      end
    end
  end
end

