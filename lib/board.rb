# frozen_string_literal: true

require_relative './square.rb'
require_relative './piece.rb'
require_relative '../lib/rook'
require_relative '../lib/knight'
require_relative '../lib/bishop.rb'
require_relative '../lib/queen.rb'
require_relative '../lib/king'
require_relative '../lib/pawn.rb'

# board for the chess game
class Board
  attr_accessor :squares

  def initialize
    @squares = build_board
  end

  def create_squares
    sqs = Array.new(8) { Array.new(8) }
    sqs.each_with_index do |row, row_idx|
      row.each_with_index do |item, idx|
        sqs[row_idx][idx] = Square.new
      end
    end
    sqs
  end

  def generate_positions
    res_arr = []
    8.downto(1).each do |rank|
      ('a'..'h').each do |file|
        res_arr << "#{file}#{rank}"
      end
    end
    res_arr
  end

  def assign_square_positions(sqs:)
    pos_arr = generate_positions

    pos_idx = 0
    sqs.each_with_index do |row, row_idx|
      row.each_with_index do |square, idx|
        sqs[row_idx][idx].position = pos_arr[pos_idx]
        pos_idx += 1
      end
    end
  end

  def assign_square_colors(sqs:)
    sqs.each_with_index do |row, row_idx|
      row.each_with_index do |sqr, idx|
        if row_idx.even?
          sqr.color = :white if idx.even?
          sqr.color = :black if idx.odd?
        else
          sqr.color = :white if idx.odd?
          sqr.color = :black if idx.even?
        end
      end
    end
  end

  def build_board
    sqs = create_squares
    assign_square_positions(sqs: sqs)
    assign_square_colors(sqs: sqs)
    sqs
  end


  def display_board
    puts '    a  b  c  d  e  f  g  h'
    squares.each_with_index do |row, row_idx|
      print " #{row_idx + 1} "
      row.each_with_index do |item, idx|
        item.draw_square
      end
      print " #{row_idx + 1} "
        print "\n"
    end
    puts "    a  b  c  d  e  f  g  h"
  end

  def arrange_black_pieces
    squares[1].each do |sqr|
      sqr.piece = Piece.for('p')
    end
    pc_letters = %w[r n b q k b n r]
    pc_idx = 0
    squares[0].each do |sqr|
      sqr.piece = Piece.for(pc_letters[pc_idx])
      pc_idx += 1
    end
  end
end

