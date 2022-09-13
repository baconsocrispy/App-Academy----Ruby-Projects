require 'rspec'
require './lib/hand/hand.rb'
require './lib/card/card.rb'

describe Hand do
    subject(:hand) { Hand.new('carter') }

    describe '::winning_hand' do
        let(:hand1) { Hand.new('bill') }
        let(:hand2) { Hand.new('rebecca') }
        let(:hand3) { Hand.new('carter') }

        let(:card1) { Card.new(7, :clubs) }
        let(:card2) { Card.new(2, :clubs) }
        let(:card3) { Card.new(9, :clubs) }
        let(:card4) { Card.new(10, :clubs) }
        let(:card5) { Card.new(11, :diamonds) }

        let(:card6) { Card.new(5, :clubs) }
        let(:card7) { Card.new(5, :hearts) }
        let(:card8) { Card.new(5, :diamonds) }
        let(:card9) { Card.new(5, :spades) }
        let(:card10) { Card.new(2, :clubs) }

        let(:card11) { Card.new(6, :spades) }
        let(:card12) { Card.new(6, :hearts) }
        let(:card13) { Card.new(6, :diamonds) }
        let(:card14) { Card.new(13, :clubs) }
        let(:card15) { Card.new(13, :hearts) }

        it 'returns the player name with the best hand' do
            bill_cards = [card1, card2, card3, card4, card5]
            rebecca_cards = [card6, card7, card8, card9, card10]
            carter_cards = [card11, card12, card13, card14, card15]

            bill_cards.each { |card| hand1.add_card(card) }
            rebecca_cards.each { |card| hand2.add_card(card) }
            carter_cards.each { |card| hand3.add_card(card) }

            expect(hand1.player).to eq("bill")
            expect(hand1.best_play).to eq(11)
            expect(hand2.best_play).to eq(21)
            expect(Hand.winning_hand([hand1, hand2, hand3])).to eq('rebecca')
        end
    end
            

    describe '#initialize' do
        it 'sets a hand as an array' do
            expect(hand.cards).to be_an(Array)
        end

        it 'starts out empty'do
            expect(hand.cards).to be_empty
        end
        it 'sets a player name' do
            expect(hand.player).to eq('carter')
        end

    end
    describe '#add_card' do
        let(:card) { double('card') }

        it 'takes a card and adds it to hand array' do 
            hand.add_card(card)
            expect(hand.cards.count).to eq(1)
        end

        it 'does not allow more than 5 cards in array' do
            5.times { |i| hand.add_card(card) }
            expect { hand.add_card(card) }.to raise_error('Hand is already full!')
        end
    end
    describe '#discard' do
        let(:card) { double('card') }
        it 'raises error if the hand is empty' do
            expect { hand.discard([1]) }.to raise_error("No cards left to discard!")
        end

        it 'removes discarded cards from self' do
            5.times { |i| hand.add_card(card) }
            1.times { |i| hand.discard([1,2]) }
            expect(hand.cards.count).to eq(3)
        end 
    end
    describe '#best_play' do
        let(:card1) { Card.new(7, :clubs) }
        let(:card2) { Card.new(2, :clubs) }
        let(:card3) { Card.new(9, :clubs) }
        let(:card4) { Card.new(10, :clubs) }
        let(:card5) { Card.new(11, :diamonds) }

        it 'sets the hand value based on the best play from the cards' do
            hand.add_card(card1)
            hand.add_card(card2)
            hand.add_card(card3)
            hand.add_card(card4)
            hand.add_card(card5)

            expect(hand.best_play).to be(11)
        end
    end

    describe '#straight_flush?' do
        let(:card1) { Card.new(7, :clubs) }
        let(:card2) { Card.new(8, :clubs) }
        let(:card3) { Card.new(9, :clubs) }
        let(:card4) { Card.new(10, :clubs) }
        let(:card5) { Card.new(11, :clubs) }

        it 'checks if the hand contains 5 cards of sequential rank and same suit' do
            hand.add_card(card1)
            hand.add_card(card2)
            hand.add_card(card3)
            hand.add_card(card4)
            hand.add_card(card5)

            expect(hand.best_play).to be(22)
            expect(hand.straight_flush?(hand.cards)).to be(true)
            expect(hand.four_of_a_kind?(hand.cards)).to be(false)
        end
    end
    describe '#four_of_a_kind?' do 
        let(:card1) { Card.new(5, :clubs) }
        let(:card2) { Card.new(5, :hearts) }
        let(:card3) { Card.new(5, :diamonds) }
        let(:card4) { Card.new(5, :spades) }
        let(:card5) { Card.new(2, :clubs) }

        it 'checks if hand contains 4 cards of the same value' do
            hand.add_card(card1)
            hand.add_card(card2)
            hand.add_card(card3)
            hand.add_card(card4)
            hand.add_card(card5)

            expect(hand.four_of_a_kind?(hand.cards)).to be(true)
            expect(hand.straight_flush?(hand.cards)).to be(false)
            expect(hand.best_play).to be(21)
        end
    end
    describe '#full_house?' do
        let(:card1) { Card.new(6, :spades) }
        let(:card2) { Card.new(6, :hearts) }
        let(:card3) { Card.new(6, :diamonds) }
        let(:card4) { Card.new(13, :clubs) }
        let(:card5) { Card.new(13, :hearts) }

        it 'checks if hand contains 3 cards of one value and 2 cards of another' do
            hand.add_card(card1)
            hand.add_card(card2)
            hand.add_card(card3)
            hand.add_card(card4)
            hand.add_card(card5)

            expect(hand.full_house?(hand.cards)).to be(true)
            expect(hand.best_play).to be(20)
        end
    end
    describe '#flush?' do 
        let(:card1) { Card.new(11, :diamonds) }
        let(:card2) { Card.new(9, :diamonds) }
        let(:card3) { Card.new(8, :diamonds) }
        let(:card4) { Card.new(4, :diamonds) }
        let(:card5) { Card.new(3, :diamonds) }

        it 'checks if hand contains 5 cards of the same suit' do
            hand.add_card(card1)
            hand.add_card(card2)
            hand.add_card(card3)
            hand.add_card(card4)
            hand.add_card(card5)

            expect(hand.flush?(hand.cards)).to be(true)
            expect(hand.full_house?(hand.cards)).to be(false)
            expect(hand.best_play).to be(19)
        end
    end
    describe '#straight?' do
        let(:card1) { Card.new(10, :diamonds) }
        let(:card2) { Card.new(9, :spades) }
        let(:card3) { Card.new(8, :hearts) }
        let(:card4) { Card.new(7, :diamonds) }
        let(:card5) { Card.new(6, :clubs) }

        it 'checks if hand contains 5 cards of sequential rank of any suit' do
            hand.add_card(card1)
            hand.add_card(card2)
            hand.add_card(card3)
            hand.add_card(card4)
            hand.add_card(card5)

            expect(hand.straight?(hand.cards)).to be(true)
            expect(hand.best_play).to be(18)
        end
    end
    describe '#three_of_a_kind?' do
        let(:card1) { Card.new(12, :clubs) }
        let(:card2) { Card.new(12, :spades) }
        let(:card3) { Card.new(12, :hearts) }
        let(:card4) { Card.new(3, :spades) }
        let(:card5) { Card.new(2, :hearts) }

        it 'checks if hand contains 2 unique pairs' do
            hand.add_card(card1)
            hand.add_card(card2)
            hand.add_card(card3)
            hand.add_card(card4)
            hand.add_card(card5)

            expect(hand.three_of_a_kind?(hand.cards)).to be(true)
            expect(hand.best_play).to be(17)
        end
    end
    describe '#two_pair?' do
        let(:card1) { Card.new(11, :hearts) }
        let(:card2) { Card.new(11, :spades) }
        let(:card3) { Card.new(3, :clubs) }
        let(:card4) { Card.new(3, :spades) }
        let(:card5) { Card.new(2, :hearts) }

        it 'checks if hand contains 2 unique pairs' do
            hand.add_card(card1)
            hand.add_card(card2)
            hand.add_card(card3)
            hand.add_card(card4)
            hand.add_card(card5)

            expect(hand.two_pair?(hand.cards)).to be(true)
            expect(hand.best_play).to be(16)
        end
    end
    describe '#pair?' do
        let(:card1) { Card.new(12, :hearts) }
        let(:card2) { Card.new(11, :spades) }
        let(:card3) { Card.new(3, :clubs) }
        let(:card4) { Card.new(3, :spades) }
        let(:card5) { Card.new(2, :hearts) }

        it 'check if hand contains only one pair' do
            hand.add_card(card1)
            hand.add_card(card2)
            hand.add_card(card3)
            hand.add_card(card4)
            hand.add_card(card5)

            expect(hand.pair?(hand.cards)).to be(true)
            expect(hand.best_play).to be(15)
        end
    end
end