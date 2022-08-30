# frozen_string_literal: true

# pawn subclass
class Pawn
  def symbol
    sym = color == :white ? "\u2659" : "\u265f"
  end
end
