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

  def start_game
    @game.
  end
end
