# frozen_string_literal: true

require_relative '../lib/square'
require_relative '../lib/piece'

RSpec.describe Square do
  let(:piece) { double }
  let(:square) { described_class.new }

  describe '#draw_square' do
    context 'for black square and white knight' do
      before do
        square.color = :black
        square.piece = piece
        allow(piece).to receive(:symbol).and_return("\u2658")
      end

      specify do
        expect do
          square.draw_square
        end.to output("\e[48;2;181;136;99m\e[30m #{piece.symbol} \e[0m").to_stdout
      end
    end

    context 'for black square and black bishop' do
      before do
        square.color = :black
        square.piece = piece
        allow(piece).to receive(:symbol).and_return("\u265d")
      end

      specify do
        expect do
          square.draw_square
        end.to output("\e[48;2;181;136;99m\e[30m #{piece.symbol} \e[0m").to_stdout
      end
    end

    context 'for white square and black queen' do
      before do
        square.color = :white
        square.piece = piece
        allow(piece).to receive(:symbol).and_return("\u265b")
      end

      specify do
        expect do
          square.draw_square
        end.to output("\e[48;2;240;217;181m\e[30m #{piece.symbol} \e[0m").to_stdout
      end
    end

    context 'for white square and white pawn' do
      before do
        square.color = :white
        square.piece = piece
        allow(piece).to receive(:symbol).and_return("\u2659")
      end

      specify do
        expect do
          square.draw_square
        end.to output("\e[48;2;240;217;181m\e[30m #{piece.symbol} \e[0m").to_stdout
      end
    end

    context 'for white square and no piece' do
      before do
        square.color = :white
      end

      specify do
        expect do
          square.draw_square
        end.to output("\e[48;2;240;217;181m\e[30m   \e[0m").to_stdout
      end
    end
  end
end

