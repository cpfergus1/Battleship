require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require '.lib/board'

class BoardTest <Minitest::Test

  def test_instance_of
    board = Board.new
    assert_instance_of Board, board
  end
