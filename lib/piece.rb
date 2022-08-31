# frozen_string_literal: true

# Piece superclass
class Piece
  attr_accessor :color, :letter

  def initialize(letter:)
    @color = determine_color
    @letter = letter
    @moved = false
  end

  def determine_color
    str_letter = letter.to_s
    clr = str_letter == str_letter.downcase ? :black : :white
  end

  def moved?
    @moved
  end

  def moved=(bool)
    @moved = bool
  end
end

