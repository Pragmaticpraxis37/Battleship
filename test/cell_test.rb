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

  def test_render_shows_dot
    cell_1 = Cell.new("B4")
    assert_equal ".", cell_1.render
  end

  def test_render_returns_m_if_fired_upon_without_ship
    cell_1 = Cell.new("B4")
    cell_1.fire_upon
    assert_equal "M", cell_1.render
  end

  def test_render_optional_arg_returns_S
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    assert_equal "S", cell_2.render(true)
  end

  def test_render_returns_H_for_cells_with_ships
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    cell_2.fire_upon
    assert_equal "H", cell_2.render
  end

  def test_render_returns_x_for_sunk_ships
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    cell_2.fire_upon
    assert_equal false, cruiser.sunk?
    cruiser.hit
    cruiser.hit
    assert_equal true, cruiser.sunk?
    assert_equal "X", cell_2.render
  end
end
