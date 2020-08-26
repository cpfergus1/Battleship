class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @empty = true
    @fired_upon = false

  end

  def empty?
    @empty
  end

  def place_ship(ship)
    @ship = ship
    @empty = false
  end

  def fire_upon
    @fired_upon = true
    if empty? == false
      ship.hit
    end
  end

  def fired_upon?
    @fired_upon
  end

  def render(optional=false)
    if fired_upon? == true && empty? == true
      "M"
    elsif fired_upon? == false && empty? == false && optional == true
      "S"
    elsif fired_upon? == true && empty? == false && @ship.sunk? == true
      "X"
    elsif fired_upon? == true && empty? == false
      "H"
    else
      "."
    end
  end
end
