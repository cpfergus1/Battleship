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
  
end

def welcome_message
  puts 'Welcome to BATTLESHIP'
  puts 'Enter p to play. Enter q to quit.'
  loop do
    print '> '
    user_in = gets.chomp.downcase
    if user_in == 'p'
      run_game
    elsif user_in == 'q'
      break
    else
      puts 'I am sorry, I did not understand your input. Please enter p to play or enter q to quit.'
    end
  end
end

end
