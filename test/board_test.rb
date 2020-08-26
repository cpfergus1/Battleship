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
end
