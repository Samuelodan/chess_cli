# frozen_string_literal: true

class Player
  attr_reader :name, :color

  def initialize
    @name = nil
    @color = nil
  end

  def set_name(name)
    @name = name
  end

  def set_color(color)
    @color = color
  end
end

