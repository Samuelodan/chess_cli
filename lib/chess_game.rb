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
    @quit = false
  end

  ERROR_MESSAGES = {
    wrong_format: "Please use the correct format like so, 'h2h4'",
    no_piece: "There's no piece on that position, pls try again",
    wrong_piece: "You can't move your opponent's piece, pls try again",
    invalid_dest: "Your piece cannot move to that position, pls try again",
    self_check: "You can't place/leave your king in check, try again",
    promo_letter: "Please enter a valid piece letter",
    menu_input: "Please enter a valid item number",
    replay_input: 'Please enter either 1 or 2 to choose'
  }.freeze

  def error_message_for(error_name)
    puts ERROR_MESSAGES[error_name]
  end

  def display_error_message(input)
    unless input.match?(/^[a-h][1-8][a-h][1-8]$/)
      return error_message_for(:wrong_format)
    end
    from = input.slice(0..1)
    to = input.slice(2..3)
    pc = board.piece_from_str(from)
    if pc.nil?
      error_message_for(:no_piece)
    elsif pc.color != current_player.color
      error_message_for(:wrong_piece)
    else
      board.update_targ_and_dest(target: from, destination: to)
      return error_message_for(:self_check) if board.move_valid_but_illegal?
      error_message_for(:invalid_dest) unless board.is_move_legal?
    end
  end

  def start
    menu_action
  end

  def start_new_game
    assign_player_attributes
    board.arrange_pieces
    play
  end

  def play
    loop do
      system('clear')
      board.display
      make_move
      announce_check if board.king_in_check?
      begin_promotion if board.can_promote?
      break if board.stalemate? || board.checkmate? || @quit
      change_turn
    end
    announce_results
  end

  def menu_action
    system('clear')
    introduction
    display_menu
    input = get_menu_input
    start_new_game if input == '1'
  end

  def intro_and_setup
    introduction
    assign_player_attributes
    board.arrange_pieces
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
    return @quit = true if input == 'quit'
    from = input.slice(0..1)
    to = input.slice(2..3)
    board.update_targ_and_dest(target: from, destination: to)
    board.place_piece
  end

  def prompt_move
    puts <<-HEREDOC
    [enter 'quit' if you choose to surrender]

  #{current_player.name}, move your piece by entering the positions
  like so, 'c4e6' without the quotes

    HEREDOC
  end

  def get_move_input
    loop do
      print '  >> '
      input = gets.chomp.downcase
      break input if valid_move_input?(input) || input == 'quit'

      display_error_message(input)
    end
  end


  def valid_move_input?(input)
    return false unless input.match?(/^[a-h][1-8][a-h][1-8]$/)

    from = input.slice(0..1)
    to = input.slice(2..3)
    pc = board.piece_from_str(from)
    return false if pc.nil? || pc.color != current_player.color

    board.update_targ_and_dest(target: from, destination: to)
    board.is_move_legal?
  end

  def announce_check
    puts "\e[1m\e[91m  CHECK!!! \e[0m"
    sleep 2
  end

  def announce_results
    system('clear')
    board.display
    declare_win if board.checkmate?
    declare_draw if board.stalemate?
    declare_surrender if @quit
  end

  def declare_win
    puts <<-HEREDOC
                 \e[1m\e[92m CHECKMATE!! \e[0m

         \e[1m #{current_player.name}\e[0m just won the game.

  HEREDOC
  end

  def declare_draw
    puts <<-HEREDOC
                 \e[1m\e[93m STALEMATE!! \e[0m

            The match ended in a draw
            Well, at least, nobody lost. he he
            Better luck next time
  HEREDOC
  end

  def declare_surrender
    @quit = false
    loser = current_player.name
    change_turn
    winner = current_player.name
    puts <<-HEREDOC

              Well done #{winner}!!

  #{loser} couldn't withstand your awesomeness

    HEREDOC
  end

  def get_play_again_input
    loop do
      input = gets.chomp
      break input if valid_play_again_input?(input)

      error_message_for(:replay_input)
    end
  end

  def play_again_prompt
    puts <<-HEREDOC

  Do you want to play again?
  enter the corresponding number to choose
  [1] yeah
  [2] no thanks

    HEREDOC
    print '  >> '
  end

  def valid_play_again_input?(input)
    ['1', '2'].include?(input)
  end

  def begin_promotion
    system('clear')
    board.display
    promotion_prompt
    input = get_promotion_input
    board.promote_pawn(choice: input)
  end

  def promotion_prompt
    puts <<-HEREDOC
  It's time to promote your Pawn. Enter any one of the options below
  without the brackets.

  [q] to promote to Queen
  [r] for Rook
  [n] for Knight
  [b] for Bishop

    HEREDOC
  end

  def get_promotion_input
    loop do
      print '  >> '
      input = gets.chomp.downcase
      break input if valid_promotion_input?(input)

      error_message_for(:promo_letter)
    end
  end

  def valid_promotion_input?(input)
    ['q', 'r', 'n', 'b'].include?(input)
  end

  private

  def introduction
    system('clear')
    puts <<-HEREDOC
  \n\n
  \e[1mW E L C O M E  TO  C H E S S (C L I)\e[0m

  THIS IS PRETTY MUCH THE SAME GAME YOU KNOW (AND LOVE? HA HA!)
  THE MAIN DIFFERENCE IS YOU USE ALGEBRAIC NOTATION TO MOVE PIECES
  SO, "a2a4" MEANS "MOVE THE PIECE AT A2 TO A4." A VALID POSITION
  HAS A LETTER BETWEEN 'a' AND 'h', AND A NUMBER BETWEEN '1' AND '8'.
  IT MIGHT SEEM WEIRD AT FIRST BUT IT'LL FEEL NATURAL MUCH SOONER
  THAN YOU EXPECT.

  ALRIGHT, ENOUGH SAID, LET THE GAME BEGIN

  enter any key to continue...

    HEREDOC
    print '  >> '
    gets.chomp
  end

  def display_menu
    system('clear')
    puts <<-HEREDOC
  \n\n\n\n\n
  ENTER ANY OF THE FOLLOWING OPTIONS

  [1] start new game
  [2] load saved game

    HEREDOC
    print '  >> '
  end

  def get_menu_input
    loop do
      input = gets.chomp

      break input if valid_menu_input?(input)

      error_message_for(:menu_input)
    end
  end

  def valid_menu_input?(input)
    ['1', '2'].include?(input)
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
    puts <<-HEREDOC
  \n\n\n\n\n\n\n\n\n\n\n\n\n
  \e[1m#{player_no}\e[0m, enter your name

    HEREDOC
    print '  >> '
    gets.chomp
  end
end

