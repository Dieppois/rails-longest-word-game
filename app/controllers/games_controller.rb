require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10).join(" ").upcase
  end

  def score
    @answer = params[:word]
    @chars = params[:letters]

    url = URI.open("https://dictionary.lewagon.com/#{@answer}").read
    parsing_url = JSON.parse(url)
    @result = parsing_url['found']

    @compare_letter = @answer.upcase.chars.map do |letter|
      @chars.split.include?(letter)
    end
  end
end
