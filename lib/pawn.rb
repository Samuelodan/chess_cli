# frozen_string_literal: true

# pawn subclass
class Pawn < Piece
  def symbol
    sym = color == :white ? "\u2659" : "\u265f"
  end
end

