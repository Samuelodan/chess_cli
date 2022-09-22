# frozen_string_literal: true

require_relative './piece'
require_relative './board'

# pawn subclass
class Pawn < Piece
  def initialize(letter:)
    super
    @attack_positions = []
  end

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

  def white_pawn_moves
    @attack_positions.clear
    @attack_positions << @position.top_right if enemy_at_top_right?
    @attack_positions << @position.top_left if enemy_at_top_left?
    final_moves = [ %i[up] ]
    final_moves.push(%i[up up]) unless moved?
    final_moves
  end

  def black_pawn_moves
    @attack_positions.clear
    final_moves = [ %i[down] ]
    final_moves.push(%i[down down]) unless moved?
    @attack_positions << @position.bottom_left if enemy_at_black_top_right?
    @attack_positions << @position.bottom_right if enemy_at_black_top_left?
    final_moves
  end

  def enemy_at_top_right?
    tr = @position.top_right
    square_at_tr = board.square_at_position(tr)
    return false unless square_at_tr
    piece_at_tr = square_at_tr.piece
    return false if piece_at_tr.nil? || piece_at_tr.color == color

    true
  end

  def enemy_at_top_left?
    tl = @position.top_left
    square_at_tl = board.square_at_position(tl)
    return false unless square_at_tl
    piece_at_tl = square_at_tl.piece
    return false if piece_at_tl.nil? || piece_at_tl.color == color

    true
  end

  def enemy_at_black_top_right?
    # flipped to emulate pieces facing opposite directions
    tr = @position.bottom_left
    square_at_tr = board.square_at_position(tr)
    return false unless square_at_tr
    piece_at_tr = square_at_tr.piece
    return false if piece_at_tr.nil? || piece_at_tr.color == color

    true
  end

  def enemy_at_black_top_left?
    # flipped to emulate pieces facing opposite directions
    tl = @position.bottom_right
    square_at_tl = board.square_at_position(tl)
    return false unless square_at_tl
    piece_at_tl = square_at_tl.piece
    return false if piece_at_tl.nil? || piece_at_tl.color == color

    true
  end
end

