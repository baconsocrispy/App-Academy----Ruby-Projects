require './lib/card/card.rb'

class Deck
    SUITS = [:spades, :clubs, :hearts, :diamonds]
    VALUES = (2..14).to_a
    def self.build_deck
        cards = []
        SUITS.each do |suit|
            VALUES.each do |value|
                cards << Card.new(value, suit)
            end
        end
        cards
    end

    attr_reader :cards
    def initialize
        @cards = Deck.build_deck
    end
    def shuffle
        @cards = @cards.shuffle
        true
    end
    def deal_cards(players)
        self.shuffle
        5.times do |i|
            players.each { |player| player.hand.add_card(@cards.shift) }
        end
        true
    end
    def empty?
        @cards.empty?
    end
end

if __FILE__ == $PROGRAM_NAME
    deck = Deck.new
    deck.shuffle
    p deck
end