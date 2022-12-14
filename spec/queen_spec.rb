# frozen_string_literal: true

require_relative '../lib/queen'

RSpec.describe Queen do
  let(:board) { Board.new }

  describe '#pseudolegal_moves' do
    context 'for fen string 1' do
      before do
        fen_str1 = 'rnb1kbnr/pppppppp/6q1/8/3Q4/8/PPPPPPPP/RNB1KBNR w KQkq - 0 1'
        board.arrange_pieces_from_fen(fen_str1)
      end

      it 'd4 queen has 19 moves' do
        pos = Position.for('d4')
        piece = board.square_at_position(pos).piece
        move_count = piece.pseudolegal_moves.length
        exp_count = 19
        expect(move_count).to eql(exp_count)
      end

      it 'g6 queen has 16 moves' do
        pos = Position.for('g6')
        piece = board.square_at_position(pos).piece
        move_count = piece.pseudolegal_moves.length
        exp_count = 16
        expect(move_count).to eql(exp_count)
      end
    end

    context 'for fen string 2' do
      before do
        fen_str2 = 'rnb1kbnr/pppp2pp/1P2p3/P3p2q/2B5/3Q1PP1/1PPP3P/RNB1K1NR w KQkq - 0 1'
        board.arrange_pieces_from_fen(fen_str2)
      end

      it 'd3 queen has 14 moves' do
        pos = Position.for('d3')
        piece = board.square_at_position(pos).piece
        move_count = piece.pseudolegal_moves.length
        exp_count = 14
        expect(move_count).to eql(exp_count)
      end

      it 'h5 queen has 10 moves' do
        pos = Position.for('h5')
        piece = board.square_at_position(pos).piece
        move_count = piece.pseudolegal_moves.length
        exp_count = 10
        expect(move_count).to eql(exp_count)
      end
    end
  end

  describe '#symbol' do
    context 'for white queen' do
      it 'returns the correct symbol' do
        piece = Piece.for('Q')
        exp_sym = "\u2655"
        expect(piece.symbol).to eql(exp_sym)
      end
    end

    context 'for black queen' do
      it 'returns the correct symbol' do
        piece = Piece.for('q')
        exp_sym = "\u265b"
        expect(piece.symbol).to eql(exp_sym)
      end
    end
  end

  describe '#attack_moves' do
    context 'for fen string 1' do
      before do
        fen_str1 = 'rnb1kbnr/p2p1ppp/2p1p3/P5q1/1p1Q4/2P5/1PP1PPPP/RNB1KBNR w KQkq - 0 1'
        board.arrange_pieces_from_fen(fen_str1)
      end

      it 'd4 queen has 4 attack moves' do
        pos = Position.for('d4')
        piece = board.square_at_position(pos).piece
        move_count = piece.attack_moves.length
        exp_count = 4
        expect(move_count).to eql(exp_count)
      end

      it 'g5 queen has 3 attack move' do
        pos = Position.for('g5')
        piece = board.square_at_position(pos).piece
        move_count = piece.attack_moves.length
        exp_count = 3
        expect(move_count).to eql(exp_count)
      end
    end
  end

  describe '#legal_moves' do
    context 'for fen string 1' do
      before do
        fen_str1 = '8/8/8/8/4Q3/2n5/8/1K6 w - - 0 1'
        board.arrange_pieces_from_fen(fen_str1)
      end

      it 'e4 queen has zero moves' do
        pos = Position.for('e4')
        piece = board.square_at_position(pos).piece
        move_count = piece.legal_moves.length
        exp_count = 0
        expect(move_count).to eql(exp_count)
      end
    end
  end
end

