class Piece
    attr_reader :color
    def initialize(color, board, pos)
        @color, @board, @pos = color, board, pos
        @symbol = :symbol
    end
    def to_s
        @symbol.to_s
    end

    def empty?
        
    end

    def valid_moves
        self.moves
    end

    def pos=(val)
        @pos = val
    end

    def symbol
    end
    def inspect
        { 'color' => @color, 'position' => @pos }.inspect
    end
    private
    def move_into_check?(end_pos)
    end
end

if __FILE__ == $PROGRAM_NAME
   p piece = Piece.new(:white, 7, [0,0])
end