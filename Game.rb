require_relative "Board"
require_relative "Card"

class Game
  def initialize
    @board = Board.new
    @previous_guess = nil
  end

  def get_position
    loop do
      puts 'Please enter a valid card position (for example: 0,2)'
      input = gets.chomp
      next unless valid_input?(input)

      return input.split(',').map(&:to_i)

    end
  end

  def play
    @board.render
    until @board.win?
      position = get_position
      @board[position].reveal
      guess(position)
    end
    puts 'You won!'
  end

  def guess(position)
    @board.render
    @previous_guess = position
    new_guess = get_position
    @board[new_guess].reveal
    @board.render
    unless cards_match(@previous_guess, new_guess)
      @board[new_guess].hide && @board[@previous_guess].hide
      puts 'You missed!'
      sleep 2
      @board.render
      return
    end
    puts "It's a match!"
  end

  def cards_match(pos1, pos2)
    @board[pos1] == @board[pos2]
  end

  def valid_input?(input)
    unless input.include?(',')
      puts 'Your input is invalid, use coma for separation.'
      return
    end
    pos = input.split(',').map(&:to_i)
    if pos[0] > 3 || pos[1] > 3
      puts 'Your input is invalid, enter a number between 0 and 3'
      return
    end
    true
  end

end

game = Game.new
game.play