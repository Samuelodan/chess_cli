# frozen_string_literal: true
require_relative './piece'

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
    mv_arr
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
end
