require_relative 'input'
require_relative 'display'

class Hangman
  include Input
  include Display
  attr_reader :random_word, :split_letters
  attr_accessor :num_lives, :blanks, :letter_input

  def initialize
    puts intro
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
    # puts random_word
  end

  def get_letter_input
    @letter_input = prompt_letter(print_text('input_letter'))
    puts letter_input
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

  def game_loop
    while true
      show_num_letters(random_word)
      show_life(num_lives)
      show_blanks(blanks)
      get_letter_input
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
    get_lives
    clear_screen
    get_random_word
    make_blanks
    game_loop
  end
end

Hangman.new.game_flow