require './lib/ship.rb'
require './lib/cell.rb'

class Board

  def cells
    cells = {}
    board_length = [1,2,3,4]
    board_height = ['A','B','C','D']
    board_height.each do |letter|
      board_length.each do |number|
        cell = Cell.new("#{letter}#{number}")
        cells["#{letter}#{number}"] = cell
      end
    end
    cells
    #require 'pry' ; binding.pry
  end


end
