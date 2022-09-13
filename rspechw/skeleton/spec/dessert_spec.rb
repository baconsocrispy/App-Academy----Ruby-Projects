require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  subject(:dessert) { Dessert.new("pie", 100, chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq("pie")
    end
    it "sets a quantity" do 
      expect(dessert.quantity).to eq(100)
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("pie", "10", "carter") }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      dessert.add_ingredient("apple")

      expect(dessert.ingredients).to include("apple")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      dessert.add_ingredient("apple")
      dessert.add_ingredient("sugar")
      dessert.add_ingredient("crust")
      dessert.mix!

      expect(dessert.ingredients).to_not eq(["apple", "sugar", "crust"])
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      dessert.eat(10)

      expect(dessert.quantity).to eq(90)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { dessert.eat(1000) }.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do 
      allow(chef).to receive(:titleize).and_return("Chef Carter the Great Baker")
      expect(dessert.serve).to eq("Chef Carter the Great Baker has made 100 pies!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end
