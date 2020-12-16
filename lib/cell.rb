class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    @ship.hit if !@ship.nil?
  end

  def render(default = false)
    return 'S' if default == true && !empty? && @fired_upon == false
    return '.' if @fired_upon == false
<<<<<<< HEAD
    return "M" if empty?
    return "X" if @ship.sunk? && !empty?
    return "H" if !empty?
=======
    return 'M' if empty?
    return 'X' if @ship.sunk? && !empty?
    return 'H' unless empty?
>>>>>>> 3b0e0f2420baa4f63180281a5b9bee3a32a20d21
  end
end
