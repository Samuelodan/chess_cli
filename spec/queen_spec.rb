# frozen_string_literal: true

require_relative '../lib/queen'

RSpec.describe Queen do
  let(:board) { Board.new }

  describe '#valid_moves' do
    context 'for fen string 1' do
      before do
        fen_str1 = 'rnb1kbnr/pppppppp/6q1/8/3Q4/8/PPPPPPPP/RNB1KBNR w KQkq - 0 1'
        board.arrange_pieces_from_fen(fen_str1)
      end

      it 'd4 queen has 19 moves' do
        pos = Position.for('d4')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 19
        expect(move_count).to eql(exp_count)
      end

      it 'g6 queen has 16 moves' do
        pos = Position.for('g6')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
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
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 14
        expect(move_count).to eql(exp_count)
      end
    end
  end
end
