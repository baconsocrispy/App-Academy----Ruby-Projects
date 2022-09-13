class Card
    FACE_CARD_SYMBOLS = { 
        11 => "J", 
        12 => "Q", 
        13 => "K", 
        14 => "A" 
    }

    SUIT_SYMBOLS = { 
        :hearts => "H", 
        :diamonds => "D", 
        :spades => "S", 
        :clubs => "C"
    }

    attr_reader :value, :suit, :revealed
    def initialize(value, suit)
        @value = value
        @suit = suit
        @revealed = false
        @color = @suit == :clubs || @suit == :spades ? :black : :red
    end
    def flip
        @revealed == false ? @revealed = true : @revealed = false
    end
    def to_s
        face, suit = FACE_CARD_SYMBOLS[@value], SUIT_SYMBOLS[@suit]
        @value > 10 ? face + suit : @value.to_s + suit
    end
end