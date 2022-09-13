class ComputerPlayer
    ROWS = 4
    COLS = 4
    def initialize
        @guessed_positions = []
        @matched_cards = []
    end
    def prompt
        row = (0...ROWS).sample
        col = (0...COLS).sample
        pos = [row, col]
        until valid_pos?(pos)
            row = (0...ROWS).sample
            col = (0...COLS).sample
            pos = [row, col]
        end
        @guessed_positions << pos
        pos
    end
    def valid_pos?(pos)
        return false if @guessed_positions.include?(pos)
        return false if @matched_cards.include?(pos)
    end
end 