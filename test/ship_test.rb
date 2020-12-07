require "minitest/autorun"
require "minitest/pride"
require "./lib/ship"

class ShipTest < Minitest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists_and_can_read_attributes
    assert_instance_of Ship, @cruiser
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
  end

  def test_health_starts_at_3
    assert_equal 3, @cruiser.health
  end

  def test_sunk_starts_at_false
    assert_equal false, @cruiser.sunk?
  end

  def test_hit_effects_health
    @cruiser.hit

    assert_equal 2, @cruiser.health
  end

  def test_ship_can_be_sunk
    2.times do
      @cruiser.hit
    end

    assert_equal 1, @cruiser.health

    @cruiser.hit

    assert_equal true, @cruiser.sunk?
  end
end
