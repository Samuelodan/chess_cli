# frozen_string_literal: true

# subclass of Piece
class Knight < Piece
  def symbol
    sym = color == :white ? "\u2658" : "\u265e"
  end
end
