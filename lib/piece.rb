# frozen_string_literal: true

# Piece superclass
class Piece
  attr_reader :color, :letter

  def initialize(letter:)
    @letter = letter
    @color = determine_color
    @moved = false
    @position = nil
    @coordinate = nil
  end

  def determine_color
    letter == letter.downcase ? :black : :white
  end

  def moved?
    @moved
  end

  def moved
    @moved = true
  end

  def update_coor(coor)
    @coordinate = coor
  end

  def update_position(pos)
    @position = pos
  end

  def possible_moves
    moves_array = []
    directions.each do |dir_list|
      temp_pos = @position
      dir_list.each do |dir|
        temp_pos = temp_pos.send(dir)
      end
      moves_array << temp_pos
    end
    moves_on_board(moves_array)
  end

  def moves_on_board(pos_list)
    board = Board.new
    pos_list.select do |pos|
      board.square_at_position(pos)
    end
  end

  def valid_moves(board:)
    possible_moves.reject do |position|
      current_sqr = board.square_at_position(position)
      if current_sqr.piece
        current_sqr.piece.color == color
      end
    end
  end

  def self.for(letter)
    registry.find do |candidate|
      candidate.handles?(letter.downcase)
    end.new(letter: letter)
  end

  def self.registry
    @registry ||= []
  end

  def self.register(candidate)
    registry << candidate
  end

  def self.inherited(candidate)
    register(candidate)
  end
end

