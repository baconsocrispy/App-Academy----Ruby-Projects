require 'rspec'
require './lib/card/card.rb'

describe Card do
    subject(:card) { Card.new(13, :hearts) }
    
    describe '#initialize' do
        it 'sets a value' do 
            expect(card.value).to eq(13)
        end

        it 'sets a suit' do
            expect(card.suit).to eq(:hearts)
        end

        it 'starts revealed as false' do
            expect(card.revealed).to be(false)
        end
    end

    describe '#flip' do
        it 'changes revealed from true to false or false to true' do
            card.flip
            expect(card.revealed).to be(true)
            card.flip
            expect(card.revealed).to be(false)
        end
    end

    describe 'to_s' do
        it 'converts the card value and suit to a string' do
            expect(card.to_s).to eq("KH")
        end
    end
end