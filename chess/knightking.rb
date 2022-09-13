require_relative 'piece'
require_relative 'stepable'
require_relative 'board'
class KnightKing < Piece
    include Stepable
    def initialize(color, board, pos, symbol)
        super(color, board, pos)
        @symbol = symbol
    end
    
    private
    def move_diffs
        king = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0],[1, 1]]
        knight = [[-2, -1], [-2, 1],[-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
        @symbol == :K ? king : knight
    end
end

if __FILE__ == $PROGRAM_NAME
   p piece = KnightKing.new(:white, Board.new, [0,1],:K)
   p piece.valid_moves
end