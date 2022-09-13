class Hand
    HAND_RANK = { 
        :straight_flush? => 22, 
        :four_of_a_kind? => 21,
        :full_house? => 20,
        :flush? => 19,
        :straight? => 18,
        :three_of_a_kind? => 17,
        :two_pair? => 16,
        :pair? => 15,
    }
    
    def self.winning_hand(hands)
        best_hand = nil
        hands.each do |hand|
            best_hand = hand if best_hand.nil?
            best_hand = hand if hand.best_play > best_hand.best_play

            #NEED TO FINISH TIE-BREAKER LOGIC
            tied = hand.best_play == best_hand.best_play
            case best_hand
            when tied && hand.straight_flush?(hand.cards)
                best_hand = hand if hand.high_card_value > best_hand.high_card_value
            when tied && hand.four_of_a_kind?(hand.cards)
                best_hand = hand if hand.high_card_value > best_hand.high_card_value
            end
        end
        best_hand.player
    end

    attr_reader :cards, :player
    def initialize(player_name)
        @player = player_name
        @cards = []
    end
    def add_card(card)
        raise "Hand is already full!" if @cards.count >= 5
        @cards << card
    end
    def discard(card_positions)
        card_positions.sort.reverse.each do |card_position|
            raise "No cards left to discard!" if @cards.empty?
            @cards.delete_at(card_position)
        end
    end
    def best_play
        HAND_RANK.each { |play, value| return value if self.send(play, self.cards) }
        high_card_value(self.cards).nil? ? 0 : high_card_value(self.cards)
    end
    
    
    #hand-ranking logic
    def straight_flush?(cards)
        straight?(cards) && flush?(cards)
    end
    def straight?(cards)
        values = card_values(cards)
        values.each_cons(2).all? { |a, b| b == a + 1 }
    end
    def flush?(cards)
        cards.all? { |card| card.suit == cards[0].suit }
    end
    def four_of_a_kind?(cards)
        values = card_values(cards)
        values.one? { |card_value| card_value != values[2] }
    end
    def full_house?(cards)
        three_of_a_kind?(cards) && pair?(cards)
    end
    def three_of_a_kind?(cards)
        values = card_values(cards)
        values.each_cons(3).any? { |a, b, c| a == b && b == c }
    end
    def two_pair?(cards)
        pairs = []
        values = card_values(cards)
        values.each { |value| pairs << value if values.count(value) == 2 } 
        pairs.uniq.count == 2
    end
    def pair?(cards)
        values = card_values(cards)
        values.any? { |value| values.count(value) == 2 } 
    end
    def high_card?(cards)
        values = card_values(cards)
        values.none? { |value| values.count(value) >= 2 } && !flush?(cards) 
    end

    #helpers
    def card_values(cards)
        card_values = []
        cards.each { |card| card_values << card.value }
        card_values.sort
    end
    def high_card_value(cards)
        card_values(cards).last
    end
end

if __FILE__ == $PROGRAM_NAME

end