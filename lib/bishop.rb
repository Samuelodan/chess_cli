# frozen_string_literal: true

# bishop subclass
class Bishop > Piece
  def symbol
    sym = color == :white ? "\u2657" : "\u265d"
  end
end

