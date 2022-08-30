# frozen_string_literal: true

# Piece superclass
class Piece
  attr_accessor :color, :letter

  def initialize(color:, letter:)
    @color = color
    @letter = letter
    @moved = false
  end

  def moved?
    @moved
  end

  def moved=(bool)
    @moved = bool
  end
end

