# frozen_string_literal: true
require_relative './piece'
require_relative './board'

# subclass of Piece
class Knight < Piece
  def symbol
    sym = color == :white ? "\u2658" : "\u265e"
  end

  def self.handles?(letter)
    letter == 'n'
  end

  def moves
    mv_arr = []
    directions.each do |dir|
      x = @coordinate[0] + dir[0]
      y = @coordinate[1] + dir[1]
      mv_arr << [x, y]
    end
    validate_coor(mv_arr)
  end

  def directions
    [
      [-2, -1], [+2, -1], [-2, +1], [+2, +1],
      [-1, +2], [-1, -2], [+1, +2], [+1, -2]
    ]
  end

  def validate_coor(coor_list)
    coor_list.select do |coor|
      coor => [x, y]
      (0..7) === x && (0..7) === y
    end
  end

  def valid_moves(board:)
    moves.reject do |move|
      move => [y, x]
      current_sqr = board.squares[y][x]
      if current_sqr.piece
        current_sqr.piece.color == color
      end
    end
  end

  def valid_move_pos(board:)
    pos_arr = []
    coords = valid_moves(board: board)
    coords.each do |coord|
      coord => [y, x]
      pos_arr << board.squares[y][x].position
    end
    pos_arr
  end
end
