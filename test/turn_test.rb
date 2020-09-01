require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'
require './lib/cell.rb'
require './lib/player.rb'
require './lib/board.rb'
require './lib/turn.rb'

class TurnTest <  Minitest::Test
  def test_it_exists
    skip
    computer = Player.new
    user = Player.new
    turn = Turn.new(computer, user)

    assert_instance_of Turn, turn
  end

  def test_computer_can_place_ships
    skip
    computer = Player.new
    user = Player.new
    turn = Turn.new(computer, user)

    turn.computer_place_ships
    assert_equal false, computer.board.cells.empty?
  end

  def test_user_can_place_ships
    skip
    computer = Player.new
    user = Player.new
    turn = Turn.new(computer, user)

    turn.user_place_ships
    assert_equal false, user.board.cells.empty?
  end

  def test_user_can_fire_a_shot
    skip
    computer = Player.new
    user = Player.new
    turn = Turn.new(computer, user)

    puts "Please input 'A3' as your shot."
    turn.user_takes_shot
    assert_equal true, computer.board.cells["A3"].fired_upon?
  end

  def test_computer_can_fire_a_shot
    computer = Player.new
    user = Player.new
    turn = Turn.new(computer, user)

    turn.computer_takes_shot
    assert_equal true, user.board.cells.values.any?{|cell| cell.fired_upon?}
  end


  # def test_user_can_take_turn
  #   computer = Player.new
  #   user = Player.new
  #   turn = Turn.new(computer, user)
  #
  #   turn.user_turn
  # end
end
