# frozen_string_literal: true

require_relative './board'
require_relative './player'

class ChessGame
  attr_reader :board, :player1, :player2, :current_player

  def initialize(board: Board.new,
                 player1: Player.new,
                 player2: Player.new)
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

  def introduction
    system('clear')
    puts <<~HEREDOC
      W E L C O M E  TO  C H E S S (C L I)

      THIS IS PRETTY MUCH THE SAME GAME YOU KNOW (AND LOVE? HA HA!)
      THE MAIN DIFFERENCE IS YOU USE ALGEBRAIC NOTATION TO MOVE PIECES
      SO, "a2a4" MEANS "MOVE THE PIECE AT A2 TO A4." IT MIGHT SEEM
      WEIRD AT FIRST BUT IT'LL FEEL NATURAL MUCH SOONER THAN YOU EXPECT.

      ALRIGHT, ENOUGH SAID, LET THE GAME BEGIN

      enter any key to continue...\n
    HEREDOC
    print '>> '
    gets.chomp
  end
end

