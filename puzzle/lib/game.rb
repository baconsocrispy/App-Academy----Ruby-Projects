require_relative('./card.rb')
require_relative('./board.rb')
require_relative('./human.rb')

class Game
    def initialize
        @board = Board.new
        @player = HumanPlayer.new
        @first_guess = []
        @second_guess = []
    end
    def play
        self.start
        until @board.won?
            make_first_guess(self.get_position)
            make_second_guess(self.get_position)
            self.adjust_board
            self.reset_guesses
        end
        puts "GAME OVER"
    end   
    def make_first_guess(pos)
        @first_guess = pos    
        @board.flip_card(pos)
        @board.render
    end
    def make_second_guess(pos)
        @second_guess = pos
        @board.flip_card(pos)
        @board.render
    end
    def get_position
        puts "Make a guess (e.g. '1,2')"
        pos = @player.prompt
        until @board.valid_pos?(pos)
            puts "INVALID POSITION"
            pos = @player.prompt
        end
        pos
    end
    def adjust_board
        if !self.match?
            sleep(2)
            @board.flip_card(@first_guess)
            @board.flip_card(@second_guess)
            @board.render
        end
    end
    def reset_guesses
        @first_guess = []
        @second_guess = []
    end
    def start
        @board.populate
        @board.render
    end
    def match?
        @board[@first_guess] == @board[@second_guess]
    end
end

if __FILE__ == $PROGRAM_NAME
    game = Game.new
    game.play
end
