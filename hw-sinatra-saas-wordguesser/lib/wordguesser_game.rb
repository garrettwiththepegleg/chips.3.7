class WordGuesserGame
  attr_accessor :word, :guesses, :wrong_guesses
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(w)
    bool =false
    if w == nil
      throw ArgumentError
    end
    if w.match?(/[A-Za-z]/) == false
      throw ArgumentError
    end
    w = w.downcase
    puts w
    if @wrong_guesses.include? w
      bool = false
    elsif @guesses.include? w
      @wrong_guesses = @wrong_guesses + w
      
    elsif @word.include? w
      @guesses = guesses + w
      bool = true
    else
      @wrong_guesses = @wrong_guesses + w
      bool = true
    end
    
    return bool

  end

  def word_with_guesses()
    ret = '-'*@word.length
    for i in 0...ret.length
      @guesses.each_char do |corr|
        if @word[i] == corr
          ret[i] = corr

        end
      end
    end
    return ret
  end

  def check_win_or_lose()
    ret = word_with_guesses()
    if ret == @word
      return :win
    end
    if @wrong_guesses.length >= 7
      return :lose
    end
    return :play
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
