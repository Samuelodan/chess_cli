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
    @name.empty? ? default_name : @name
  end

  def pretty_name
    player_name = name
    bg_color = @color == :white ? "\e[48;2;240;217;181m" : "\e[48;2;181;136;99m"
    name_color = "\e[30m"
    "\e[1m#{bg_color}#{name_color} #{player_name} \e[0m"
  end

  def set_color(color)
    @color = color
  end

  def to_hash
    {
      name: @name,
      color: @color
    }
  end

  private

  def default_name
    @color == :white ? 'Player1' : 'Player2'
  end

end

