# frozen_string_literal: true

require_relative './piece'

# king subclass
class King < Piece
  def symbol
    sym = color == :white ? "\u2654" : "\u265a"
  end

  def self.handles?(letter)
    letter == 'k'
  end

  def directions
    [
      %i[up], %i[top_right],
      %i[right], %i[bottom_right],
      %i[down], %i[bottom_left],
      %i[left], %i[top_left],
    ]
  end
end

