module Stepable
    def moves
        moves = []
        row, col = @pos
        move_diffs.each do |diffs|
            arr = diffs
            dx, dy = arr
            pos = [row + dx, col + dy]
            moves << pos if @board.valid_pos?(pos) && !@board.position_blocked?(pos)
            moves << pos if @board.position_blocked?(pos) && @board[pos].color != @color
        end
        moves
    end

    private
    def move_diffs
    end
end
