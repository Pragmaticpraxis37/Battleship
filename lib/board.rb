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

    return false if invalid_diagonal(coordinates) == false
    return false if  overlap(coordinates) == false


    valid_length(ship, coordinates) &&
    valid_consecutive_numbers?(coordinates) ||
    valid_length(ship, coordinates) &&
    valid_consecutive_letters?(coordinates)

  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coord|
        @cells[coord].place_ship(ship)

      end
    end
  end

  def overlap(coordinates)
    coordinates.all? do |coord|
      return false if @cells[coord] == nil
      @cells[coord].empty?
    end
  end

  def render(default = false)
    "   1 2 3 4 \n" +
    " A #{@cells["A1"].render(default)} #{@cells["A2"].render(default)} #{@cells["A3"].render(default)} #{@cells["A4"].render(default)} \n" +
    " B #{@cells["B1"].render(default)} #{@cells["B2"].render(default)} #{@cells["B3"].render(default)} #{@cells["B4"].render(default)} \n" +
    " C #{@cells["C1"].render(default)} #{@cells["C2"].render(default)} #{@cells["C3"].render(default)} #{@cells["C4"].render(default)} \n" +
    " D #{@cells["D1"].render(default)} #{@cells["D2"].render(default)} #{@cells["D3"].render(default)} #{@cells["D4"].render(default)}"
  end
end
