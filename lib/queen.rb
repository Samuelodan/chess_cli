# frozen_string_literal: true

require_relative './piece'

# queen subclass
class Queen < Piece
  def symbol
    sym = color == :white ? "\u2655" : "\u265b"
  end

  def self.handles?(letter)
    letter == 'q'
  end
end

