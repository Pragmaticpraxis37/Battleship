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
      #valid_placement
  end

  

  def consecutive_numbers(ship, coordinates)
    collect = []
    coordinates.each do |coord|
      collect << coord[1].to_i
    end
    tracker = collect[0].to_i
    collect.each_cons(2).all? do |a ,b|
      b == a + 1

    # return_value = nil
    # collect.each do |number|
    #
    #   if number == tracker
    #     return_value = true
    #     tracker += 1
    #   else
    #     return_value = false
    #   end
    # end
    # return_value
  end

  end
end
