require './lib/ship.rb'
require './lib/cell.rb'
require './lib/player.rb'
require './lib/board.rb'
require './lib/turn.rb'

class Game

  attr_reader :board_height, :board_length, :ship_array

  def initialize
    @computer = Player.new
    @user = Player.new
  end

  def run_game
    submarine = ["Submarine", 2]
    cruiser = ["Cruiser", 3]
    @ship_array = [cruiser,submarine]
    game_setup
    loop do
      @turn.user_takes_shot
      @turn.computer_takes_shot
      print "\n \n \n"
      puts "============ RESULTS ============"
      @turn.user_results_message
      @turn.computer_results_message
      sleep(3)
      break if check_for_loss

      system ("clear")
    end
    welcome_message
  end

  def welcome_message
    puts 'Welcome to BATTLESHIP'
    puts 'Enter p to play. Enter q to quit.'
    print '> '
    user_in = gets.chomp.downcase
    if user_in == 'p'
      @computer = Player.new
      @user = Player.new
      run_game
    elsif user_in == 'q'
      puts 'Thanks for playing BATTLESHIP!'
    else
      puts 'I am sorry, I did not understand your input.'
      welcome_message
    end
  end

  def check_for_loss
    if @computer.has_lost?
      puts '🎉🎉🎉🎉🎉🎉 You won! 🎉🎉🎉🎉🎉🎉'
      true
    elsif @user.has_lost?
      puts 'I won! 👺 👎👎'
      true
    end
  end

  def select_board_size
    user_board_size_input
    if @board_height > 26 || @board_length > 26
        puts 'BATTLESHIP is limited to 26 cells'
        select_board_size
    else
      make_board
    end
  end

  def create_ships
    ship_names = @ship_array.map {|ship| ship[0]}
    more_ships_message
    response = gets.chomp.upcase
    return ship_array if response == "NO"
    create_ship_message
    name = gets.chomp.downcase.capitalize
    puts 'How many cells will the ship occupy? (input integer)'
    print '> '
    length = Integer(gets)
    check_ship_validity(name, length)
    system('clear')
    print "\n \n"
  end

  def create_ship_message
    puts "Let's create a ship! \n"
    puts "What is the name of your ship?"
    print "> "
  end

  def more_ships_message
    print "Current Ships are #{ship_names.join(", ")} \n \n"
    puts 'Would you like to make another ship? Yes or No'
  end

  def game_setup
    select_board_size
    ships = create_ships
    @computer.get_ships(ships)
    @user.get_ships(ships)
    @turn = Turn.new(@computer, @user)
    @turn.computer_place_ships
    ship_placement_message
    @turn.user_place_ships
    system ("clear")
    puts "Let's go to war! \n \n"
  end

  def ship_placement_message
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your #{@user.ships.length} ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
  end

  def make_board
    print "\n \n"
    @user.board.make_cells(@board_length, @board_height)
    @computer.board.make_cells(@board_length, @board_height)
    system('clear')
    puts 'Does this look okay to you? Type yes to continue'
    print @user.board.render
    make_board_response
  end

  def make_board_response
    response = gets.chomp.upcase
    if response == "Y" || response == "YES"
     "Lets go to war!"
    else
      puts "Okay! Let's start over..."
      select_board_size
    end
  end

  def user_board_size_input
    puts "Let's create the board! Your board will be length by height squares"
    puts 'How long would you like the board?'
    print '> '
    @board_length = gets.chomp.to_i
    print "\n \n"
    puts 'How tall would you like the board?'
    print '> '
    @board_height = gets.chomp.to_i
  end


  def check_ship_validity(name, length)
    if (name.is_a? String) && (length <= @board_length || length <= @board_height)
      @ship_array << [name, length]
      create_ships
    elsif (length > @board_length || length > @board_height)
      puts 'Ship length must be shorter than board length and height.'
      sleep(3)
      create_ships
    end
  end
end
