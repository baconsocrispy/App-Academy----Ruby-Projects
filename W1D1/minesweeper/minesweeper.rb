require_relative 'tile.rb'
require_relative 'board.rb'

class Game

    def initialize
        @board = Board.new
    end

    # def run
    #     until @board.won? || @board.lost?
    #         @board.render
    #         take_turn
    #     end
    # end
    # def take_turn
    #     pos = get_position
    #     reveal_tiles(pos)
    # end
    # def reveal_tiles(pos)
    #     if @board[pos].fringe_value > 0

    # end
end


if __FILE__ == $PROGRAM_NAME
    game = Game.new
    p game
end