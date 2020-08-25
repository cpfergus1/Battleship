class Ship

attr_reader :name, :ship_length, :health

  def initialize(name, ship_length)
    @name = name
    @ship_length = ship_length
    @health = ship_length
  end

  def hit
    @health -= 1
  end
  

end
