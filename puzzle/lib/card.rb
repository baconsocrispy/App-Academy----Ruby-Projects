class Card
    attr_reader :face_up
    def initialize(value)
        @face_value = value
        @face_up = false
    end

    def display
        return @face_value if @face_up
        "0"
    end
    def hide
        @face_up = false
    end
    def reveal
        @face_up = true
    end
    def to_s
        @face_value
    end
    def ==(card)
        return true if self.to_s == card.to_s
        false
    end
end