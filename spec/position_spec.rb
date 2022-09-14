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

    context 'when position is highest rank' do
      it 'returns the same object without incrementing' do
        pos = Position.new(file: 'e', rank: 8)
        expected_pos = Position.new(file: 'e', rank: 8)
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

    context 'when position is lowest rank' do
      it 'returns the same object without decrement' do
        pos = Position.new(file: 'e', rank: 1)
        expected_pos = Position.new(file: 'e', rank: 1)
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
end

