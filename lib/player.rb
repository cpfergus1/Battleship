class Player
  attr_reader :board, :submarine, :cruiser

  def initialize
    @board = Board.new
    @submarine = Ship.new("Submarine", 2)
    @cruiser = Ship.new("Cruiser", 3)
  end
end
