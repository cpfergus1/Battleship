class Turn
  attr_reader :computer, :user

  def initialize(computer, user)
    @computer = computer
    @user = user
  end

  def computer_place_ships
    ships = [computer.cruiser, computer.submarine]
    ships.each do |ship|
      loop do
      rand_coords = random_cell
      coordinates = Array.new(ship.length, rand_coords)
      possible_coords = computer.board.consecutive_coordinates(coordinates)
      possible_coords.shuffle!
      possible_coords_1 = possible_coords[0]
      possible_coords_2 = possible_coords[1]
      if computer.board.valid_placement?(ship, possible_coords_1)
        computer.board.place(ship, possible_coords_1)
        break
      elsif
        computer.board.valid_placement?(ship, possible_coords_2)
        computer.board.place(ship, possible_coords_2)
        break
      end
      end
    end
  end

  def random_cell
    computer.board.cells[computer.board.cells.keys.sample].coordinate
  end
end
