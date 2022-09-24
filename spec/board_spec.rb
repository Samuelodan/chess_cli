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

    context "when destination can be found among piece's moves" do
      before do
        board.arrange_pieces
        pc_moves = [Position.for('a3'), Position.for('a4'), Position.for('b3')]
        dest_position = Position.for('b3')
        board.instance_variable_set(:@sel_pc_moves, pc_moves)
        board.instance_variable_set(:@destination_position, dest_position)
      end

      it 'returns true' do
        result = board.is_move_valid?
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

    it 'updates piece position' do
      target = 'a2'
      destination = 'a4'
      targ_sqr = board.square_at_position(Position.for(target))
      sqr_pos = targ_sqr.position
      piece = targ_sqr.piece
      expect do
        board.update_targ_and_dest(target: target, destination: destination)
      end.to change { piece.position }.from(nil).to(sqr_pos)
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
end

