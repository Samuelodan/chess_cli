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
end

