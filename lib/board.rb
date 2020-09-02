require "./lib/ship.rb"
require "./lib/cell.rb"

class Board
  attr_reader :cells

  def initialize
    @cells = {}
    @length = []
    @height = []
  end

  def make_cells(len, hi)
    @length = [*1..len]
    @height = [*"A"..(hi + 64).chr]
    @height.each do |letter|
      @length.each do |number|
        cell = Cell.new("#{letter}#{number}")
        @cells["#{letter}#{number}"] = cell
      end
    end
    @cells
  end

  def valid_coordinate?(coordinate)
    cells[coordinate] != nil
  end

  def valid_placement?(ship, coordinates)
    if coordinates.size != ship.length
      false
    elsif consecutive_coordinates(coordinates).find { |coord| coord == coordinates } != nil && coordinates.all? { |coord| @cells[coord].empty? }
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
    [numbers, letters]
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
    row_label = @height
    column_label = @length
    board_layout = row_label.map do |row|
      column_label.map do |col|
        @cells[row + col.to_s].render(optional)
      end
    end
    print_board(row_label, column_label, board_layout)
  end

  def print_board(row_array, col_array, rendered_board)
    board = ""
    rendered_board.each_with_index do |row, index|
      board << row_array[index].to_s +
               "\t" +
               row.join("\t") +
               "\t" \
               "\n"
    end
    "\t #{col_array.join("\t")}\n" + board
  end
end
