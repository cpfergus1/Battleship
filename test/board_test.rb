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
end
