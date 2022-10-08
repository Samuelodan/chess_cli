# frozen_string_literal: true

# holds all the display methods for ChessGame
module Display
  private

  ERROR_MESSAGES = {
    wrong_format: "Please use the correct format like so, 'h2h4'",
    no_piece: "There's no piece on that position, pls try again",
    wrong_piece: "You can't move your opponent's piece, pls try again",
    invalid_dest: "Your piece cannot move to that position, pls try again",
    self_check: "You can't place/leave your king in check, try again",
    promo_letter: "Please enter a valid piece letter",
    menu_input: "Please enter a valid item number",
    replay_input: 'Please enter either 1 or 2 to choose',
    save_choice: 'Please enter a number between 1 and 5'
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

  def display_menu
    system('clear')
    puts <<-HEREDOC
  \n\n\n\n\n
  ENTER ANY OF THE FOLLOWING OPTIONS

  [1] start new game
  [2] load saved game

    HEREDOC
  end

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
  <please turn up the zoom in your browser or terminal if pieces are too small>

  ALRIGHT, ENOUGH SAID, LET THE GAME BEGIN

  enter any key to continue...

    HEREDOC
    print '  >> '
    gets.chomp
  end

  def confirm_save
    puts <<-HEREDOC

  Game saved successfully...

  Now, make your move or quit if you want to come back later

    HEREDOC
  end

  def choose_save_prompt
    puts <<-HEREDOC

  Choose any save from the list below to load it

    HEREDOC
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

  def prompt_move
    puts <<-HEREDOC
    [enter 'save' to save game, or 'quit' to surrender]

  #{current_player.pretty_name}, move your piece by entering the positions
  like so, 'c4e6' without the quotes

    HEREDOC
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

  def declare_win
    puts <<-HEREDOC
                 \e[1m\e[92m CHECKMATE!! \e[0m

         \e[1m #{current_player.pretty_name}\e[0m just won the game.

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
    loser = current_player.pretty_name
    change_turn
    winner = current_player.pretty_name
    puts <<-HEREDOC

              Well done #{winner}!!

  #{loser} couldn't withstand your awesomeness

    HEREDOC
  end

  def play_again_prompt
    puts <<-heredoc

  do you want to play again?
  enter the corresponding number to choose
  [1] yeah
  [2] no thanks

    heredoc
  end

  def thank_players
    puts <<-HEREDOC

            Thank you for playing :)
    HEREDOC
  end
end

