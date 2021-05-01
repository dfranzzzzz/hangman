require_relative 'input'
require_relative 'display'
require 'yaml'

class Hangman
  include Input
  include Display
  attr_reader :random_word, :split_letters, :letter_input, :used_letters
  attr_accessor :num_lives, :blanks

  def initialize
    puts intro
    @used_letters = Array.new
  end

  def get_lives
    @num_lives = prompt_lives(print_text('num_lives'))
  end

  def get_random_word
    word_bank = File.open("5desk.txt", 'r')
    useable_words = Array.new
    # removes /n to the words and converts them in uppercase
    word_bank.each_line { | line |
      word = line.chomp
      useable_words.push(word.upcase) if word.length >= 5 && word.length <= 12
    }
    word_bank.close
    @random_word = useable_words.sample
  end

  def get_letter_input
    @letter_input = prompt_letter(print_text('input_letter'))
    letter_input
  end

  def letter_invalid
    used_letters.push(letter_input)
  end

  def decrease_lives
    @num_lives -= 1
  end

  def make_blanks
    @split_letters = random_word.split('').join(' ')
    @blanks = split_letters.gsub(/[A-Z]/, '_')
  end

  def input_right?
    return true if split_letters.include?(letter_input)
    return false
  end

  def input_valid?
    return false if used_letters.include?(letter_input)
    return true
  end

  def update_blanks
    split_letters_arr = split_letters.split('')
    index = split_letters_arr.each_index.select { | i |
      split_letters_arr[i] == letter_input
    }
    index.each { | i | blanks[i] = letter_input}
  end

  def winner?
    return false unless split_letters == blanks
    return true
  end

  def loser?
    return false unless num_lives == 0
    return true
  end

  def clear_screen
    system('clear')
  end

  def save_game?
    response = prompt_yes_no(print_text('want_save?'))
    if response == 'y'
      puts "Note: Previously saved file will be overwritten if you choose the same file name"
      show_saved_files
      filename = prompt_filename(print_text('new_save'))
      File.open("./saved_sessions/#{filename}.yml", 'w') { |file| YAML.dump([] << self, file) }
    end
    return if response == 'n'
  end

  def load_game
    saved_sessions = show_saved_files
    filename = prompt_filename(print_text('load_file'))
    until saved_sessions.include?(filename)
      puts "#{filename} is not on the list."
      filename = prompt_filename(print_text('load_file'))
    end
    yaml = YAML.load_file("./saved_sessions/#{filename}.yml")
    @num_lives = yaml[0].num_lives.to_i
    @random_word = yaml[0].random_word
    @blanks = yaml[0].blanks
    @split_letters = yaml[0].split_letters
    @used_letters = yaml[0].used_letters
    game_loop
  end

  def game_loop
    first_guess = true
    clear_screen
    while true
      show_num_letters(random_word)
      show_life(num_lives)
      show_blanks(blanks)
      save_game? if first_guess == false
      get_letter_input
      input_valid?
      while input_valid? == false
        puts "You have already picked that letter previously."
        get_letter_input
        # input_valid?
      end
      letter_invalid
      first_guess = false
      clear_screen
      update_blanks if input_right? == true
      decrease_lives if input_right? == false
      if winner? == true
        show_winner(random_word)
        break
      end
      if loser? == true
        show_loser(random_word)
        break
      end
    end
  end

  def game_flow
    response = prompt_yes_no(print_text('want_load?'))
    load_game if response == 'y'
    if response == 'n'
      get_lives
      get_random_word
      make_blanks
      game_loop
    end
  end
end
