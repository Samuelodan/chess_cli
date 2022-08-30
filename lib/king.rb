# frozen_string_literal: true

# king subclass
class King < Piece
  def symbol
    sym = color == :white ? "\u2654" : "\u265a"
  end
end

