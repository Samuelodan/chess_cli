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
end

