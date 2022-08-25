# frozen_string_literal: true

# smart chess squares
class Square
  attr_accessor :position, :piece, :color

  def initialize
    @position = nil
    @piece = nil
    @color = nil
  end
end

