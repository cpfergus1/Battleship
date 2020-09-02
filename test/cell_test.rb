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

  def test_it_can_be_fired_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    assert_equal false, cell.fired_upon?
    cell.fire_upon
    assert_equal 2, cell.ship.health
    assert_equal true, cell.fired_upon?
  end

  def test_cell_render
    cell = Cell.new("B4")
    assert_equal '.', cell.render
    cell.fire_upon
    assert_equal 'M', cell.render
    cell2 = Cell.new("C3")
    cruiser = Ship.new("cruiser", 3)
    cell2.place_ship(cruiser)
    assert_equal 'S', cell2.render(true)
    cell2.fire_upon
    assert_equal 'H', cell2.render
    cell2.fire_upon
    cell2.fire_upon
    assert_equal 'X', cell2.render
  end
end
