require "./lib/cell"
require "./lib/ship"
require "./lib/board"
class Game
  attr_reader:cpu_board,
             :player_board,
             :user_cruiser,
             :user_submarine,
             :comp_sub,
             :comp_cruiser
  def initialize
    @cpu_board = Board.new
    @player_board = Board.new
    @user_cruiser = Ship.new("Cruiser", 3)
    @user_submarine = Ship.new("Submarine", 2)
    @comp_cruiser = Ship.new("Cruiser", 3)
    @comp_submarine = Ship.new("Submarine", 2)
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
        comp_place_ship(@comp_sub, coordinates)
      end

    def assign_missing_sub_letter_coordinates(response)
      if response[0][0] == "A"
        coordinates = [response, "B" + response[-1]]
      elsif response[0][0] == "B"
      coordinates = [response, "C" + response[-1]]
    else
      coordinates = [response, "D" + response[-1]]
      end
      comp_place_ship(@comp_sub, coordinates)
    end

    def comp_place_ships(ship, coordinates)
          @cpu_board.create_board
      if @cpu_board.valid_placement?(ship, coordinates)
            coordinates.each do |coord|
          @cpu_board.cells[coord].place_ship(ship)
        end
      else
        false
      end
    end







  # def computer_sub_gen
  # coordinates = @cpu_board.cells.keys.sample(2)
  #   until @cpu_board.valid_placement?(@submarine, coordinates)
  #     coordinates = @cpu_board.cells.keys.sample(2)
  #   end
  #   coordinates
  # end
  #
  # def computer_cruiser_gen
  #   answer = @cpu_board.cells.keys.sample(3)
  #     until @cpu_board.valid_placement?(@cruiser, answer)
  #       answer = @cpu_board.cells.keys.sample(3)
  #     end
  #     answer
  #   end
  #
  #   def computer_place_sub(computer_sub_gen)
  #     @cpu_board.create_board
  #     @cpu_board.place(@submarine, computer_sub_gen)
  #   end
  #
  #   def computer_place_cruiser(computer_cruiser_gen)
  #     @cpu_board.place(@cruiser, computer_sub_gen)
  #   end

end

game = Game.new
