# frozen_string_literal: true

# smart chess squares
class Square
  def initialize(pos:)
    @position = pos
    @piece = nil
    @color = nil
  end
end

