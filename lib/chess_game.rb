# frozen_string_literal: true

require_relative './board'
require_relative './player'

class Game do
  def initialize(
    board: Board.new
    player1: Player.new
    player2: Player.new
  )
    @board = board
    @player1 = player1
    @player2 = player2
  end
end

