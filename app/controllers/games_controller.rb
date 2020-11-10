require "open-uri"

class GamesController < ApplicationController

  def new
    alphabet = ("A".."Z").to_a
    @letters = alphabet.sample(9) # => ["S", "I", "K", "J", "A", "Z", "E", "C", "U"]
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def score
    @word = params[:solution]
    if english_word?(@solution)
      @feedback = "That is a real word"
    else
      @feedback = "That is not a word!"
    end
    @letters = params[:letters].downcase
    letters_array = @letters.split('')
    word_array = @word.downcase.split('')
    @word_included = word_array.all? { |letter| letters_array.include?(letter) }
  end
end

