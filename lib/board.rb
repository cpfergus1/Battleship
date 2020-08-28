require './lib/ship.rb'
require './lib/cell.rb'

class Board


  attr_reader :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  # def make_cells
  #
  #   board_length = [1,2,3,4]
  #   board_height = ['A','B','C','D']
  #   board_height.each do |letter|
  #     board_length.each do |number|
  #       cell = Cell.new("#{letter}#{number}")
  #       cells["#{letter}#{number}"] = cell
  #     end
  #   end
  #   @cells
  #   require 'pry' ; binding.pry
  # end

  def valid_coordinate?(coordinate)
    #require 'pry' ; binding.pry

    cells[coordinate] != nil
  end

  def valid_placement?(ship, coordinates)
    #require "pry"; binding.pry
    if coordinates.size != ship.length
      false
    elsif consecutive_coordinates(coordinates).find{|coord| coord == coordinates} != nil && coordinates.all?{|coord| @cells[coord].empty?}
      true
    else
      false
    end
  end


  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    end
  end

  def consecutive_coordinates(coordinates)
    numbers = valid_row(coordinates)
    letters = valid_col(coordinates)
    [numbers,letters]
  end

  def valid_row(coordinates)
    numbers = []
    coordinates.size.times do |count|
      new_coordinate = "#{coordinates[0][0]}#{coordinates[0][1].to_i + count}"
      if valid_coordinate?(new_coordinate)
        numbers << new_coordinate
      end
    end
    numbers
  end

    def valid_col(coordinates)
      letters = []
      coordinates.size.times do |count|
        new_coordinate_2 = "#{(coordinates[0][0].ord + count).chr}#{coordinates[0][1]}"
        if valid_coordinate?(new_coordinate_2)
          letters << new_coordinate_2
        end
      end
      letters
    end

  def render(optional = false)
    row_label = ["A","B","C","D"]
    column_label = ["1","2","3","4"]
    board_layout = row_label.map do |row|
      column_label.map do |col|
        @cells[row + col].render(optional)
      end
    end
    string = print_board(row_label, column_label, board_layout)
  end

  def print_board(row_array, col_array, rendered_board)
      board = ""
      rendered_board.each_with_index do |row,index|
        board << row_array[index].to_s +
        "\t" +
        row.join("\t") +
        "\t" +
        "\n"
      end
      string = "\t #{col_array.join("\t")}\n" + board
  end
end
