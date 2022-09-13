class Board
    def initialize
        @state_cards = state_card_deck
        @campaign_cards = campaign_card_deck
        @crisis_cards = crisis_card_deck
        @collusion_cards = collusion_card_deck
        @special_cards = special_card_deck
    end
end