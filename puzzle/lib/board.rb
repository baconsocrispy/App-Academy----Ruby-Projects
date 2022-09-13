require_relative('./card.rb')

class Board
    BOARDSIZE = 4
    PAIRS = 8
    def initialize
        @grid = Array.new(BOARDSIZE) { Array.new(BOARDSIZE) }
    end
    def populate
        card_stack = self.shuffle_cards
        place_card(card_stack.shift) until card_stack.empty?
    end
    def shuffle_cards
        cards = []
        PAIRS.times do |x|
            card = Card.new(("A".."Z").to_a.sample)
            cards << card 
            cards << card.dup
        end
        cards.shuffle!
    end
    def flip_card(position)
        card = self[position]
        card.face_up ? card.hide : card.reveal
    end
    def render
        system('clear')
        @grid.each do |row|
            row.each do |card|
                print card.display
            end
            puts 
        end
        true
    end
    def valid_pos?(pos)
        return false if pos.empty?
        self.on_board?(pos) && self[pos].display == "0"
    end
    def won?
        self.grid_positions.all? { |pos| self[pos].face_up == true }
    end
    def [](pos)
        row, col = pos
        @grid[row][col]
    end
    def []=(pos, value)
        row, col = pos
        @grid[row][col] = value
    end
    def place_card(card)
        card_position = self.empty_positions[0]
        self[card_position] = card
    end
    def on_board?(pos)
        pos[0] < @grid.length && pos[1] < @grid[0].length 
    end
    def grid_positions
        positions = []
        @grid.each_index do |row|
            @grid.each_index do |col|
                pos = [row, col]
                positions << pos
            end
        end
        positions
    end
    def empty_positions
        self.grid_positions.select { |pos| self[pos] == nil }
    end
end



    