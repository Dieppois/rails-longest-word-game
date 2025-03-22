require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10).join(" ").upcase
  end

  def score
    @answer = params[:word]
    @chars = params[:letters]

    # Vérifier que le mot soumis est valide en utilisant une API de dictionnaire
    begin
      url = URI.open("https://api.dictionaryapi.dev/api/v2/entries/en/#{@answer}").read
      parsing_url = JSON.parse(url)
      @result = parsing_url.first['meanings'].any? ? 'valid' : 'invalid'
    rescue StandardError => e
      @result = 'invalid'
    end

    # Vérification de la présence des lettres
    @compare_letter = @answer.upcase.chars.map do |letter|
      @chars.split.include?(letter)
    end
  end
end
