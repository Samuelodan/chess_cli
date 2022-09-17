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

