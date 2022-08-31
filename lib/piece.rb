# frozen_string_literal: true

# Piece superclass
class Piece
  attr_accessor :color, :letter

  def initialize(letter:)
    @letter = letter
    @color = determine_color
    @moved = false
  end

  def determine_color
    clr = letter == letter.downcase ? :black : :white
  end

  def moved?
    @moved
  end

  def moved=(bool)
    @moved = bool
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

