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

  describe '#determine_color' do
    context 'when letter is lowercase' do
      before do
        piece.letter = 'n'
      end

      it 'returns :black' do
        result = piece.determine_color
        expect(result).to eq(:black)
      end

      it 'does not return :white' do
        result = piece.determine_color
        expect(result).to_not eq(:white)
      end
    end
  end
end

