class Turn
  attr_reader :computer, :user, :user_shot, :computer_shot

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
  end

  def user_place_ships
    ships = [user.cruiser, user.submarine]
    ships.each do |ship|
      print user.board.render(true)
      puts "Enter the squares for the #{ship.name} (#{ship.health} spaces):"
      print ">"
      user_input_coordinates = gets.chomp.upcase.split(' ')
      check_user_input_validity(ship, user_input_coordinates)
    end
    print user.board.render(true)
  end


  def check_user_input_validity(ship, coordinates)
    loop do
      if coordinates.all? {|coord| user.board.valid_coordinate?(coord)} &&
        user.board.valid_placement?(ship,coordinates)
        user.board.place(ship, coordinates)
        return
      elsif coordinates.all? {|coord| user.board.valid_coordinate?(coord)}
        puts "Invalid placement, please choose consecutive spaces on the board."
        print ">"
        coordinates = gets.chomp.upcase.split(' ')
      else
        puts "Invalid coordnates, please make sure all your coordinates are on the board"
        print ">"
        coordinates = gets.chomp.upcase.split(' ')
      end
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
    user_shot = nil
    puts "=============COMPUTER BOARD============="
    print @computer.board.render
    puts "=============PLAYER BOARD============="
    print @user.board.render(true)
    puts "Enter the coordinate for your shot:"
    print "> "
    loop do
      user_shot = gets.chomp.upcase
      if !@computer.board.valid_coordinate?(user_shot)
        puts "Please enter a valid coordinate:"
        print "> "
      elsif @computer.board.cells[user_shot].fired_upon?
        puts "This coordinate has already been fired upon."
        puts "Please enter another coordinate."
        print "> "
      else
        break
      end
    end
    @computer.board.cells[user_shot].fire_upon
    user_results_message(user_shot)
  end

  def computer_takes_shot
    loop do
      @computer_shot = @user.board.cells.keys.sample
      if @user.board.valid_coordinate?(@computer_shot) && !@user.board.cells[@computer_shot].fired_upon?
        break
      end
    end
    @user.board.cells[@computer_shot].fire_upon
  end

  def user_results_message(coordinate)
    if @computer.board.cells[coordinate].render == "H"
      puts "Your shot on #{coordinate} was a hit!"
    elsif @computer.board.cells[coordinate].render == "M"
      puts "Your shot on #{coordinate} was a miss!"
    elsif @computer.board.cells[coordinate].render == "X"
      puts "Your shot on #{coordinate} sunk my #{@computer.board.cells[coordinate].ship}!"
    end
  end
end
