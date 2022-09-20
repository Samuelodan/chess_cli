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
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 7
        expect(move_count).to eql(exp_count)
      end

      it 'f1 bishop has 5 moves' do
        pos = Position.for('f1')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 5
        expect(move_count).to eql(exp_count)
      end

      it 'h6 bishop has 3 moves' do
        pos = Position.for('h6')
        piece = board.square_at_position(pos).piece
        piece.update_position(pos)
        piece.update_board(board)
        move_count = piece.valid_moves.length
        exp_count = 3
        expect(move_count).to eql(exp_count)
      end
    end
  end
end
