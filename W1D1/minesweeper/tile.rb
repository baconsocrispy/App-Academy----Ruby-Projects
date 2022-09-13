require_relative 'board.rb'
require 'byebug'

class Tile
    attr_reader :fringe_value, :face_value, :position, :revealed, :bomb, :flagged
    def initialize(board, pos)
        @board = board
        @position = pos
        @revealed = false
        @flagged = false
        @bomb = false
        @fringe_value = 0
        @face_value = "*"
    end
    def reveal
        @revealed = true
        @fringe_value > 0 ? @face_value = @fringe_value.to_s : @face_value = "_"
    end
    def set_flag
        @flagged = true
        @face_value = "F"
    end
    def set_bomb
        @bomb = true
    end
    def inspect
        @fringe_value.inspect
    end
    def neighbors 
        neighbor_positions = []
        row = @position[0] 
        col = @position[1] 
        (-1..1).each do |num1|
            (-1..1).each do |num2|
                pos = [row + num1, col + num2]
                neighbor_positions << pos if @board.valid_pos?(pos) && pos != @position
            end
        end
        neighbor_positions
    end
    def bomb_positions
        adjacents = self.neighbors
        bombs = []
        adjacents.each do |pos|
            if @board[pos] == nil
                next
            elsif @board[pos].bomb
                bombs << pos
                @fringe_value += 1
            end
        end
        bombs
    end
end

