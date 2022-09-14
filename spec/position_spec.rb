# frozen_string_literal: true

require_relative '../lib/position'

RSpec.describe Position do
  subject(:position) { described_class.new(file: 'a', rank: 1) }

  describe '#==' do
    context 'when position objects have same values' do
      it 'returns true' do
        pos1 = Position.new(file: 'a', rank: 1)
        pos2 = Position.new(file: 'a', rank: 1)
        expect(pos1).to eq(pos2)
      end

      it 'returns false' do
        pos1 = Position.new(file: 'h', rank: 1)
        pos2 = Position.new(file: 'a', rank: 1)
        expect(pos1).to_not eq(pos2)
      end
    end
  end

  describe '#up' do
    context 'when position is c4' do
      it 'returns c5 position object' do
        pos = Position.new(file: 'c', rank: 4)
        expected_pos = Position.new(file: 'c', rank: 5)
        new_pos = pos.up
        expect(new_pos).to eq(expected_pos)
      end
    end

    context 'when position is b1' do
      it 'returns b2 position object' do
        pos = Position.new(file: 'b', rank: 1)
        expected_pos = Position.new(file: 'b', rank: 2)
        new_pos = pos.up
        expect(new_pos).to eq(expected_pos)
      end
    end
  end
end

