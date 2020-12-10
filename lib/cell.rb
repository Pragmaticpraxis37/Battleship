class Cell
  attr_reader:coordinate,
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
    @ship.hit if @ship != nil
  end

  def render(default = false)
    return "S" if default == true && !empty?
    return '.' if @fired_upon == false
    return "M" if empty?
    return "X" if @ship.sunk? && !empty?
    return "H" if !empty?

   end
end
