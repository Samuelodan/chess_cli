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

  ERROR_MESSAGES = {
    wrong_format: "Please use the correct format like so, 'h2h4'",
    no_piece: "There's no piece on that position, pls try again",
    wrong_piece: "You can't move your opponent's piece, pls try again",
    invalid_dest: "Your piece cannot move to that position, pls try again"
  }.freeze

  def error_message_for(error_name)
    puts ERROR_MESSAGES[error_name]
  end

  def display_error_message(input)
    from = input.slice(0..1)
    to = input.slice(2..3)
    pc = board.piece_from_str(from)
    if !input.match?(/^[a-h][1-8][a-h][1-8]$/)
      error_message_for(:wrong_format)
    elsif pc.nil?
      error_message_for(:no_piece)
    elsif pc.color != current_player.color
      error_message_for(:wrong_piece)
    else
      board.update_targ_and_dest(target: from, destination: to)
      error_message_for(:invalid_dest) unless board.is_move_legal?
    end
  end

  def change_turn
    if current_player == player1
      @current_player = player2
    else
      @current_player = player1
    end
  end

  def assign_player_attributes
    assign_names
    assign_colors
  end

  def make_move
    prompt_move
    input = get_move_input
    from = input.slice(0..1)
    to = input.slice(2..3)
    board.update_targ_and_dest(target: from, destination: to)
    board.place_piece
  end

  def prompt_move
    puts <<~HEREDOC
      #{current_player.name}, move your piece by entering the positions like
      so, 'c4e6' without the quotes

    HEREDOC
  end

  def get_move_input
    loop do
      print '>> '
      input = gets.chomp
      break input if valid_move_input?(input)

      display_error_message(input)
    end
  end


  def valid_move_input?(input)
    from = input.slice(0..1)
    to = input.slice(2..3)
    pc = board.piece_from_str(from)
    return false unless input.match?(/^[a-h][1-8][a-h][1-8]$/)
    return false if pc.nil? || pc.color != current_player.color

    board.update_targ_and_dest(target: from, destination: to)
    board.is_move_legal?
  end

  private

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

  def assign_colors
    player1.set_color(:white)
    player2.set_color(:black)
  end

  def assign_names
    player1.set_name(collect_name(player_no: 'Player1'))
    player2.set_name(collect_name(player_no: 'Player2'))
  end

  def collect_name(player_no:)
    system('clear')
    print "#{player_no}, enter your name\n\n >> "
    gets.chomp
  end
end

