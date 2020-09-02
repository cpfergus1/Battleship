require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/ship.rb"
require "./lib/cell.rb"
require "./lib/player.rb"
require "./lib/board.rb"
require "./lib/turn.rb"
require "./lib/game.rb"

class GameTest < Minitest::Test
  def test_instance_of
    game = Game.new
    assert_instance_of Game, game
  end
end
