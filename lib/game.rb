require "./lib/cell"
require "./lib/ship"
require "./lib/board"
class Game
  attr_reader:cpu_board,
             :player_board,
             :user_cruiser,
             :user_submarine,
             :comp_sub,
             :comp_cruiser,
             :cpu_ships_placed
  def initialize
    @cpu_board = Board.new
    @player_board = Board.new
    @user_cruiser = Ship.new("Cruiser", 3)
    @user_submarine = Ship.new("Submarine", 2)
    @comp_cruiser = Ship.new("Cruiser", 3)
    @comp_submarine = Ship.new("Submarine", 2)
    @cpu_ships_placed = false
  end
  def vertical_or_horizontal_cruiser
    array = ["v", "h"].sample
    if array == "v"
    vertical_cruiser_letter_coordinate
    else
    horizontal_cruiser_number_coordinate
    end
  end
  def vertical_cruiser_letter_coordinate
    array = ["A", "B"].sample
    vertical_cruiser_number_coordinate(array)
  end
  def horizontal_cruiser_number_coordinate
    array = [1, 2].sample
    horizontal_cruiser_letter_coordinate(array)
  end
  def vertical_cruiser_number_coordinate(array)
    array2 = [1,2,3,4].sample
    join_letters(array, array2)
  end
  def horizontal_cruiser_letter_coordinate(array)
    array2= ["A", "B", "C", "D"].sample
    join_numbers(array2, array)
  end
  def join_letters(array, array2)
    response = [array , array2.to_s].join
    assign_missing_letter_coordinates(response)
  end
  def join_numbers(array2, array)
    response = [array2 , array.to_s].join
    assign_missing_number_coordinates(response)
  end
  def assign_missing_number_coordinates(response)
      if response [-1] == "1"
        coordinates = [response, response[0] + "2", response[0] + "3"]
      else
        coordinates = [response, response[0] + "3", response[0] + "4"]
      end
      comp_place_ships(@comp_cruiser, coordinates)
    end
  def assign_missing_letter_coordinates(response)
    if response[0][0] == "A"
      coordinates = [response, "B" + response[-1], "C" + response[-1]]
    else
    coordinates = [response, "C" + response[-1], "D" + response[-1]]
    end
    comp_place_ships(@comp_cruiser, coordinates)
  end
  def vertical_or_horizontal_sub
      array = ["v", "h"].sample
      if array == "v"
      vertical_sub_letter_coordinate
      else
      horizontal_sub_number_coordinate
      end
    end
  def vertical_sub_letter_coordinate
    array = ["A", "B", "C"].sample
    vertical_sub_number_coordinate(array)
  end
  def horizontal_sub_number_coordinate
    array = [1, 2, 3].sample
    horizontal_sub_letter_coordinate(array)
  end
  def vertical_sub_number_coordinate(array)
    array2 = [1,2,3,4].sample
    join_sub_letters(array, array2)
  end
  def horizontal_sub_letter_coordinate(array)
    array2= ["A", "B", "C", "D"].sample
    join_sub_numbers(array2, array)
  end
  def join_sub_letters(array, array2)
    response = [array , array2.to_s].join
    assign_missing_sub_letter_coordinates(response)
  end
  def join_sub_numbers(array2, array)
    response = [array2 , array.to_s].join
    assign_missing_sub_number_coordinates(response)
  end
  def assign_missing_sub_number_coordinates(response)
    if response[-1] == "1"
      coordinates = [response, response[0] + "2"]
    elsif response[-1] == "2"
      coordinates = [response, response[0] + "3"]
    else
      coordinates = [response, response[0] + "4"]
    end
    comp_place_ships(@comp_submarine, coordinates)
  end
  def assign_missing_sub_letter_coordinates(response)
    if response[0][0] == "A"
      coordinates = [response, "B" + response[-1]]
    elsif response[0][0] == "B"
      coordinates = [response, "C" + response[-1]]
    else
      coordinates = [response, "D" + response[-1]]
    end
      comp_place_ships(@comp_submarine, coordinates)
  end
  def comp_place_ships(ship, coordinates)
    if @cpu_board.valid_placement?(ship, coordinates)
      coordinates.each do |coord|
        @cpu_board.cells[coord].place_ship(ship)
      end
    else
      vertical_or_horizontal_sub
    end
    @cpu_ships_placed = true
  end
  def player_place_ships(ship, coordinates)
    @player_board.create_board
    until @player_board.valid_placement?(@user_cruiser, coordinates) == true
      puts "Invalid Placement, Try Again"
      coordinates = gets.chomp.upcase.split(" ")
    end
      @player_board.place(@user_cruiser, coordinates)
      puts @player_board.render(true)
      puts "Enter the squares for the Submarine (2 spaces):
    >"
      coordinates = gets.chomp.upcase.split(" ")
        until @player_board.valid_placement?(@user_submarine, coordinates) == true
      puts "Invalid Placement, Try Again"
      coordinates = gets.chomp.upcase.split(" ")
    end
      @player_board.place(@user_submarine, coordinates)
      puts @player_board.render(true)
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
  coordinates = gets.chomp.upcase.split(" ")
  player_place_ships(@user_cruiser, coordinates)
  end

  def turn
    while (@user_cruiser.sunk? == false && @user_submarine.sunk? == false) ||
      (@comp_cruiser.sunk? == false && @comp_submarine.sunk? == false)
    if @cpu_ships_placed == false
    @cpu_board.create_board
    vertical_or_horizontal_cruiser
    vertical_or_horizontal_sub
    puts "=============COMPUTER BOARD============="
    puts @cpu_board.render(true)
    puts "==============PLAYER BOARD=============="
    player_ship_placement_cruiser
  else
    puts "=============COMPUTER BOARD============="
    puts @cpu_board.render(true)
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
    player_shoot
      end
    end
  end

  def player_shoot
    puts ' Choose the coordinate for your shot'
    user_coordinate = gets.chomp.upcase
    if @cpu_board.valid_coordinate?(user_coordinate) && @cpu_board.cells[user_coordinate].fired_upon? != true
      @cpu_board.cells[user_coordinate].fire_upon
      player_results(user_coordinate)
    else
      puts "That is an invalid_coordinate. Please try again:"
      player_shoot
    end
  end

  def computer_shot
    shoot = @player_board.cells.keys.sample
    until @player_board.cells[shoot].fired_upon? != true
      shoot
    end
    @player_board.cells[shoot].fire_upon
    computer_results(shoot)
  end

  def computer_results(shoot)
    if @player_board.cells[shoot].empty?
    
      puts "My shot on #{shoot} was a miss."
      game_start
    elsif @player_board.cells[shoot].ship.sunk? == false
      puts "My shot on #{shoot} was a hit."
      game_start
    else
      puts "My shot on #{shoot} sunk your #{@player_board.cells[shoot].ship.sunk}."
      game_start
    end
  end

  def player_results(user_coordinate)
    if @cpu_board.cells[user_coordinate].empty?
      puts "Your shot on #{user_coordinate} was a miss."
      computer_shot
    elsif @cpu_board.cells[user_coordinate].ship.sunk? == false
      puts "Your shot on #{user_coordinate} was a hit."
      computer_shot
    else
      puts "Your shot on #{user_coordinate} sunk my #{@cpu_board.cells[user_coordinate].ship.sunk}."
      computer_shot
    end
  end

  def end_game
    if (@user_cruiser.sunk? == true && @user_submarine.sunk? == true) ||
      (@comp_cruiser.sunk? == true && @comp_submarine.sunk? == true)
      game_over_message
    else

      turn
    end
  end

  def game_over_message
    if @user_cruiser.sunk? == true && @user_submarine.sunk? == true
      puts "I win"
    else
      puts "You win"
    end
  end


  def game_start
    end_game
  end
end
game = Game.new
require "pry"; binding.pry
