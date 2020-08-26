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
end
