require './lib/cell'
require './lib/ship'
require './lib/board'
require './lib/messages'
require './lib/turn'


@board = Board.new

require "pry"; binding.pry


flag = false

while flag
  coordinates = generate_numbers
  ship = Ship.new
  board = Board.new
  flag = valid_placement?(ship, coordinates) 
end
