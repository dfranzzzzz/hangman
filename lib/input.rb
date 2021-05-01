module Input
  def print_text(message)
    {
      'num_lives' => "Enter the number of lives you will have (10-15): ",
      'input_letter' => "Enter a letter: ",
      'new_save' => "Enter session name(letters only): ",
      'load_file' => "Enter the file name you want to load: ",
      'want_save?' => "Do you want to save your game? (y/n): ",
      'want_load?' => "Do you want to load saved session? (y/n): "
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

  def prompt_yes_no(message)
    response = ''
    until response == 'y'|| response == 'n'
      print message
      response = gets.chomp
    end
    response
  end

  def prompt_filename(message)
    filename = ''
    until filename.match?(/[A-Za-z]/)
      print message
      filename = gets.chomp
    end
    filename
  end
end