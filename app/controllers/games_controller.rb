class GamesController < ApplicationController
  require "open-uri"
  require "json"

  def new
    @alphabet = ('A'..'Z').to_a
    @letters = @alphabet.sample(10)
  end

  def score
    well_done_letters = ['A', 'W', 'E', 'S', 'O', 'M', 'E', '!']
    sorry_letters = ['S', 'O', 'R', 'R', 'Y', '!']
    guess = params[:word]
    guess_result = run_api(guess)
    @word = params[:word].chars
    @letters = params[:letters].split('')
    @result = @word.all? { |letter| @letters.include?(letter.upcase) }
    if @result && guess_result
      @score = @word.length * 123
      @end_message = well_done_letters
      @client_message = "You scored: #{@score} points!"
    else
      @end_message = sorry_letters
      @client_message = "Sorry, your answer was invalid."
    end
  end

  def run_api(guess)
    url = "https://dictionary.lewagon.com/#{guess}"
    result_serialized = URI.open(url).read
    dictionary_hash = JSON.parse(result_serialized)
    dictionary_hash["found"]


  end
end
