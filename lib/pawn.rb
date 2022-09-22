# frozen_string_literal: true

require_relative './piece'
require_relative './board'

# pawn subclass
class Pawn < Piece

  def symbol
    sym = color == :white ? "\u2659" : "\u265f"
  end

  def self.handles?(letter)
    letter == 'p'
  end

  def directions
    return [ %i[up], %i[up up] ] unless moved?

    [ %i[up] ]
  end

  def enemy_at_top_right?
    tr = @position.top_right
    square_at_tr = board.square_at_position(tr)
    return false unless square_at_tr
    piece_at_tr = square_at_tr.piece
    return false if piece_at_tr.nil? || piece_at_tr.color == color

    true
  end
end

