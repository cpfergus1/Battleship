class Turn
  attr_reader :computer, :user, :user_shot, :computer_shot

  def initialize(computer, user)
    @computer = computer
    @user = user
  end

  def computer_place_ships
    ships = computer.ships
    ships.each do |ship|
      loop do
        rand_coords = random_cell
        coordinates = Array.new(ship.length, rand_coords)
        possible_coords = computer.board.consecutive_coordinates(coordinates)
        possible_coords.shuffle!
        break if check_random_coord_validity(ship, possible_coords[0], possible_coords[1])
      end
    end
  end

  def user_place_ships
    ships = user.ships
    ships.each do |ship|
      print user.board.render(true)
      puts "Enter the squares for the #{ship.name} (#{ship.health} spaces):"
      print ">"
      user_input_coordinates = gets.chomp.upcase.split(" ")
      check_user_input_validity(ship, user_input_coordinates)
    end
    print user.board.render(true)
  end

  def check_user_input_validity(ship, coordinates)
    if check_coordinates?(coordinates) && valid_ship_placement?(ship, coordinates)
      user.board.place(ship, coordinates)
      return
    elsif check_coordinates?(coordinates)
      puts "Invalid placement, please choose consecutive spaces on the board."
      print ">"
      coordinates = gets.chomp.upcase.split(" ")
      check_user_input_validity(ship, coordinates)
    else
      puts "Invalid coordnates, please make sure all your coordinates are on the board"
      print ">"
      coordinates = gets.chomp.upcase.split(" ")
      check_user_input_validity(ship, coordinates)
    end
  end

  def check_random_coord_validity(ship, possible_coords_1, possible_coords_2)
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

  def user_takes_shot
    @user_shot = nil
    puts "=============COMPUTER BOARD============="
    print @computer.board.render
    puts "=============PLAYER BOARD============="
    print @user.board.render(true)
    puts "Enter the coordinate for your shot:"
    print "> "
    @user_shot = gets.chomp.upcase
    user_shot_check
  end

  def computer_takes_shot
    @computer_shot = @user.board.cells.keys.sample
    if computer_shot_valid?
      @user.board.cells[@computer_shot].fire_upon
    else
      computer_takes_shot
    end
  end

  def user_results_message
    if @computer.board.cells[user_shot].render == "H"
      puts "Your shot on #{user_shot} was a hit!"
    elsif @computer.board.cells[user_shot].render == "M"
      puts "Your shot on #{user_shot} was a miss!"
    elsif @computer.board.cells[user_shot].render == "X"
      puts "Your shot on #{user_shot} sunk my #{@computer.board.cells[user_shot].ship.name}!"
    end
  end

  def computer_results_message
    if @user.board.cells[@computer_shot].render == "M"
      puts "My shot on #{computer_shot} was a miss."
    elsif @user.board.cells[@computer_shot].render == "H"
      puts "My shot on #{computer_shot} was a hit."
    elsif @user.board.cells[@computer_shot].render == "X"
      puts "My shot on #{computer_shot} has sunk your #{@computer.board.cells[computer_shot].ship.name}!"
    end
  end

  def check_coordinates?(coordinates)
    coordinates.all? { |coord| user.board.valid_coordinate?(coord) }
  end

  def valid_ship_placement?(ship, coordinates)
    user.board.valid_placement?(ship, coordinates)
  end

  def user_shot_check
    if !@computer.board.valid_coordinate?(@user_shot)
      puts "Please enter a valid coordinate:"
      user_takes_shot
    elsif @computer.board.cells[@user_shot].fired_upon?
      puts "This coordinate has already been fired upon."
      puts "Please enter another coordinate."
      user_takes_shot
    else
      @computer.board.cells[user_shot].fire_upon
    end
  end

  def computer_shot_valid?
    @user.board.valid_coordinate?(@computer_shot) && !@user.board.cells[@computer_shot].fired_upon?
  end
end
