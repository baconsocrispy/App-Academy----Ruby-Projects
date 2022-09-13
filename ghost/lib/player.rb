#_FILE_ == $PROGRAMFILE

class Player
attr_reader "name"

    def initialize(name)
        @name = name
    end
    
    def guess
        guess = gets.chomp
        alert_invalid_guess(guess)
        guess
    end
    def alert_invalid_guess(guess)
        alphas = [*("a".."z")]
        puts "INVALID GUESS" if !alphas.include?(guess)
    end
end
