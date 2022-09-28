# frozen_string_literal: true

# custom method for this project
class Array
  def nested?
    self != self.flatten
  end
end

# Piece superclass
class Piece
  attr_reader :color, :letter, :board, :position

  def initialize(letter:)
    @letter = letter
    @color = determine_color
    @moved = false
    @position = nil
    @board = nil
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

  def update_position(pos)
    @position = pos
  end

  def update_board(board)
    @board = board
  end

  def position
    square = nil
    board.squares.each do |row|
      row.each do |sqr|
        square = sqr if sqr.piece && sqr.piece == self
      end
    end
    square.position
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
    moves_on_board(handle_collision(moves_array))
  end

  def moves_on_board(pos_list)
    pos_list.select do |pos|
      board.square_at_position(pos)
    end
  end

  def valid_moves
    @position = position
    possible_moves.reject do |position|
      current_sqr = board.square_at_position(position)
      if current_sqr.piece
        current_sqr.piece.color == color
      end
    end
  end

  def handle_collision(pos_arrays)
    return pos_arrays unless pos_arrays.nested?

    result = []
    pos_arrays.each do |arr|
      arr.each do |pos|
        result << pos
        break if board.square_at_position(pos).piece
      end
    end
    result
  end

  def attack_moves
    valid_moves.select do |pos|
      current_sqr = board.square_at_position(pos)
      current_sqr.piece
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

