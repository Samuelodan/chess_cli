# frozen_string_literal: true

class Player
  attr_reader :name

  def initialize
    @name = nil
  end

  def set_name(name)
    @name = name
  end
end

