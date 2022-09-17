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
    end
  end
end

