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

  def valid_coordinate?(coordinate)
    cells[coordinate] != nil
  end

  def valid_placement?(ship, coordinates)
    if coordinates.length != ship.length
      false
    elsif consecutive_coordinates(ship, coordinates).find{|coord| coord == coordinates} != nil
      true
    else
      false
    end
  end



  def consecutive_coordinates(ship, coordinates)
    valid_array_horizontal = []
    valid_array_vertical = []
    ship.length.times do |count|
      new_coordinate = "#{coordinates[0][0]}#{coordinates[0][1].to_i + count}"
      if valid_coordinate?(new_coordinate)
        valid_array_horizontal << new_coordinate
      end
      new_coordinate_2 = "#{(coordinates[0][0].ord + count).chr}#{coordinates[0][1]}"
      if valid_coordinate?(new_coordinate_2)
        valid_array_vertical << new_coordinate_2
      end
    end
    if valid_array_vertical.size < ship.length
      valid_array_vertical = nil
    end
    if valid_array_horizontal.size < ship.length
      valid_array_horizontal = nil
    end
    possible_array = [valid_array_horizontal,valid_array_vertical]
    end
  end
