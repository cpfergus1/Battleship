require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'


class TestShip <Minitest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_instance_of
    assert_instance_of Ship, @cruiser
  end

  def test_ship_has_attributes
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.ship_length
    assert_equal 3, @cruiser.health
  end

  def test_ship_has_been_hit
    assert_equal 2, @cruiser.hit
    assert_equal 1, @cruiser.hit
    assert_equal 0, @cruiser.hit
  end

  def test_ship_has_sunk
    assert_equal false, @cruiser.sunk?
    @cruiser.hit
    assert_equal false, @cruiser.sunk?
    @cruiser.hit
    assert_equal false, @cruiser.sunk?
    @cruiser.hit
    assert_equal true, @cruiser.sunk?
  end
end
