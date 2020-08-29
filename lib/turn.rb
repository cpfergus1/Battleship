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
      break if check_random_coord_validity(ship, possible_coords[0], possible_coords[1])
    end
    end
    #require "pry"; binding.pry
  end

  def user_place_ships
    ships = [user.cruiser, user.submarine]
    ships.each do |ship|
      user.board.render(true)
      puts "Enter the squares for the #{ship.name} (#{ship.health} spaces):"
      loop do
        print ">"
        user_input_coordinates = gets.chomp.split(' ')
        break if check_user_input_validity(ship, user_input_coordinates)
      end
    end
    #require "pry"; binding.pry
  end


  def check_user_input_validity(ship, coordinates)
    if coordinates.all? {|coord| user.board.valid_coordinate?(coord)} &&
      user.board.valid_placement?(ship,coordinates)
      user.board.place(ship, coordinates)
      return true
    elsif coordinates.all? {|coord| user.board.valid_coordinate?(coord)}
      puts "Invalid placement, please choose consecutive spaces on the board."
      return false
    else
      puts "Invalid coordnates, please make sure all your coordinates are on the board"
      return false
    end
  end



  def check_random_coord_validity(ship, possible_coords_1, possible_coords_2)
    #equire "pry"; binding.pry
    if computer.board.valid_placement?(ship, possible_coords_1)
      computer.board.place(ship, possible_coords_1)
      return true

    elsif computer.board.valid_placement?(ship, possible_coords_2)
      computer.board.place(ship, possible_coords_2)
      return true
    end
  end

  def random_cell
    computer.board.cells[computer.board.cells.keys.sample].coordinate
  end
end
