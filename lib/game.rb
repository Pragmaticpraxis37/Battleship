require "./lib/cell"
require "./lib/ship"
require "./lib/board"
require './lib/messages'
class Game
  attr_reader:cpu_board,
             :player_board,
             :user_cruiser,
             :user_submarine,
             :cpu_submarine,
             :cpu_cruiser,
             :cpu_ships_placed,
             :message

  def initialize
    @cpu_board = Board.new
    @player_board = Board.new
    @user_cruiser = Ship.new("Cruiser", 3)
    @user_submarine = Ship.new("Submarine", 2)
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_submarine = Ship.new("Submarine", 2)
    @cpu_ships_placed = false
    @possible_targets = %w[A1 A2 A3 A4 B1 B2 B3 B4 C1 C2 C3 C4 D1 D2 D3 D4]
    @message = Messages.new
  end


  def setup

    main_menu
    until end_game
      turn
    end
    game_over_message
    board_reset
    setup
  end

  def main_menu
    @message.welcome_message
    player_input = gets.chomp.downcase
    if player_input == "p"
      player_create_board
    elsif player_input == "q"
      exit
    else
      @message.main_menu_invalid
      main_menu
    end
  end

  def end_game
    @user_cruiser.sunk? == true && @user_submarine.sunk? == true ||
    @cpu_cruiser.sunk? == true && @cpu_submarine.sunk? == true
  end

  def turn
    if @cpu_ships_placed == false
      computer_setup_board
      player_setup_board
    else
    shoot_setup
    player_shoot
    end
  end

  def computer_setup_board
    @cpu_board.create_board
    vertical_or_horizontal_cruiser
    vertical_or_horizontal_submarine
    @message.computer_boarder
    puts @cpu_board.render
  end

  def player_setup_board
    @message.player_boarder
    player_ship_placement_cruiser
  end

  def vertical_or_horizontal_cruiser

    orientation = %w[v, h].sample
    if orientation == "v"
      vertical_cruiser_letter_coordinate
    else
      horizontal_cruiser_number_coordinate
    end
  end

  def vertical_cruiser_letter_coordinate
    column = %w[A, B].sample
    vertical_cruiser_number_coordinate(column)
  end

  def horizontal_cruiser_number_coordinate
    row = [1, 2].sample
    horizontal_cruiser_letter_coordinate(row)
  end

  def vertical_cruiser_number_coordinate(column)
    select_row = [1, 2, 3, 4].sample
    join_letters(column, select_row)
  end

  def horizontal_cruiser_letter_coordinate(row)
    select_column = ["A", "B", "C", "D"].sample
    join_numbers(select_column, row)
  end

  def join_letters(column, select_row)
    response = [column, select_row.to_s].join
    assign_missing_letter_coordinates(response)
  end

  def join_numbers(select_column, row)
    response = [select_column, row.to_s].join
    assign_missing_number_coordinates(response)
  end

  def assign_missing_number_coordinates(response)
    if response[-1] == "1"
      coordinates = [response, response[0] + "2", response[0] + "3"]
    else
      coordinates = [response, response[0] + "3", response[0] + "4"]
    end
      cpu_valid_placement?(@cpu_cruiser, coordinates)
  end

  def assign_missing_letter_coordinates(response)
    if response[0] == "A"
      coordinates = [response, "B" + response[-1], "C" + response[-1]]
    else
      coordinates = [response, "C" + response[-1], "D" + response[-1]]
    end
    cpu_valid_placement?(@cpu_cruiser, coordinates)
  end

  def vertical_or_horizontal_submarine
    orientation = ["v", "h"].sample
    if orientation == "v"
      vertical_submarine_letter_coordinate
    else
      horizontal_submarine_number_coordinate
    end
  end

  def vertical_submarine_letter_coordinate
    column = ["A", "B", "C"].sample
    vertical_submarine_number_coordinate(column)
  end

  def horizontal_submarine_number_coordinate
    row = [1, 2, 3].sample
    horizontal_submarine_letter_coordinate(row)
  end

  def vertical_submarine_number_coordinate(column)
    select_row = [1, 2, 3, 4].sample
    join_submarine_letters(column, select_row)
  end

  def horizontal_submarine_letter_coordinate(row)
    select_column = ["A", "B", "C", "D"].sample
    join_submarine_numbers(select_column, row)
  end

  def join_submarine_letters(select_column, row)
    response = [select_column, row.to_s].join
    assign_missing_submarine_letter_coordinates(response)
  end

  def join_submarine_numbers(column, select_row)
    response = [column, select_row.to_s].join
    assign_missing_submarine_number_coordinates(response)
  end

  def assign_missing_submarine_number_coordinates(response)
    if response[-1] == "1"
      coordinates = [response, response[0] + "2"]
    elsif response[-1] == "2"
      coordinates = [response, response[0] + "3"]
    else
      coordinates = [response, response[0] + "4"]
    end
    cpu_valid_placement?(@cpu_submarine, coordinates)
  end

  def assign_missing_submarine_letter_coordinates(response)
    if response[0] == "A"
      coordinates = [response, "B" + response[-1]]
    elsif response[0] == "B"
      coordinates = [response, "C" + response[-1]]
    else
      coordinates = [response, "D" + response[-1]]
    end
    cpu_valid_placement?(@cpu_submarine, coordinates)
  end

  def cpu_valid_placement?(ship, coordinates)
    if @cpu_board.valid_placement?(ship, coordinates)
      coordinates.each do |coord|
        @cpu_board.cells[coord].place_ship(ship)
      end
      @cpu_board.place(ship, coordinates)
    else
      vertical_or_horizontal_submarine
    end
    @cpu_ships_placed = true
  end

  def player_ship_placement_validation(ship, coordinates)
    until @player_board.valid_placement?(ship, coordinates) == true
      @message.invalid_placement_message
      coordinates = gets.chomp.upcase.split(" ")
    end
    player_ship_placement(ship, coordinates)
  end

  def player_validate_placement(ship, coordinates)
    player_ship_placement_validation(@user_cruiser, coordinates)
    puts @player_board.render(true)
    @message.submarine_place_message
    coordinates = gets.chomp.upcase.split(" ")
    player_ship_placement_validation(@user_submarine, coordinates)
    puts @player_board.render(true)
  end

  def player_create_board
    @player_board.create_board
    turn
  end

  def player_ship_placement(ship, coordinates)
    @player_board.place(ship, coordinates)
  end

  def player_ship_placement_cruiser
    @message.player_ship_cruiser_message
      coordinates = gets.chomp.upcase.split(" ")
    player_validate_placement(@user_cruiser, coordinates)
  end

  def shoot_setup
    @message.computer_boarder
    puts @cpu_board.render
    @message.player_boarder
    puts @player_board.render(true)
  end

  def player_shoot
    @message.player_shoot_message
    user_coordinate = gets.chomp.upcase
    if @cpu_board.valid_coordinate?(user_coordinate) && @cpu_board.cells[user_coordinate].fired_upon? != true
      @cpu_board.cells[user_coordinate].fire_upon
      player_results(user_coordinate)
    else
      @message.invalid_shot_message
      player_shoot
    end
  end

  def computer_shot
    if @cpu_cruiser.sunk? && @cpu_submarine.sunk?
      end_game
    else
      shoot = @possible_targets.sample
      @player_board.cells[shoot].fire_upon
      @possible_targets.delete(shoot)
      computer_results(shoot)
    end
  end

  def computer_results(shoot)
    if @player_board.cells[shoot].empty?
      @message.computer_shot_miss(shoot)
    elsif @player_board.cells[shoot].ship.sunk? == false
      @message.computer_shot_hit(shoot)
    else
      puts "Found it! My shot at #{shoot} sent your #{@player_board.cells[shoot].ship.sunk} back to Davey Jones Locker!"
    end
  end

  def player_results(user_coordinate)
    if @cpu_board.cells[user_coordinate].empty?
      @message.player_shot_miss(user_coordinate)
    elsif @cpu_board.cells[user_coordinate].ship.sunk? == false
      @message.player_shot_hit(user_coordinate)
    else
      puts "Your shot #{user_coordinate} sent my #{@cpu_board.cells[user_coordinate].ship.sunk} to Davey Jones Locker."
    end
    computer_shot
  end


  def game_over_message

    if @user_cruiser.sunk? == true && @user_submarine.sunk? == true
      @message.cpu_win_message
    elsif @cpu_cruiser.sunk? == true && @cpu_submarine.sunk? == true
      @message.player_win_message
    end
  end

  def board_reset
    @cpu_board = Board.new
    @player_board = Board.new
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_submarine = Ship.new("Submarine", 2)
    @user_cruiser = Ship.new("Cruiser", 3)
    @user_submarine = Ship.new("Submarine", 2)
    @cpu_ships_placed = false
    @possible_targets = %w[A1 A2 A3 A4 B1 B2 B3 B4 C1 C2 C3 C4 D1 D2 D3 D4]
  end
end
