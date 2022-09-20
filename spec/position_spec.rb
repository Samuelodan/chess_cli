# frozen_string_literal: true

require_relative '../lib/position'

RSpec.describe Position do
  subject(:position) { described_class.new(file: 'a', rank: 1) }

  describe '#eql?' do
    context 'when position objects have same values' do
      it 'returns true' do
        pos1 = Position.new(file: 'a', rank: 1)
        pos2 = Position.new(file: 'a', rank: 1)
        expect(pos1).to eql(pos2)
      end

      it 'returns false' do
        pos1 = Position.new(file: 'h', rank: 1)
        pos2 = Position.new(file: 'a', rank: 1)
        expect(pos1).to_not eql(pos2)
      end
    end
  end

  describe '#up' do
    context 'when position is c4' do
      it 'returns c5 position object' do
        pos = Position.new(file: 'c', rank: 4)
        expected_pos = Position.new(file: 'c', rank: 5)
        new_pos = pos.up
        expect(new_pos).to eql(expected_pos)
      end
    end

    context 'when position is b1' do
      it 'returns b2 position object' do
        pos = Position.new(file: 'b', rank: 1)
        expected_pos = Position.new(file: 'b', rank: 2)
        new_pos = pos.up
        expect(new_pos).to eql(expected_pos)
      end
    end
  end

  describe '#down' do
    context 'when position is c4' do
      it 'returns c3 position object' do
        pos = Position.new(file: 'c', rank: 4)
        expected_pos = Position.new(file: 'c', rank: 3)
        new_pos = pos.down
        expect(new_pos).to eql(expected_pos)
      end
    end

    context 'when position is b2' do
      it 'returns b1 position object' do
        pos = Position.new(file: 'b', rank: 2)
        expected_pos = Position.new(file: 'b', rank: 1)
        new_pos = pos.down
        expect(new_pos).to eql(expected_pos)
      end
    end
  end

  describe '#left' do
    context 'when position is c4' do
      it 'returns b4 position object' do
        pos = Position.new(file: 'c', rank: 4)
        expected_pos = Position.new(file: 'b', rank: 4)
        new_pos = pos.left
        expect(new_pos).to eql(expected_pos)
      end
    end

    context 'when position is b5' do
      it 'returns a5 position object' do
        pos = Position.new(file: 'b', rank: 5)
        expected_pos = Position.new(file: 'a', rank: 5)
        new_pos = pos.left
        expect(new_pos).to eql(expected_pos)
      end
    end
  end

  describe '#right' do
    context 'when position is f5' do
      it 'returns g5 position object' do
        pos = Position.new(file: 'f', rank: 5)
        expected_pos = Position.new(file: 'g', rank: 5)
        new_pos = pos.right
        expect(new_pos).to eql(expected_pos)
      end
    end

    context 'when position is c7' do
      it 'returns d7 position object' do
        pos = Position.new(file: 'c', rank: 7)
        expected_pos = Position.new(file: 'd', rank: 7)
        new_pos = pos.right
        expect(new_pos).to eql(expected_pos)
      end
    end
  end

  describe 'Position.for' do
    context 'when string is a3' do
      it 'returns Position a3' do
        string = 'a3'
        expected_pos = Position.new(file: 'a', rank: 3)
        new_pos = Position.for(string)
        expect(new_pos).to eql(expected_pos)
      end
    end

    context 'when string is h7' do
      it 'returns Position h7' do
        string = 'h7'
        expected_pos = Position.new(file: 'h', rank: 7)
        new_pos = Position.for(string)
        expect(new_pos).to eql(expected_pos)
      end
    end

    context 'when an array of 2 position strings is supplied' do
      it 'returns array of position objects' do
        pos_str_arr = ['a2', 'd8']
        pos_1 = Position.new(file: 'a', rank: 2)
        pos_2 = Position.new(file: 'd', rank: 8)
        expected_pos = [pos_1, pos_2]
        new_pos = Position.for(pos_str_arr)
        expect(new_pos).to eql(expected_pos)
      end
    end

    context 'when an array of 1 position strings is supplied' do
      it 'returns array of the position object' do
        pos_str_arr = ['f5']
        pos_1 = Position.new(file: 'f', rank: 5)
        expected_pos = [pos_1]
        new_pos = Position.for(pos_str_arr)
        expect(new_pos).to eql(expected_pos)
      end
    end

    context 'when an array of 4 position strings is supplied' do
      it 'returns array of position objects' do
        pos_str_arr = ['a2', 'd8', 'c4', 'f6']
        pos_1 = Position.new(file: 'a', rank: 2)
        pos_2 = Position.new(file: 'd', rank: 8)
        pos_3 = Position.new(file: 'c', rank: 4)
        pos_4 = Position.new(file: 'f', rank: 6)
        expected_pos = [pos_1, pos_2, pos_3, pos_4]
        new_pos = Position.for(pos_str_arr)
        expect(new_pos).to eql(expected_pos)
      end
    end
  end

  describe '#continue_up' do
    context 'when position is c4' do
      it 'returns all positions up' do
        pos = Position.new(file: 'c', rank: 4)
        expected_pos = Position.for(['c5', 'c6', 'c7', 'c8'])
        new_pos = pos.continue_up
        expect(new_pos).to eql(expected_pos)
      end
    end

    context 'when position is f6' do
      it 'returns all positions up' do
        pos = Position.new(file: 'f', rank: 6)
        expected_pos = Position.for(['f7', 'f8'])
        new_pos = pos.continue_up
        expect(new_pos).to eql(expected_pos)
      end
    end

    context 'when in topmost position' do
      it 'returns an empty array' do
        pos = Position.new(file: 'f', rank: 8)
        expected_pos = []
        new_pos = pos.continue_up
        expect(new_pos).to eql(expected_pos)
      end
    end
  end

  describe '#continue_down' do
    context 'when position is c4' do
      it 'returns all positions down' do
        pos = Position.new(file: 'c', rank: 4)
        expected_pos = Position.for(['c3', 'c2', 'c1'])
        new_pos = pos.continue_down
        expect(new_pos).to eql(expected_pos)
      end
    end

    context 'when position is f6' do
      it 'returns all positions down' do
        pos = Position.new(file: 'f', rank: 6)
        expected_pos = Position.for(['f5', 'f4', 'f3', 'f2', 'f1'])
        new_pos = pos.continue_down
        expect(new_pos).to eql(expected_pos)
      end
    end

    context 'when in bottom-most position' do
      it 'returns an empty array' do
        pos = Position.new(file: 'f', rank: 1)
        expected_pos = []
        new_pos = pos.continue_down
        expect(new_pos).to eql(expected_pos)
      end
    end
  end

  describe '#continue_left' do
    context 'when position is c4' do
      it 'returns all positions to the left' do
        pos = Position.new(file: 'c', rank: 4)
        expected_pos = Position.for(['b4', 'a4'])
        new_pos = pos.continue_left
        expect(new_pos).to eql(expected_pos)
      end
    end

    context 'when position is f6' do
      it 'returns all positions to the left' do
        pos = Position.new(file: 'f', rank: 6)
        expected_pos = Position.for(['e6', 'd6', 'c6', 'b6', 'a6'])
        new_pos = pos.continue_left
        expect(new_pos).to eql(expected_pos)
      end
    end

    context 'when in leftmost position' do
      it 'returns an empty array' do
        pos = Position.new(file: 'a', rank: 6)
        expected_pos = []
        new_pos = pos.continue_left
        expect(new_pos).to eql(expected_pos)
      end
    end
  end

  describe '#continue_right' do
    context 'when position is c4' do
      it 'returns all positions to the right' do
        pos = Position.new(file: 'c', rank: 4)
        expected_pos = Position.for(['d4', 'e4', 'f4', 'g4', 'h4'])
        new_pos = pos.continue_right
        expect(new_pos).to eql(expected_pos)
      end
    end

    context 'when position is f6' do
      it 'returns all positions to the right' do
        pos = Position.new(file: 'f', rank: 6)
        expected_pos = Position.for(['g6', 'h6'])
        new_pos = pos.continue_right
        expect(new_pos).to eql(expected_pos)
      end
    end

    context 'when in rightmost position' do
      it 'returns an empty array' do
        pos = Position.new(file: 'h', rank: 6)
        expected_pos = []
        new_pos = pos.continue_right
        expect(new_pos).to eql(expected_pos)
      end
    end
  end

  describe '#top_right' do
    context 'when position is c4' do
      it 'returns all top right diagonal positions' do
        pos = Position.new(file: 'c', rank: 4)
        expected_pos = Position.for(['d5', 'e6', 'f7', 'g8'])
        new_pos = pos.top_right
        expect(new_pos).to eql(expected_pos)
      end
    end

    context 'when position is f6' do
      it 'returns all top right diagonal positions' do
        pos = Position.new(file: 'f', rank: 6)
        expected_pos = Position.for(['g7', 'h8'])
        new_pos = pos.top_right
        expect(new_pos).to eql(expected_pos)
      end
    end

    context 'when in topmost  position' do
      it 'returns an empty array' do
        pos = Position.new(file: 'f', rank: 8)
        expected_pos = []
        new_pos = pos.top_right
        expect(new_pos).to eql(expected_pos)
      end
    end
  end
end

