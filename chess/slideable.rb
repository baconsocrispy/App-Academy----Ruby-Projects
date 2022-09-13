require 'byebug'
module Slideable
    def moves
        moves = []
        dirs = move_dirs
        dirs.each { |dir| moves.concat(grow_unblocked_moves_in_dir(dir)) }
        moves
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
    def grow_unblocked_moves_in_dir(dir)
        moves = []
        dx, dy = dir
        row, col = @pos
        until !@board.valid_pos?([row + dx, col + dy]) || @board.position_blocked?([row + dx, col + dy])
            row += dx
            col += dy
            moves << [row, col]
        end
        moves << [row + dx, col + dy] if @board.position_blocked?([row + dx, col + dy]) && @board[[row + dx, col + dy]].color != @color
        moves
    end
end