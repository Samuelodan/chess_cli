# frozen_string_literal: true
require_relative './piece'
require_relative './board'

# bishop subclass
class Bishop < Piece
  def symbol
    sym = color == :white ? "\u2657" : "\u265d"
  end

  def self.handles?(letter)
    letter == 'b'
  end

  def directions
    [
      %i[continue_top_right], %i[continue_bottom_right],
      %i[continue_bottom_left], %i[continue_top_left]
    ]
  end
end

