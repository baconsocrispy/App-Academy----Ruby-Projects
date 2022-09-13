require_relative 'piece'
require_relative 'slideable'


class RookBishopQueen < Piece
    include Slideable
    def initialize(color, board, pos, symbol)
        super(color, board, pos)
        @symbol = symbol
    end

    private
    def move_dirs
        inline = [[0, 1],[0, -1], [-1, 0], [1, 0]]
        diag = [[-1, -1],[-1, 1],[1, -1], [1, 1]]
        if @symbol == :Q
            return [*inline, *diag]
        elsif @symbol == :B
            return diag
        else
            return inline
        end
    end
end

if __FILE__ == $PROGRAM_NAME
   p piece = RookBishopQueen.new(:white, 7, [0,0], :R)
end