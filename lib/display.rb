module Display
  def show_life(life)
    puts "Lives: #{life}"
  end

  def show_blanks(blanks)
    puts blanks
  end

  def show_num_letters(word)
    puts "The word has #{word.length} letters."
  end

  def show_winner(word)
    puts "You win! You guessed the right word! It's #{word}"
  end

  def show_loser(word)
    puts "You lose.. The word is #{word}"
  end

  def show_saved_files
    puts "This is the list of all the saved sessions: "
    files = Dir["./saved_sessions/*"].map { | file | File.basename(file,File.extname(file))}
    puts files
    files
  end

  def intro
    <<~HEREDOC
      This is HANGMAN Console! 

      Hangman is originally a pen and paper game played by two or more players.
      One player will think of the word, phrase, or sentence.The other/s will 
      try to guess it by suggesting letters within a number of chances.

      For this specific program, these are the guidelines.
        1. You can only play as the guesser.
        2. The computer will only randomize a word that lengths from 5-12 letters.
        3. You will be the one to choose how many lives you will have (10-15).
        4. You can only suggest 1 letter per round.
        5. Everytime you suggest the wrong letter, you will lose one life.
        6. You will win after you have guessed all letters of the word correctly.
        7. You will lose if you ran out of lives.
        8. You can save/load your game.

    HEREDOC
  end
end