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
      %i[up up left], %i[up up right],
      %i[right right up], %i[right right down],
      %i[down down right], %i[down down left],
      %i[left left down], %i[left left up]
    ]
  end

  def validate_coor(coor_list)
    coor_list.select do |coor|
      coor => [x, y]
      (0..7) === x && (0..7) === y
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
