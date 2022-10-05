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

  private

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

  public

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
    assign_piece_boards
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
    assign_piece_boards
  end

  private

  def assign_piece_boards
    squares.each do |row|
      row.each do |sqr|
        if sqr.piece
          sqr.piece.update_board(self)
        end
      end
    end
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

  public

  # write tests
  def piece_from_str(pos_str)
    select_square_from_str(pos_str).piece
  end

  def square_at_position(pos)
    squares.each do |row|
      row.each do |square|
        return square if square.position == pos
      end
    end
    nil
  end

  def update_targ_and_dest(target:, destination:)
    store_selected_square(target)
    store_dest_position(destination)
    store_pc_moves
  end

  def is_move_legal?
    @sel_pc_moves.include?(@destination_position)
  end

  def move_valid_but_illegal?
    pc = @selected_square.piece
    pc.pseudolegal_moves.include?(@destination_position) && !self.is_move_legal?
  end

  def place_piece
    return unless is_move_legal?

    current_pc = @selected_square.piece
    dest_square = square_at_position(@destination_position)
    dest_square.piece = current_pc
    current_pc.moved
    @selected_square.piece = nil
  end

  def can_promote?
    return true if white_p_in_rank_8?
    return true if black_p_in_rank_1?

    false
  end

  def promote_pawn(choice:)
    choice = choice.downcase
    sqr = find_promotable_sqr
    pawn = sqr.piece
    pl = pawn.letter
    letter = pl == pl.upcase ? choice.upcase : choice
    sqr.piece = Piece.for(letter)
  end

  def king_in_check?
    pieces_under_attack.any? { |piece| piece.class == King }
  end

  def checked_king
    pieces_under_attack.find { |piece| piece.class == King }
  end

  def checkmate?
    moves_by_color = {
      white: :all_white_legal_moves,
      black: :all_black_legal_moves
    }
    if king_in_check?
      moves = self.send(moves_by_color[checked_king.color])
      return true if moves.empty?
    end
    false
  end

  def stalemate?
    moves_by_color = [:all_white_legal_moves, :all_black_legal_moves]

    unless king_in_check?
      return true if moves_by_color.any? do |move_list|
        self.send(move_list).empty?
      end
    end
    false
  end

  private

  def all_white_legal_moves
    pieces = get_all_white_pieces
    total_moves = []
    pieces.each do |pc|
      pc.legal_moves.each do |pos|
        total_moves << pos
      end
    end
    total_moves
  end

  def all_black_legal_moves
    pieces = get_all_black_pieces
    total_moves = []
    pieces.each do |pc|
      pc.legal_moves.each do |pos|
        total_moves << pos
      end
    end
    total_moves
  end

  def pieces_under_attack
    pieces = get_all_pieces
    under_attack = []
    pieces.each do |pc|
      pc.attack_moves.each do |pos|
        att_pc = square_at_position(pos).piece
        under_attack << att_pc
      end
    end
    under_attack
  end

  def get_all_white_pieces
    get_all_pieces.select { |pc| pc.color == :white }
  end

  def get_all_black_pieces
    get_all_pieces.select { |pc| pc.color == :black }
  end

  def get_all_pieces
    pc_array = []
    squares.each do |row|
      row.each do |sqr|
        pc_array << sqr.piece if sqr.piece
      end
    end
    pc_array
  end

  def find_promotable_sqr
    square =
      if white_p_in_rank_8?
        squares[0].find { |sqr| sqr.piece && sqr.piece.letter == 'P' }
      elsif black_p_in_rank_1?
        squares[7].find { |sqr| sqr.piece && sqr.piece.letter == 'p' }
      end
  end

  def white_p_in_rank_8?
    squares[0].any? { |sqr| sqr.piece && sqr.piece.letter == 'P' }
  end

  def black_p_in_rank_1?
    squares[7].any? { |sqr| sqr.piece && sqr.piece.letter == 'p' }
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
    @sel_pc_moves = pc.legal_moves
  end
end

