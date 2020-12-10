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
    assert_equal [1, 2],  test_letters.consecutive_numbers
  end

  def test_valid_consecutive_returns_false_or_true
    test_letters_1 = @board
    test_letters_1.split_coordinates(["A1", "A2"])
    test_letters_2 = @board
    test_letters_2.split_coordinates(["A1", "B1"])
    assert_equal false, test_letters_1.valid_consecutive_letters?
    assert_equal true, test_letters_2.valid_consecutive_letters?

  end

  def test_consecutive_numbers_can_pass_through_valid_consecutive
    test_numbers_1 = Board.new
    test_numbers_1.split_coordinates(["A1", "A2"])
    test_numbers_2 = Board.new
    test_numbers_2.split_coordinates(["A1", "B1"])
    assert_equal true, test_numbers_1.valid_consecutive_numbers?
    assert_equal false, test_numbers_2.valid_consecutive_numbers?
  end

  def test_coordinates_cannot_be_diagonal
    test_diagonal_1 = Board.new
    test_diagonal_1.split_coordinates(["A1", "B2", "C3"])
    test_diagonal_1.valid_consecutive_numbers?
    test_diagonal_1.valid_consecutive_letters?
    test_diagonal_2 = Board.new
    test_diagonal_2.split_coordinates(["C2", "D3"])
    test_diagonal_2.valid_consecutive_numbers?
    test_diagonal_2.valid_consecutive_letters?
    assert_equal false, test_diagonal_1.invalid_diagonal
    assert_equal false, test_diagonal_2.invalid_diagonal
  end

  def test_valid_placement
    @board.create_board
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
    assert_equal false, @board.valid_placement?(@submarine, ["C1", "B1"])
    assert_equal true, @board.valid_placement?(@submarine, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A1","B2", "C3"])
  end


end
