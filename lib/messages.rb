require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'

class Messages
  def initialize
    @game = Game.new
  end

  def main_menu
    puts "Welcome to BATTLESHIP Enter p to play. Enter q to quit."
    player_input = gets.chomp.downcase
    if  player_input == "p" || "P"
       start_game
     elsif player_input == "q" || "Q"
       exit
     else
       puts "Invalid response. Use p or q"
       main_menu
    end
  end

  def player_ship_placement_cruiser
    puts "I have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is three units long and the Submarine is two units long.
  1 2 3 4
A . . . .
B . . . .
C . . . .
D . . . .
Enter the squares for the Cruiser (3 spaces):
>"

  placement = gets.chomp.upcase.split(" ")
  end

  def player_ship_placement_submarine

    @game.render_player_board 

    puts "Enter the squares for the Submarine (2 spaces):
  >"

  end

  def start_game
    @game
  end
end

messages = Messages.new
require "pry"; binding.pry
