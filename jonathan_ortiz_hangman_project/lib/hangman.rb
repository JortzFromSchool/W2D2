class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample
  end

  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    return true if @attempted_chars.include?(char)
    return false
  end

  def get_matching_indices(char)
    results = []
    @secret_word.each_char.with_index do |elem, idx|
      results << idx if elem == char
    end
    results
  end

  def fill_indices(char, indexes)
    indexes.each do |idx|
      @guess_word[idx] = char
    end
  end

  def try_guess(char)
    if already_attempted?(char)
      puts "that has already been attempted"
      return false
    else
      @attempted_chars << char
      indexes = self.get_matching_indices(char)
      if indexes.length == 0
        @remaining_incorrect_guesses -= 1
      else
        self.fill_indices(char, indexes)
      end
      return true
    end
  end

  def ask_user_for_guess
    puts "Enter a char:"
    return self.try_guess(gets.chomp)
  end

  def win?
    if @guess_word.join("") == @secret_word
      puts "WIN"
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      return true
    else
      return false
    end
  end

  def game_over?
    if self.win? || self.lose?
      puts "secret word was: " + @secret_word
      return true
    else
      return false
    end
  end
end
