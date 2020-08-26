require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'
require './lib/cell.rb'
require './lib/board.rb'

class BoardTest <Minitest::Test

  def test_instance_of
    board = Board.new
    assert_instance_of Board, board
  end

  def test_board_has_attributes
    board = Board.new
    assert_nil nil, board.cells
    assert_equal 16, board.cells.keys.length
    assert_equal 16, board.cells.values.length
    assert_equal "A1", board.cells.values[0].coordinate
    assert_equal "D4", board.cells.values[15].coordinate
  end

  def test_valid_coordinate
    board = Board.new
    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_consecutive_coordinates
    board = Board.new
    cruiser = Ship.new("cruiser", 3)
    submarine = Ship.new("submarine", 2)
    assert_equal [["A1","A2","A3"],["A1","B1","C1"]], board.consecutive_coordinates(["A1","A4","A2"])
    assert_equal [["A3","A4"],["A3","B3","C3"]], board.consecutive_coordinates(["A3","A2","A1"])
    assert_equal [["C1","C2","C3"],["C1","D1"]], board.consecutive_coordinates(["C1","C2","C4"])
  end

  def test_valid_placement?
    board = Board.new
    cruiser = Ship.new("cruiser", 3)
    submarine = Ship.new("submarine", 2)
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_place_cruiser
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]
    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
    assert_equal true, cell_3.ship == cell_2.ship
  end
end
