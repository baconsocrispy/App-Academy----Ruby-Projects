class HumanPlayer
    def initialize
    end
    def prompt
        pos = gets.chomp.split(",").map { |char| char.to_i }
        pos
    end
end