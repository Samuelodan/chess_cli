# frozen_string_literal: true

require_relative './board'
require_relative './player'

class Game do
  attr_reader :board, :player1, :player2, :current_player

  def initialize(
    board: Board.new
    player1: Player.new
    player2: Player.new
  )
    @board = board
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  def change_turn
    if current_player == player1
      @current_player = player2
    else
      @current_player = player1
    end
  end
end

