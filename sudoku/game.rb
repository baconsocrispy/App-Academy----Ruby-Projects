require_relative './tile.rb'
require_relative './board.rb'

class Sudoku
    def initialize(file)
        @board = Board.new(Board.from_file(file))
    end
    def play
        until @board.solved?
            @board.render
            @board[get_position] = get_value
            p @board.solved?
        end
        puts "YOU SOLVED IT YOU DOG!"
    end
    def get_position
        puts "Enter a position:"
        pos = gets.chomp.split(",").map(&:to_i)
    end
    def get_value
        puts "Enter a value"
        value = gets.chomp
    end
end

if __FILE__ == $PROGRAM_NAME
    file = 'sudoku2.txt'
    game = Sudoku.new(file)
    game.play
end