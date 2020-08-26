require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class  CellTest<  Minitest::Test
  def test_it_exists_and_has_attributes
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
    assert_equal "B4", cell.coordinate
    assert_nil nil, cell.ship
  end

  def test_cell_starts_empty
    cell = Cell.new("B4")

    assert_equal true, cell.empty?
  end

  def test_it_can_place_ship
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
    assert_equal false, cell.empty?
  end
end
