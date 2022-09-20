# frozen_string_literal: true
require_relative './piece'
require_relative './board'

# rook subclass
class Rook < Piece
  def symbol
    sym = color == :white ? "\u2656" : "\u265c"
  end

  def self.handles?(letter)
    letter == 'r'
  end

  def directions
    [
      %i[continue_up], %i[continue_down],
      %i[continue_left], %i[continue_right]
    ]
  end
end

