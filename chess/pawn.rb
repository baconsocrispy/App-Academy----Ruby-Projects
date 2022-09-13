require_relative 'piece'

class Pawn < Piece
    def initialize(color, board, pos, symbol)
        super(color, board, pos)
        @symbol = symbol
    end
    def symbol
    end
    def valid_moves
        moves = [*forward_steps, *side_attacks]
        moves
    end

    private
    def at_start_row?
        return true if @color == :white && @pos[0] == 1
        return true if @color == :black && pos[0] == 6
        false
    end
    def forward_dir
        return 1 if @color == :white
        return -1 if @color == :black
    end
    def forward_steps
        steps = []
        row, col = @pos
        if at_start_row? && !@board.position_blocked?([row + forward_dir]) && !@board.position_blocked?([row + forward_dir + forward_dir]) 
            steps << [row + forward_dir, col]
            steps << [row + (2 * forward_dir), col]
        elsif !@board.position_blocked?([row + forward_dir, col]) && @board.valid_pos?([row + forward_dir, col])
            steps << [row + forward_dir, col]
        end
    end
    def side_attacks
        attacks = []
        row, col = @pos
        pos1 = [row + forward_dir, col + 1 ]
        pos2 = [row + forward_dir, col - 1 ]
        positions = [pos1, pos2]
        positions.each do |pos|
            if @board.position_blocked?(pos) && @board[pos].color != @color
                attacks << pos
            end
        end
        attacks
    end
end

if __FILE__ == $PROGRAM_NAME
   p piece = Pawn.new(:white, 7, [1,0], :P)
end