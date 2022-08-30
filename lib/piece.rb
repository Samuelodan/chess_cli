# frozen_string_literal: true

# Piece superclass
class Piece
  attr_accessor :color, :letter

  def initialize(color:, letter:)
    @color = color
    @letter = letter
  end
end

