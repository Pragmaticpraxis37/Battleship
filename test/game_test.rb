require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @cpu_board = Board.new
    @player_board = Board.new
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_submarine = Ship.new("Submarine", 2)
    @possible_targets = %w[A1 A2 A3 A4 B1 B2 B3 B4 C1 C2 C3 C4 D1 D2 D3 D4]
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Game, @game
  end

  def test_computer_comp_place_ships
    game = Game.new
    game.cpu_board.create_board
    game.vertical_or_horizontal_cruiser

    assert_equal 3, game.cpu_board.render(true).count("S")
  end

  def test_computer_comp_place_cruiser_and_sub
    game = Game.new
    game.cpu_board.create_board
    game.vertical_or_horizontal_cruiser
    game.vertical_or_horizontal_submarine

    assert_equal 5, game.cpu_board.render(true).count("S")
  end

  def test_computer_can_choose_random_orientation
    game = Game.new
    game.cpu_board.create_board
    assert_equal true , game.vertical_or_horizontal_cruiser
  end

  def test_creating_boards
    game = Game.new
    game.player_board.create_board
    assert_instance_of Hash, game.player_board.cells
  end

  def test_possible_targets_loses_one_every_turn
    game = Game.new
    game.player_board.create_board
    game.cpu_board.create_board
    require "pry"; binding.pry
  end
end
