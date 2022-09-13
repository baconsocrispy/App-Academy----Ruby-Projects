require './lib/poker.rb'

describe Poker do 
    subject(:game) { Poker.new('carter', 'bill', 'rebecca') }

    describe '#initialize' do
        it 'sets the players' do
            expect(game.players.count).to eq(3)
        end
        
        it 'sets the pot' do 
            expect(game.pot).to eq(0)
        end
        
        it 'tracks the round' 
        
        it 'tracks the current player'
        
        it 'tracks the ante'

        it 'holds the deck'
    end
    describe '#deal_cards' do
        it 'creates a new deck'

        it 'shuffles the deck'

        it 'deals five cards to all player hands'
    end
    describe '#game_play' do
        it 'cycles rounds until a player wins'

        it 'adds the pot to the winning player pot'

        it 'resets the pot, round and deck and rotates players'
    end
    describe '#round_play' do
        it 'creates an array of players who are not bust'

        it 'deals the cards'
    end
    def 
    describe '#turn' do
        it 'shows renders the hand and pot'

        it 'prompts the player for a decision'

        it 'implements discarding if it is round 2'

        it 'removes player from round participants if they fold'

        it 'it adds a bet to the pot'

        it 'advances to the next player'

        it ''
    end
    describe '#round' do
        it 'tracks the current pot'

        it 'tracks the current player'

        it 'tracks the current bet'

        it 'advances to the next round all players have had a turn'
    end
    describe '#round_over?' do
        it 'returns true when all players have gone'
    end

    describe '#game_over?' do
        it 'returns true when a player has won'
    end
    describe '#still_standing' do
        it 'gets an array of players who are not bust'
    end
end