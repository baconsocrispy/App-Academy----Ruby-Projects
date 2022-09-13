require_relative 'piece'
require_relative 'rookbishopqueen'
require_relative 'knightking'
require_relative 'nullclass'
require_relative 'pawn'

class Board
    attr_reader :rows
    def initialize
        @rows = Array.new(8) { Array.new(8) {NullPiece.instance} }
        self.add_pieces
    end
    def add_pieces
        start_rows = [0,1,6,7]
        start_rows.each do |row|
            @rows[row].each_index do |col|
                color = row == 0 || row == 1 ? :white : :black
                pos = [row, col]
                self[pos] = RookBishopQueen.new(color, self, pos, :Q)
            end
        end
        true
    end
    def [](position)
        row, col = position
        @rows[row][col]
    end
    def []=(position, value)
        row, col = position
        @rows[row][col] = value
    end
    def move_piece(start_pos, end_pos)
        raise "Position not on board!" if !valid_pos?(start_pos) || !valid_pos?(end_pos)
        raise "There's no piece at that position!" if !self[start_pos].is_a?(Piece)
        piece = self[start_pos]
        piece.pos = end_pos
        self[end_pos] = piece
        self[start_pos] = nil
    end

    def valid_pos?(pos)
        row, col = pos
        row.between?(0,7) && col.between?(0,7)
    end
    def position_blocked?(pos)
        self[pos].is_a?(Piece)
    end

    def add_piece(piece, pos)
        self[pos] = piece
    end

    def checkmate?(color)
    end

    def in_check?(color)
    end

    def find_king(color)
    end

    def pieces
    end

    def dup
    end

    def move_piece!(color, start_pos, end_pos)
    end
    private
    @sentinel = nil
end

if __FILE__ == $PROGRAM_NAME
    board = Board.new
    p board
end