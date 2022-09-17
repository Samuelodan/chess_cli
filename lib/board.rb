# frozen_string_literal: true

require_relative './square'
require_relative './piece'
require_relative './position'
require_relative './rook'
require_relative './knight'
require_relative './bishop'
require_relative './queen'
require_relative './king'
require_relative './pawn'

# board for the chess game
class Board
  attr_accessor :squares

  def initialize
    @squares = build_board
    @selected_square = nil
    @sel_pc_moves = nil
    @destination_position = nil
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
        res_arr << Position.new(file: file, rank: rank)
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

  def clear_board
    @squares = build_board
  end


  def display_board
    puts '    a  b  c  d  e  f  g  h'
    squares.each_with_index do |row, row_idx|
      print " #{8 - row_idx} "
      row.each_with_index do |item, idx|
        item.draw_square
      end
      print " #{8 - row_idx} "
        print "\n"
    end
    puts "    a  b  c  d  e  f  g  h"
  end

  def arrange_pieces
    arrange_black_pieces
    arrange_white_pieces
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

  def arrange_white_pieces
    squares[6].each do |sqr|
      sqr.piece = Piece.for('P')
    end
    pc_letters = %w[R N B Q K B N R]
    pc_idx = 0
    squares[7].each do |sqr|
      sqr.piece = Piece.for(pc_letters[pc_idx])
      pc_idx += 1
    end
  end

  def simplify_fen(full_fen_str)
    new_str = ''
    full_fen_str.split(' ').first.each_char do |char|
      unless char.to_i.zero?
        char.to_i.times { new_str += '1' }
      else
        new_str += char
      end
    end
    new_str
  end

  def arrange_pieces_from_fen(full_fen_str)
    clear_board
    fen_array = simplify_fen(full_fen_str).split('/')
    squares.each_with_index do |row, row_idx|
      row.each_with_index do |sqr, idx|
        current_fen_char = fen_array[row_idx][idx]
        next if current_fen_char == '1'
        squares[row_idx][idx].piece = Piece.for(current_fen_char)
      end
    end
  end

  def square_coord(sqr)
    squares.each_with_index do |row, row_idx|
      row.each_with_index do |square, idx|
        return [row_idx, idx] if sqr == square
      end
    end
  end

  def square_position(sqr)
    squares.each_with_index do |row, row_idx|
      row.each_with_index do |square, idx|
        return square.position if square == sqr
      end
    end
  end

  def square_at_pos(pos)
    squares.each do |row|
      row.each do |square|
        return square if square.position == pos
      end
    end
    nil
  end

  def square_at_position(pos)
    squares.each do |row|
      row.each do |square|
        return square if square.position == pos
      end
    end
    nil
  end

  def pos_to_coord(pos_str)
    squares.each_with_index do |row, row_idx|
      row.each_with_index do |square, idx|
        return [row_idx, idx] if pos == square.position
      end
    end
    nil
  end

  def update_targ_and_dest(target:, destination:)
    store_selected_square(target)
    store_dest_position(destination)
    update_current_pc_pos
    store_pc_moves
  end

  def update_current_pc_pos
    sqr_pos = @selected_square.position
    @selected_square.piece.update_position(sqr_pos)
  end

  def select_square_from_str(pos_str)
    square_at_position(Position.for(pos_str))
  end

  def store_selected_square(pos_str)
    @selected_square = select_square_from_str(pos_str)
  end

  def store_dest_position(pos_str)
    @destination_position = Position.for(pos_str)
  end

  def store_pc_moves
    pc = @selected_square.piece
    @sel_pc_moves = pc.valid_moves(board: self)
  end

  def place_piece(pos_str)
    target_pos, dest_pos = pos_str.slice(0, 2), pos_str.slice(2, 2)
    square = square_at_pos(target_pos)
    piece = square.piece
    piece.update_coor(square_coord(square))
    pc_move_positions = piece.valid_move_pos(board: self)
    if pc_move_positions.include?(dest_pos)
      square_at_pos(dest_pos).piece = piece
      square.piece = nil
    end
  end
end

