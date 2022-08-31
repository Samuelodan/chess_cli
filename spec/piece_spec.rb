# frozen_string_literal: true

require_relative '../lib/piece'

RSpec.describe Piece do
  subject(:piece) { described_class.new(letter: 'N') }

  describe '#moved?' do
    context 'when piece has not moved' do
      it 'returns false' do
        result = piece.moved?
        expect(result).to be(false)
      end
    end
    context 'when piece has moved' do
      before do
        piece.moved = true
      end

      it 'returns true' do
        result = piece.moved?
        expect(result).to be(true)
      end
    end
  end
end

