#require './lib/hand/hand.rb'
#require './lib/card/card.rb'
require './lib/deck/deck.rb'
require './lib/player/player.rb'

class Poker
    attr_reader :players, :deck, :pot
    def initialize(*names)
        @players = [*names].map { |name| Player.new(name) }
        @ante = 0
        @pot = 0
        @deck = Deck.new
        @current_bet = 0
        @open = true
    end

    def play
        game_setup
        game_play until game_over?
    end
    def game_play
        display_standings
        everyone_antes
        deal_cards
        betting_round
        discard_round 
        betting_round
        determine_winner
        game_reset
    end
    
    #BETTING LOGIC
    def betting_round
        return if one_player_left? 
        until !@open
            @open = false
            @players.each { |player| take_turn(player) if !player.folded }
        end
        reset_betting_round
    end
    def take_turn(player)
        player.display_hand
        choice = decision_prompt(player)
        decision_processing(player, choice)
    end
    def decision_processing(player, choice)
        case choice
        when 'b'
            player_bets(player)
        when 'r'
            player_raises(player)
        when 'c'
            player_calls(player)
        when 'f'
            player.fold
        when 'k'
            return
        when 'd'
            player.drop_out
        end
    end
    def player_bets(player)
        bet = player.bet
        @pot += bet
        @current_bet += bet
        @open = true
    end
    def player_raises
        diff = @current_bet - player.current_bet
        raise_amount = player.raise_bet(@current_bet)
        @current_bet += raise_amount
        @pot += (diff + raise_amount)
        @open = true
    end
    def player_calls(player)
        call = player.call(@current_bet)
        @pot += call
    end
    def reset_betting_round
        @current_bet = 0
        @players.each { |player| player.current_bet = 0 }
        @open = true
    end

    #GAME PLAY LOGIC
    def deal_cards
        @deck.deal_cards(@players)
    end
    def everyone_antes
        @players.each { |player| @pot += player.ante(@ante) }
    end
    def discard_round
        return if one_player_left?
        remaining_players.each do |player|
            num_cards = player.swap_prompt
            swap_player_cards(num_cards, player)
            system('clear')
            player.display_hand
        end
    end
    def swap_player_cards(num_cards, player)
        new_cards = []
        num_cards.times { |i| new_cards << @deck.cards.shift }
        player.swap_cards(new_cards)
    end

    #WINNING LOGIC
    def determine_winner
        one_player_left? ? winner_takes_pot : determine_best_hand
    end
    def determine_best_hand
        winner = Hand.winning_hand(self.remaining_hands)
        winner_takes_pot(winner)
        show_hands(self.remaining_hands)
    end
    def winner_takes_pot(winner = 'player')
        one_player_left? ? add_pot_win_by_fold : add_pot_win_by_best_hand(winner)
    end
    def one_player_left?
        @players.one? { |player| !player.folded }
    end
    def game_over?
        @players.one? { |player| !player.bust }
    end
    def add_pot_win_by_fold
        @players.each { |player| player.increase_pot(@pot) if !player.folded }
    end
    def add_pot_win_by_best_hand(winner)
        @players.each { |player| player.increase_pot(@pot) if player.name == winner }
    end

    #INTERFACE
    def show_hands(hands)
        hands.each do |hand|
            print "#{hand.player}: "
            hand.cards.each do |card|
                print "#{card.to_s}  "
            end
            puts
        end
        sleep(5)
    end
    def decision_prompt(player)
        prompt = 'What would you like to do: '
        if @current_bet == 0
            prompt += "enter 'b' to bet, 'k' to check, 'f' to fold, 'd' to drop out"
        elsif player.current_bet < @current_bet
            prompt += "enter 'c' to call, 'r' to raise, 'f' to fold 'd' to drop out"
        elsif player.current_bet == @current_bet
            prompt += "enter 'r' to raise, 'k' to check, 'f' to fold 'd' to drop out"
        end
        puts "POT: $#{@pot}"
        puts "TABLE BET: $#{@current_bet}"
        puts "YOUR BET: $#{player.current_bet}"
        puts prompt
        choice = gets.chomp
        #error handling so players can only select per above
    end
    
    #HELPERS
    def remaining_hands
        remaining_hands = []
        @players.each { |player| remaining_hands << player.hand if !player.folded }
        remaining_hands
    end
    def remaining_players
        @players.select { |player| !player.folded }
    end
    
    #GAME MANAGEMENT
    def game_setup
        welcome_message
        get_starting_pot
        get_blind
        display_standings
    end
    def game_reset
        @pot, @deck = 0, Deck.new
        @players.delete_if { |player| player.bust }
        @players.each { |player| player.reset }
        @players = @players.rotate
    end
    def welcome_message
        puts "LET'S PLAY POKER!"
        sleep(1)
    end
    def get_starting_pot
        system('clear')
        puts 'Enter a starting pot amount:'
        pot = gets.chomp.to_i
        @players.each { |player| player.increase_pot(pot) }
    end
    def get_blind
        system('clear')
        puts 'Enter a ante amount:'
        @ante = gets.chomp.to_i
    end
    def display_standings
        system('clear')
        puts 'Here are the standings:'
        @players.each { |player| puts "#{player.name}: $#{player.pot}" }
        sleep(1)
    end
end


if __FILE__ == $PROGRAM_NAME
    game = Poker.new('carter', 'rebecca')
    game.play
end