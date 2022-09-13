

class Maze
    attr_reader :grid

    def initialize(maze_file)
        @grid = File.readlines(maze_file).map(&:chomp).map(&:chars)
        @next_position = nil
        @current_position = self.start
        @previous_position = self.start
    end

    #main methods
    def run
        system("clear")
        puts "UNSOLVED MAZE"
        self.print_grid
        self.move_position until @current_position == self.end
        @grid[@previous_position[0]][@previous_position[1]] = "X" 
        puts "SOLVED-ASS MAZE"
        self.print_grid
    end

    def move_position
        @next_position = self.optimal_move
        @grid[@previous_position[0]][@previous_position[1]] = "X" if @previous_position != self.start
        @previous_position = @current_position
        @current_position = self.optimal_move
    end

    #positional methods
    def valid_position?(pos)
        return false if @grid[pos[0]][pos[1]] == "*" || @grid[pos[0]][pos[1]] == "X" || @grid[pos[0]][pos[1]] == nil
        true
    end
    def valid_moves
        valids = []
        valids << self.up if self.valid_position?(self.up)
        valids << self.down if self.valid_position?(self.down)
        valids << self.right if self.valid_position?(self.right)
        valids << self.left if self.valid_position?(self.left)
        valids
    end
    def optimal_move
        valids = self.valid_moves
        optimal = nil

        valids.each do |position|
            if optimal == nil
                optimal = position
            elsif manhattan(position) < manhattan(optimal)
                optimal = position
            end
        end
        optimal
    end

    def manhattan(position)
        (position[0] - self.end[0]).abs + (position[1] - self.end[1]).abs
    end

    def start
        @grid.each_with_index do |row, idx1|
            row.each_with_index do |col, idx2|
                if col == "S"
                    return [idx1, idx2]
                end
            end
        end
        false
    end
    def end
        @grid.each_with_index do |row, idx1|
            row.each_with_index do |col, idx2|
                if col == "E"
                    return [idx1, idx2]
                end
            end
        end
        false
    end
    def up
        [@current_position[0] - 1, @current_position[1]]
    end

    def down
        [@current_position[0] + 1, @current_position[1]]
    end

    def right
        [@current_position[0], @current_position[1] + 1]
    end

    def left
        [@current_position[0], @current_position[1] - 1]
    end
    

    #UI Methods
    def print_grid
        @grid.each do |row|
            print row
            puts
        end
        true
    end
end

maze = Maze.new("maze1.txt")

p maze.run