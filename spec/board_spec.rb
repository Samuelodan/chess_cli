# frozen_string_literal: true

require_relative '../lib/board'

RSpec.describe Board do
  subject(:board) { described_class.new }

  describe '#is_move_valid?' do
    context "when destination is not among piece's moves" do
      before do
        board.arrange_pieces
        pc_moves = [Position.for('a3'), Position.for('a4'), Position.for('b3')]
        dest_position = Position.for('a5')
        board.instance_variable_set(:@sel_pc_moves, pc_moves)
        board.instance_variable_set(:@destination_position, dest_position)
      end

      it 'returns false' do
        result = board.is_move_valid?
        expect(result).to be false
      end
    end
  end
end

