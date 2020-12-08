require "minitest/autorun"
require "minitest/pride"
require "./lib/cell"
require "./lib/ship"
require "./lib/board"

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
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
end
