require "./lib/cell"


class Board
  attr_reader :cells

  def initialize
    @cells = Hash.new
  end

  def create_board
    coordinate_array = %w[A1 A2 A3 A4 B1 B2 B3 B4 C1 C2 C3 C4 D1 D2 D3 D4]
    coordinate_array.each do |one_coordinate|
      @cells[one_coordinate] = Cell.new(one_coordinate)
    end
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  def valid_length(ship, coordinates)
    ship.length == coordinates.length
  end

  def valid_consecutive_numbers?(coordinates)
    x = split_numbers(coordinates)

    answer = x.each_cons(2).all? do |a ,b|

      b == a + 1

    end
    answer
  end

  def valid_consecutive_letters?(coordinates)
    y = split_letters(coordinates)

    answer = y.each_cons(2).all? do |a ,b|
      b == a + 1
    end
    answer
  end

  def invalid_diagonal(coordinates)
    if valid_consecutive_letters?(coordinates) && valid_consecutive_numbers?(coordinates) == true
      false
    else
      true
    end
  end

  def split_numbers(coordinates)
    consecutive_numbers = []
    coordinates.each do |coord|
      consecutive_numbers << coord[1].to_i
    end
    consecutive_numbers
  end

  def split_letters(coordinates)
    consecutive_letters = []
    coordinates.each do |coord|
      consecutive_letters << coord[0].ord
    end

    consecutive_letters
  end

  def valid_placement?(ship, coordinates)

    split_letters(coordinates)
    split_numbers(coordinates)
    if invalid_diagonal(coordinates) == false
      return false
    else

    valid_length(ship, coordinates) &&
    valid_consecutive_numbers?(coordinates) &&
    overlap(coordinates) ||
    valid_length(ship, coordinates) &&
    valid_consecutive_letters?(coordinates) &&
    overlap(coordinates)
    end
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coord|
        @cells[coord].place_ship(ship)
      end
    else
      false
    end
  end

  def overlap(coordinates)
    if coordinates.any? do |coord|
      @cells[coord] != nil
      return false
    else
      return true
      end
    end
  end
end
