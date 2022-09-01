# frozen_string_literal: true
require_relative './piece'

# pawn subclass
class Pawn < Piece
  def symbol
    sym = color == :white ? "\u2659" : "\u265f"
  end

  def self.handles?(letter)
    letter == 'p'
  end
end

