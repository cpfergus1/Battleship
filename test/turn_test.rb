require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/ship.rb'
require './lib/cell.rb'
require './lib/player.rb'
require './lib/board.rb'
require './lib/turn.rb'

class TurnTest <  Minitest::Test
  def setup
    @computer = Player.new
    @user = Player.new
    @board = Board.new
    @user.board.make_cells(4,4)
    @computer.board.make_cells(4,4)
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @user.get_ships([@cruiser, @submarine])
    @computer.get_ships([@cruiser, @submarine])
    @turn = Turn.new(@computer, @user)
  end

  def test_it_exists
    assert_instance_of Turn, @turn
  end

  def test_computer_can_place_ships
    assert_equal true, @computer.board.cells.values.all? {|cell| cell.empty?}
    @turn.computer_place_ships
    assert_equal false, @computer.board.cells.values.all? {|cell| cell.empty?}
  end

  def test_user_can_place_ships
    assert_equal true, @user.board.cells.values.all? {|cell| cell.empty?}
    @turn.user_place_ships
    assert_equal false, @user.board.cells.values.all? {|cell| cell.empty?}
  end

  def test_user_can_fire_a_shot
    @turn.expects(:gets).returns('A3')
    @turn.user_takes_shot
    assert_equal true, @computer.board.cells["A3"].fired_upon?
  end

  def test_computer_can_fire_a_shot
    @turn.computer_takes_shot
    assert_equal true, @user.board.cells.values.any?{|cell| cell.fired_upon?}
  end

end
