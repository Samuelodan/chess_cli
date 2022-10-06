# frozen_string_literal: true

class Player
  attr_reader :color

  def initialize
    @name = nil
    @color = nil
  end

  def set_name(name)
    @name = name
  end

  def name
    player_name = @name.empty? ? default_name : @name
  end

  def set_color(color)
    @color = color
  end

  private

  def default_name
    @color == :white ? 'Player1' : 'Player2'
  end

end

