class Turn
  attr_reader :computer, :user

  def initialize(computer, user)
    @computer = computer
    @user = user
  end

  def computer_place_ships

  end

  def random_cell
    computer.board.cells[computer.board.cells.keys.sample].coordinate
  end
end
