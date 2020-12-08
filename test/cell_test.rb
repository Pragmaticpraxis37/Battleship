require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Cell, @cell
    assert_equal "B4", @cell.coordinate
  end

  def test_cell_without_ship_returns_nil
    assert_equal nil, @cell.ship
  end

  def test_empty_returns_true_for_cell
    assert_equal true, @cell.empty?
  end

  def test_ship_can_be_placed_on_cell
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
    assert_equal false, @cell.empty?
  end

  def test_cell_is_fired_upon
    assert_equal false, @cell.fired_upon?
  end

  def test_fire_upon_effects_cell_and_ship
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert_equal 2, @cell.ship.health
    assert_equal true, @cell.fired_upon? 
  end
end
