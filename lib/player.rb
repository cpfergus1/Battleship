class Player
  attr_reader :board, :ships

  def initialize
    @board = Board.new
    @ships = []

  end

  def get_ships
    @ships << @submarine = Ship.new("Submarine", 2)
    @ships << @cruiser = Ship.new("Cruiser", 3)
  end

  def has_lost?
    @ships.all? {|ship| ship.sunk?}
  end

end
