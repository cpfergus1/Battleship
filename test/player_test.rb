require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'
require './lib/cell.rb'
require './lib/player.rb'
require './lib/board.rb'
require './lib/turn.rb'

class PlayerTest <  Minitest::Test

  def test_it_exists
    computer = Player.new
    user = Player.new

    assert_instance_of Player, computer
    assert_instance_of Player, user
  end

  def test_player_has_a_board
    computer = Player.new
    user = Player.new

    assert_instance_of Board, user.board
    assert_instance_of Board, computer.board
  end

  def test_player_can_make_ships
    computer = Player.new
    user = Player.new
    ships_array = [["Cruiser", 3],["Submarine", 2]]
    user.get_ships(ships_array)
    require "pry"; binding.pry
    assert_equal 2, user.ships.size
  end
end
