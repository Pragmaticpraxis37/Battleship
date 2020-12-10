require "minitest/autorun"
require "minitest/pride"
require "./lib/cell"
require "./lib/ship"
require "./lib/board"

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_test_it_exists
    assert_instance_of Board, @board
  end

  def test_cells_are_in_hash
    assert_instance_of Hash, @board.cells
  end

  def test_cell_method_produces_sixteen_cell_objects
    @board.create_board
    assert_equal 16, @board.cells.size
  end

  def test_coordinates_are_valid
    @board.create_board

    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("D4")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("A22")
  end

  def test_coordinates_are_same_length_as_ship
    @board.create_board
    assert_equal false, @board.valid_length(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_length(@submarine, ["A2", "A3", "A4"])
  end

  def test_split_coordinates_creates_two_arrays
    test_letters = @board
    test_letters.split_coordinates(["A1", "A2"])
    assert_equal [65, 65], test_letters.consecutive_letters
    assert_equal [1, 2], test_letters.consecutive_numbers
  end


  # def test_coordinates_are_consecutive
  #   @board.create_board
  #   assert_equal false, @board.consecutive_numbers(@cruiser, ["A1", "A2", "A4"])
  #   assert_equal false, @board.consecutive_numbers(@cruiser, ["A3", "A2", "A1"])
  #   assert_equal false, @board.consecutive_numbers(@submarine, ["A1", "C1"])
  #   assert_equal false, @board.consecutive_numbers(@submarine, ["C1", "B1"])
  #   assert_equal true, @board.consecutive_numbers(@submarine, ["A1", "A2"])
  #   assert_equal false, @board.consecutive_numbers(@cruiser, ["A1","B2", "C3"])
  # end


end
