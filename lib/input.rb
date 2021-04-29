module Input
  def print_text(message)
    {
      'num_lives' => "Enter the number of lives you will have (10-15): ",
      'input_letter' => "Enter a letter: "
    }[message]
  end

  def prompt_lives(message)
    lives = ''
    until (1..15).member?(lives)
      print message
      lives = gets.chomp.to_i
    end
    lives
  end

  def prompt_letter(message)
    letter = ''
    until letter.match?(/[A-Za-z]/) && letter.length == 1
      print message
      letter = gets.chomp
    end
    letter.upcase
  end
  
end