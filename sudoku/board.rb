require_relative './tile.rb'


class Board
    VALUES = ("1".."9").to_a
    def self.from_file(file)
        grid_lines = File.readlines(file).map(&:chomp)
        Board.create_tiles(grid_lines)
    end
    def self.create_tiles(lines)
        sudoku_board = []
        lines.each do |line|
            grid_line = []
            line.each_char do |char|
                grid_line << Tile.new(char)
            end
            sudoku_board << grid_line
        end
        sudoku_board
    end
    def initialize(grid)
        @grid = grid
    end
    def [](pos)
        row, col = pos
        @grid[row][col]
    end
    def []=(pos, value)
        self[pos].given ? false : self[pos].value = value
    end
    def render
        system('clear')
        @grid.each do |row|
            row.each do |tile|
                if tile.given || tile.value == "0" 
                    print tile.to_s 
                else
                    print tile.to_s.colorize(:white)
                end
            end
            puts 
        end
        true
    end
    def solved?
        return true if self.rows_solved? && self.cols_solved? && self.squares_solved?
        false
    end
    def rows_solved?
        @grid.each do |row|
            row_values = []
            row.each do |tile|
                row_values << tile.value
            end
            return false unless VALUES.all? { |num_str| row_values.include?(num_str) }
        end
        true
    end
    def cols_solved?
        col_values = []
        @grid.transpose.each do |col|
            col.each do |tile|
                col_values << tile.value
            end
            return false unless VALUES.all? { |num_str| col_values.include?(num_str) }
        end
        true
    end
    def squares_solved?
        ranges = [(0..2),(3..5),(6..8)]
        ranges.each do |row_range|
            ranges.each do |col_range|
                square_values = get_square(row_range, col_range)
                return false unless VALUES.all? { |num_str| square_values.include?(num_str) }
            end
        end
        true
    end
    def get_square(row_range, col_range)
        square_values = []
        row_range.each do |idx1|
            col_range.each do |idx2|
                tile = @grid[idx1][idx2]
                square_values << tile.value
            end
        end
        square_values
    end
end

if __FILE__ == $PROGRAM_NAME
    grid = Board.from_file('sudoku2.txt')
    board = Board.new(grid)
    board.render
    p board.solved?
end