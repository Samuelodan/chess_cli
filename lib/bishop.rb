# frozen_string_literal: true
require_relative './piece'

# bishop subclass
class Bishop < Piece
  def symbol
    sym = color == :white ? "\u2657" : "\u265d"
  end

  def self.handles?(letter)
    letter == 'b'
  end
end

