# frozen_string_literal: true
require_relative './piece'

# rook subclass
class Rook < Piece
  def symbol
    sym = color == :white ? "\u2656" : "\u265c"
  end
end

