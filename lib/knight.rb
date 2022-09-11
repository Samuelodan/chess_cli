# frozen_string_literal: true
require_relative './piece'

# subclass of Piece
class Knight < Piece
  def symbol
    sym = color == :white ? "\u2658" : "\u265e"
  end

  def self.handles?(letter)
    letter == 'n'
  end

  def directions
    [
      [-2, -1], [+2, -1], [-2, +1], [+2, +1],
      [-1, +2], [-1, -2], [+1, +2], [+1, -2]
    ]
  end
end
