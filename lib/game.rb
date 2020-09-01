require './lib/ship.rb'
require './lib/cell.rb'
require './lib/player.rb'
require './lib/board.rb'
require './lib/turn.rb'

class Game
  def initialize
    @computer = Player.new
    @user = Player.new
  end

  def run_game
    select_board_size
    @computer.get_ships
    @user.get_ships
    turn = Turn.new(@computer, @user)
    turn.computer_place_ships
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    turn.user_place_ships
    system ("clear")
    puts "Let's go to war! \n \n"
    loop do
      turn.user_takes_shot
      turn.computer_takes_shot
      print "\n \n \n"
      puts "============ RESULTS ============"
      turn.user_results_message
      turn.computer_results_message
      sleep(4)
      break if check_for_loss
      system ("clear")
    end
  end

  def welcome_message
    loop do
      puts 'Welcome to BATTLESHIP'
      puts 'Enter p to play. Enter q to quit.'
      print '> '
      user_in = gets.chomp.downcase
      if user_in == 'p'
        run_game
      elsif user_in == 'q'
        puts 'Thanks for playing BATTLESHIP!'
        break
      else
        puts 'I am sorry, I did not understand your input.'
      end
    end
  end

  def check_for_loss
    if @computer.has_lost?
      puts '🎉🎉🎉🎉🎉🎉 You won! 🎉🎉🎉🎉🎉🎉'
      return true
    elsif @user.has_lost?
      puts 'I won! 👺 👎👎'
      return true
    end
  end

  def select_board_size
    puts "Let's create the board! Your board will be length by height squares"
    loop do
      puts 'How long would you like the board?'
      print '> '
      board_length = gets.chomp.to_i
      print "\n \n"
      puts 'How tall would you like the board?'
      print '> '
      board_height = gets.chomp.to_i
      if board_height > 26 || board_length > 26
        puts 'BATTLESHIP is limited to 26 cells'
      else
        print "\n \n"
        @user.board.make_cells(board_length, board_height)
        @computer.board.make_cells(board_length, board_height)
        system('clear')
        puts 'Does this look okay to you? Type yes to continue'
        print @user.board.render
        response = gets.chomp.upcase
        if response == "Y" || response == "YES"
        break
        else
          puts "Okay! Let's start over..."
        end
      end
    end
  end
end
