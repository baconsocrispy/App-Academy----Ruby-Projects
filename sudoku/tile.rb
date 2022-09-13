require 'colorize'
require 'colorized_string'
class Tile
    attr_accessor :value
    attr_reader :given
    
    def initialize(value)
        @value = value
        @given = value != "0" 
    end
    def to_s(color = :blue)
        @given ? @value.colorize(:red) : @value.colorize(color)
    end
end