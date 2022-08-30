# frozen_string_literal: true

# rook subclass
class Rook < Piece
  def symbol
    sym = color == :white ? "\u2656" : "\u265c"
  end
end

