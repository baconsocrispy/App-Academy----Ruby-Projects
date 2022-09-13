require './lib/hand/hand.rb'

class Player
    attr_reader :name, :hand, :pot, :bust, :folded
    attr_accessor :current_bet
    def initialize(name)
        @name = name
        @hand = Hand.new(name)
        @pot = 0
        @folded = false
        @bust = @pot > 0
        @current_bet = 0
    end
    def increase_pot(amount)
        @pot += amount
    end
    #discarding
    def swap_cards(new_cards)
        #error handling for when discard positions are more or less than new card count
        return if new_cards.empty?
        old_cards = get_discard_positions
        @hand.discard(old_cards)
        new_cards.each { |card| @hand.add_card(card) }
    end
    def get_discard_positions
        #Needs error handling if positions are not entered correctly
        puts "#{self.name}, enter cards you would like to discard (i.e. 1,3,4):"
        positions = gets.chomp.split(',').map(&:to_i)
        card_positions = positions.map { |pos| pos - 1 }
    end

    #prompts/display
    def swap_prompt
        display_hand
        puts "#{@name}, how many cards would you like to exchange? (0 - 5):"
        gets.chomp.to_i
    end
    def display_hand
        system("clear")
        puts "#{@name}: $#{@pot}"
        @hand.cards.each { |card| print "#{card.to_s}  " }
        puts
        puts '1   2   3   4   5'
        true
    end
    def reset
        @folded = false
        @hand = Hand.new(@name)
    end

    #player decisions
    def ante(amount)
        raise "YOU'RE BUST!" if bet_too_big?(amount)
        @pot -= amount
        amount
    end
    def bet
        puts "Enter bet amount:"
        bet = gets.chomp.to_i
        raise "NOT ENOUGH MONEY!" if bet_too_big?(bet)
        @pot -= bet
        @current_bet += bet
        bet
    end
    def fold
        @folded = true
    end
    def call(table_bet)
        call_amount = table_bet - @current_bet 
        if bet_too_big?(table_bet)
            call = @pot
            @pot = 0
            return call
        end
        @pot -= call_amount
        @current_bet += call_amount
        call_amount
    end
    def raise_bet(table_bet)
        #error handling for if raise is <= 0
        puts "Enter raise amount:"
        raise_amt = gets.chomp.to_i
        diff = table_bet - @current_bet
        @pot -= (raise_amt + diff)
        @current_bet += raise_amt + diff
        raise_amt
    end
    def all_in
        whole_pot = @pot
        @pot = 0
        whole_pot
    end
    def drop_out
        @bust = true
        @folded = true
    end
    #Error-Handling
    def bet_too_big?(amount)
        @pot - amount < 0
    end
end

if __FILE__ == $PROGRAM_NAME
    carter = Player.new('carter')
    carter.increase_pot(100)
    carter.call(99)
end