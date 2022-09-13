require 'rspec'
require './lib/deck/deck.rb'

describe Deck do 
    subject(:deck) { Deck.new }

    describe '::build_deck' do
        it 'creates an array of 52 cards' do
            expect(Deck.build_deck.count).to eq(52)
        end
    end

    describe '#initialize' do
        it 'creates a new deck of 52 cards' do
            expect(deck.cards.count).to eq(52)
        end
    end

    describe '#shuffle' do
        let(:new_deck) { Deck.new }
        it 'shuffles the deck' do 
            new_deck.shuffle
            expect(new_deck.cards).to_not eq(Deck.build_deck)
        end
    end

    describe '#deal_card' do
        let(:new_deck) { Deck.new }
        let(:deck_copy) { new_deck.dup }
        it 'removes one card from the deck' do
            deck.deal_card
            expect(deck.cards.count).to eq(51)
        end
    end

    describe '#deck_empty?' do
        it 'returns true if the deck array is empty' do
            52.times { |i| deck.deal_card }
            expect(deck.cards).to be_empty
        end
    end
end

