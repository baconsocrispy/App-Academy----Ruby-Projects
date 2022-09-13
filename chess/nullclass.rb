require_relative 'piece'
require 'singleton'

class NullPiece < Piece
    attr_reader :symbol, :color
    include Singleton
    def initialize
        super
        @symbol = :N
    end
    def moves
    end
end

if __FILE__ == $PROGRAM_NAME
   p NullPiece.instance.symbol
end