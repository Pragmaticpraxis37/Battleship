class Ship
  attr_reader :name,
              :length,
              :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  def sunk?
    @health.zero?
  end

  def sunk
    return @name if sunk?
  end

  def hit
    @health -= 1
  end
end
