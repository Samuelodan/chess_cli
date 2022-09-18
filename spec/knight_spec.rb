# frozen_string_literal: true

require_relative '../lib/knight'

RSpec.describe Knight do
  let(:board) { Board.new }

  describe '#valid_moves' do
    context 'for fen string 1' do
      before do
        fen_str1 = 'rnbqkbnr/pppppppp/8/8/8/5N2/PPPPPPPP/RNBQKB1R w KQkq - 0 1'
        board.arrange_pieces_from_fen(fen_str1)
      end

      it 'f3 knight has 5 moves' do
        pos = Position.for('f3')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        move_count = piece.valid_moves(board: board).length
        exp_count = 5
        expect(move_count).to eql(exp_count)
      end

      it 'b1 knight has 2 moves' do
        pos = Position.for('b1')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        move_count = piece.valid_moves(board: board).length
        exp_count = 2
        expect(move_count).to eql(exp_count)
      end

      it 'b8 knight has 2 moves' do
        pos = Position.for('b8')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        move_count = piece.valid_moves(board: board).length
        exp_count = 2
        expect(move_count).to eql(exp_count)
      end

      it 'g8 knight has 2 moves' do
        pos = Position.for('g8')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        move_count = piece.valid_moves(board: board).length
        exp_count = 2
        expect(move_count).to eql(exp_count)
      end
    end

    context 'for fen string 2' do
      before do
        fen_str2 = 'r1bqkb1r/pppppppp/1n1N4/5P2/1P6/2n5/PPP1P1PP/RNBQKB1R w KQkq - 0 1'
        board.arrange_pieces_from_fen(fen_str2)
      end

      it 'c3 knight has 8 moves' do
        pos = Position.for('c3')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        move_count = piece.valid_moves(board: board).length
        exp_count = 8
        expect(move_count).to eql(exp_count)
      end

      it 'b1 knight has 3 moves' do
        pos = Position.for('b1')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        move_count = piece.valid_moves(board: board).length
        exp_count = 3
        expect(move_count).to eql(exp_count)
      end
    end
  end
end

