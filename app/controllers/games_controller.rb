require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @grid = params['grid']
    @word = params['word']
    @grid_valid = grid?(params['word'], params['grid'])
    @dico_valid = dico?(params['word'])
    @score = params['word'].size
  end

  private

  def dico?(word)
    dico_query_serialized = open("https://wagon-dictionary.herokuapp.com/#{word}").read
    dico_query = JSON.parse(dico_query_serialized)
    dico_query['found']
  end

  def grid?(word, grid)
    word.upcase.split('').all? do |letter|
      grid.include? letter
      grid.slice!(grid.index(letter)) if grid.include? letter
    end
  end
end
