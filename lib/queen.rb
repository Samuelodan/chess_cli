# frozen_string_literal: true

# queen subclass
class Queen < Piece
  def symbol
    sym = color == :white ? "\u2655" : "\u265b"
  end
end

