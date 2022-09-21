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
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 2
        expect(move_count).to eql(exp_count)
      end

      it '(already moved) g3 pawn has 2 moves' do
        pos = Position.for('g3')
        piece = board.square_at_position(pos).piece
        piece.moved
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 2
        expect(move_count).to eql(exp_count)
      end

      it 'd2 pawn has 1 moves' do
        pos = Position.for('d2')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 1
        expect(move_count).to eql(exp_count)
      end

      it '(already moved) a5 pawn has 2 moves' do
        pos = Position.for('a5')
        piece = board.square_at_position(pos).piece
        piece.moved
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 2
        expect(move_count).to eql(exp_count)
      end
    end
  end
end
