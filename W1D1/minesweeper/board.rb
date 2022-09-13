require_relative 'tile.rb'

class Board
    def self.empty_grid(size = 9)
        empty_board = Array.new(size) { Array.new(size) }
    end
    def initialize(grid = Board.empty_grid)
        @grid = grid
        self.populate_tiles
        self.plant_bombs
    end
    def populate_tiles
        @grid.each_with_index do |row, i1|
            row.each_with_index do |col, i2|
                pos = [i1, i2]
                self[pos] = Tile.new(self, pos)
            end
        end
        true
    end
    def plant_bombs
        bomb_positions = self.get_bomb_positions
        bomb_positions.each { |pos| self[pos].set_bomb }
    end
    def get_bomb_positions(bomb_count = 10)
        bomb_positions = []
        bomb_count.times { |i| bomb_positions << random_position(@grid) }
        bomb_positions
    end
    def render
        puts "  #{(0..8).to_a.join(" ")}"
        @grid.each_with_index do |row, idx1|
            print_array = []
            print_array << idx1.to_s
            row.each do |tile|
                print_array << tile.face_value
            end
            puts print_array.join(" ")
        end
        true
    end
    def [](pos)
        x, y = pos
        @grid[x][y]
    end
    def []=(pos, value)
        x, y = pos
        @grid[x][y] = value
    end
    def random_position(grid)
        x = rand(grid.length)
        y = rand(grid[0].length)
        pos = [x, y]
    end
    def valid_pos?(pos)
        on_board?(pos)
    end
    def on_board?(pos)
        (0 <= pos[0] && pos[0] < @grid.length) && (0 <= pos[1] && pos[1] < @grid[0].length)
    end
end

if __FILE__ == $PROGRAM_NAME
    board = Board.new
    board.render
    p board[[5,5]].bomb_positions
end
