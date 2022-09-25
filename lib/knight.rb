# frozen_string_literal: true

require_relative './piece'
require_relative './board'

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
      %i[up up left], %i[up up right],
      %i[right right up], %i[right right down],
      %i[down down right], %i[down down left],
      %i[left left down], %i[left left up]
    ]
  end
end

