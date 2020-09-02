class Player
  attr_reader :board, :ships

  def initialize
    @board = Board.new
    @ships = []
  end

  def get_ships(ships_array)
    @ships = ships_array.map do |ship|
      Ship.new(ship[0], ship[1])
    end
  end

  def has_lost?
    @ships.all? {|ship| ship.sunk?}
  end
end
