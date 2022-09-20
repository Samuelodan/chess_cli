# frozen_string_literal: true

require_relative './piece'
require_relative './board'

# queen subclass
class Queen < Piece
  def symbol
    sym = color == :white ? "\u2655" : "\u265b"
  end

  def self.handles?(letter)
    letter == 'q'
  end

  def directions
    [
      %i[continue_up], %i[continue_right],
      %i[continue_down], %i[continue_left],
      %i[continue_top_right], %i[continue_bottom_right],
      %i[continue_bottom_left], %i[continue_top_left]
    ]
  end
end

