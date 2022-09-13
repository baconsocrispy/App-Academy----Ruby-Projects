require 'rspec'
require './rspechw.rb'

describe Array do
    subject(:my_array) { [1,1,3,5,7,7,"a","a","b"] }

    describe "#my_uniq" do
        it 'raises a no method error if subject is not an array' do
            expect { "This is not an array".my_uniq }.to raise_error(NoMethodError)
        end
    
        it 'returns a new Array' do
            expect(my_array.my_uniq).to be_an(Array)
        end

        it 'returns an array of unique elements' do
            expect([1,1,2,2,3,3,4,4,5,5,"a","a","b"].my_uniq).to eq([1,2,3,4,5,"a","b"])
        end
    end 

    describe '#two_sum' do
        it 
end

