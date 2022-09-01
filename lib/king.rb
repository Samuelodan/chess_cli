# frozen_string_literal: true
require_relative './piece'

# king subclass
class King < Piece
  def symbol
    sym = color == :white ? "\u2654" : "\u265a"
  end

  def self.handles?(letter)
    letter == 'k'
  end
end

