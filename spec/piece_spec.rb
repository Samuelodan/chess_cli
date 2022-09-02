# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/rook'
require_relative '../lib/knight'
require_relative '../lib/bishop.rb'
require_relative '../lib/queen.rb'
require_relative '../lib/king'
require_relative '../lib/pawn.rb'

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
        @this_piece = Piece.new(letter: 'n')
      end

      it 'returns :black' do
        result = @this_piece.determine_color
        expect(result).to eq(:black)
      end

      it 'does not return :white' do
        result = @this_piece.determine_color
        expect(result).to_not eq(:white)
      end
    end

    context 'when letter is uppercase' do
      before do
        @this_piece = Piece.new(letter: 'N')
      end

      it 'returns :white' do
        result = @this_piece.determine_color
        expect(result).to eq(:white)
      end

      it 'does not return :black' do
        result = @this_piece.determine_color
        expect(result).to_not eq(:black)
      end
    end
  end

  describe 'Piece.for(letter:)' do
    context 'for rook' do
      context "when letter is lowercase 'r'" do
        it 'returns a black rook object' do
          res_piece = Piece.for('r')
          is_black = res_piece.color == :black
          is_black_rook = res_piece.is_a?(Rook) && is_black
          expect(is_black_rook).to be(true)
        end
      end

      context "when letter is uppercase 'R'" do
        it 'returns a white rook object' do
          res_piece = Piece.for('R')
          is_white = res_piece.color == :white
          is_white_rook = res_piece.is_a?(Rook) && is_white
          expect(is_white_rook).to be(true)
        end
      end
    end

    context 'for knight' do
      context "when letter is lowercase 'n'" do
        it 'returns a black knight object' do
          res_piece = Piece.for('n')
          is_black = res_piece.color == :black
          is_black_knight = res_piece.is_a?(Knight) && is_black
          expect(is_black_knight).to be(true)
        end
      end

      context "when letter is uppercase 'N'" do
        it 'returns a white knight object' do
          res_piece = Piece.for('N')
          is_white = res_piece.color == :white
          is_white_rook = res_piece.is_a?(Knight) && is_white
          expect(is_white_rook).to be(true)
        end
      end
    end

    context 'for bishop' do
      context "when letter is lowercase 'b'" do
        it 'returns a black bishop object' do
          res_piece = Piece.for('b')
          is_black = res_piece.color == :black
          is_black_bishop = res_piece.is_a?(Bishop) && is_black
          expect(is_black_bishop).to be(true)
        end
      end
      context "when letter is uppercase 'B'" do
        it 'returns a white bishop object' do
          res_piece = Piece.for('B')
          is_white = res_piece.color == :white
          is_white_knight = res_piece.is_a?(Bishop) && is_white
          expect(is_white_knight).to be(true)
        end
      end
    end

    context 'for queen' do
      context "when letter is lowercase 'q'" do
        it 'returns a black queen object' do
          res_piece = Piece.for('q')
          is_black = res_piece.color == :black
          is_black_queen = res_piece.is_a?(Queen) && is_black
          expect(is_black_queen).to be(true)
        end
      end
      context "when letter is uppercase 'Q'" do
        it 'returns a white queen object' do
          res_piece = Piece.for('Q')
          is_white = res_piece.color == :white
          is_white_queen = res_piece.is_a?(Queen) && is_white
          expect(is_white_queen).to be(true)
        end
      end
    end

    context 'for king' do
      context "when letter is lowercase 'k'" do
        it 'returns a black king object' do
          res_piece = Piece.for('k')
          is_black = res_piece.color == :black
          is_black_king = res_piece.is_a?(King) && is_black
          expect(is_black_king).to be(true)
        end
      end

      context "when letter is uppercase 'K'" do
        it 'returns a white king object' do
          res_piece = Piece.for('K')
          is_white = res_piece.color == :white
          is_white_king = res_piece.is_a?(King) && is_white
          expect(is_white_king).to be(true)
        end
      end
    end

    context 'for pawn' do
      context "when letter is lowercase 'p'" do
        it 'returns a black pawn object' do
          res_piece = Piece.for('p')
          is_black = res_piece.color == :black
          is_black_pawn = res_piece.is_a?(Pawn) && is_black
          expect(is_black_pawn).to be(true)
        end
      end

      context "when letter is uppercase 'P'" do
        it 'returns a white pawn object' do
          res_piece = Piece.for('P')
          is_white = res_piece.color == :white
          is_white_pawn = res_piece.is_a?(Pawn) && is_white
          expect(is_white_pawn).to be(true)
        end
      end
    end
  end
end

