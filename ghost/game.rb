#_FILE_ == $PROGRAMFILE
require_relative "./lib/player.rb"

class Game
    attr_reader "dictionary"
    def initialize(*names)
        @fragment = ""
        @players = [*names].map { |name| Player.new(name) }
        @turn = 0
        @dictionary = {}
        @losses = Hash.new(0)
        @round = 1

        File.foreach("dictionary.txt") { |line| @dictionary[line.chomp] = nil }
        @players.map { |player| @losses[player] = 0 }
    end
    def run
        until @players.length == 1
            self.play_round
            @players.map do |player|
                if @losses[player] == 5
                    @players.delete(player)
                end
            end
            @fragment = ""
            @turn = 0
            self.display_standings
        end
        puts "#{@players[0].name} WON THE GAME"
    end
    def play_round
        puts "LET'S PLAY GHOST!!"
        puts "Round #{@round}"
        until @dictionary.keys.include?(@fragment)
            self.take_turn(current_player)
        end
        @round += 1
    end
    def current_player
        @players[@turn]
    end
    def previous_player
        @players[@turn - 1]
    end
    def next_player!
        if @turn == @players.length - 1
            @turn = 0
        else
            @turn += 1
        end
    end
    def record(player)
        if @losses[player] > 0
            print "GHOST"[0...@losses[player]]
        else
            print "No Losses"
        end
    end
    def take_turn(player)
        puts "#{player.name} CHOOSE A LETTER"
        player_entry = player.guess
        until self.valid_play?(player_entry)
            puts "INVALID ENTRY! TRY AGAIN!"
            player_entry = player.guess
        end
        @fragment += player_entry
        if self.round_over
            puts "#{current_player.name} LOST THE ROUND!"
            puts "Losing word: #{@fragment}"
            @losses[self.current_player] += 1
            return
        end
        puts "Word fragment is now: #{@fragment}"
        self.next_player!
    end
    def display_standings
        @players.map { |player| puts self.record(player).to_s + ": " + player.name.to_s }
    end
    def round_over
        return true if @dictionary.keys.include?(@fragment)
        false
    end
    def valid_play?(string)
        alphas = [ *("a".."z") ]
        return false if !alphas.include?(string)
        frag = @fragment + string
        @dictionary.keys.any? { |word| word[0...frag.length] == frag }
    end
end

game = Game.new("carter", "Rebecca")

game.run


