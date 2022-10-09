# frozen_string_literal: true

# this module holds all save and load logic
module SaveLoad
  def generate_filename
    title = "#{player1.name.downcase}_vs_#{player2.name.downcase}"
    date_and_time = Time.now.strftime("_%Y-%m-%d %H-%M-%S")
    title + date_and_time
  end

  def to_json
    JSON.dump({
      board: board.to_fen,
      player1: player1.to_hash,
      player2: player2.to_hash,
      current_color: @current_color,
      quit: @quit
    })
  end

  def save_game
    save_to_file
    confirm_save
  end

  def save_to_file
    Dir.mkdir('saves') unless Dir.exist?('saves')

    filename = generate_filename
    File.open("saves/#{filename}", 'w') do |file|
      file.puts to_json
    end
  end

  def load_save
    file_number = get_save_choice.to_i - 1
    return if @skip_load

    filename = get_filelist[file_number]
    from_json(filename)
    play
  end

  def from_json(filename)
    data = JSON.load(File.read("saves/#{filename}"))
    @board.arrange_pieces_from_fen(data['board'])
    @player1.set_name(data['player1']['name'])
    @player1.set_color(data['player1']['color'].to_sym)
    @player2.set_name(data['player2']['name'])
    @player2.set_color(data['player2']['color'].to_sym)
    @current_color = data['current_color'].to_sym
    @quit = data['quit']
  end

  def get_save_choice
    display_save_list
    return if @skip_load

    loop do
      print '  >> '
      input = gets.chomp
      break input if valid_save_choice?(input)

      error_message_for(:save_choice)
    end
  end

  def get_filelist
    Dir.mkdir('saves') unless Dir.exist?('saves')

    Dir.children('saves').first(5)
  end

  def display_save_list
    return abort_load if get_filelist.empty?

    choose_save_prompt
    get_filelist.first(5).each_with_index do |filename, idx|
      puts "  [#{idx + 1}]  #{filename}"
    end
    puts
  end

  def abort_load
    puts <<-HEREDOC

  No save found. Starting new game now...

    HEREDOC
    sleep(1)
    @skip_load = true
    start_new_game
  end

  def valid_save_choice?(input)
    fl_count = get_filelist.length.to_s
    ('1'..fl_count).include?(input)
  end
end

