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
    bg_color = "\e[48;2;181;136;99m"
    name_color = @color == :white ? "\e[97m" : "\e[30m"
    "\e[1m#{bg_color}#{name_color} #{player_name} \e[0m"
  end

  def pretty_name
    player_name = @name.empty? ? default_name : @name
    bg_color = "\e[48;2;181;136;99m"
    name_color = @color == :white ? "\e[97m" : "\e[30m"
    "\e[1m#{bg_color}#{name_color} #{player_name} \e[0m"
  end

  def set_color(color)
    @color = color
  end

  private

  def default_name
    @color == :white ? 'Player1' : 'Player2'
  end

end

