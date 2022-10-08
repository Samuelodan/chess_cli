# frozen_string_literal: true

require 'json'
require_relative './board'
require_relative './player'
require_relative './display'

class ChessGame
  include Display

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
    play_again_or_quit
  end

  def play_again_or_quit
    play_again_prompt
    input = get_play_again_input
    if input == '1'
      board.arrange_pieces
      play
    elsif input == '2'
      thank_players
    end
  end

  def get_play_again_input
    loop do
      print '  >> '
      input = gets.chomp
      break input if valid_play_again_input?(input)

      error_message_for(:replay_input)
    end
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

  def get_menu_input
    loop do
      print '  >> '
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

  # save and load section
  def generate_filename
    title = "#{player1.name.downcase}_vs_#{player2.name.downcase}"
    date_and_time = Time.now.strftime("_%Y/%m/%d %H-%M-%S")
    title + date_and_time
  end

  def to_json
    JSON.dump({
      board: board.to_fen,
      player1: player1,
      player2: player2,
      current_player: current_player,
      quit: @quit
    })
  end

  def save_to_file
    Dir.mkdir('../saves') unless Dir.exist?('../saves')

    filename = generate_filename
    File.open("../saves/#{filename}", 'w') do |file|
      file.puts to_json
    end
  end

  def display_save_list
    choose_save_prompt
    Dir.children('../saves').first(5).each_with_index do |filename, idx|
      puts "  [#{idx + 1}]  #{filename}"
    end
  end

  def choose_save_prompt
    puts <<-HEREDOC

  Choose any save from the list below to load it

    HEREDOC
  end

  def valid_save_choice?(input)
    ['1', '2', '3', '4', '5'].include?(input)
  end
end

