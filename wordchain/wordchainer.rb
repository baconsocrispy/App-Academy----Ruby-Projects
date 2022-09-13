require 'Set'

class WordChainer
    attr_reader :dictionary
    def initialize(dictionary_file)
        @dictionary = File.readlines(dictionary_file).map(&:chomp).to_set
    end
    def adjacent_words(word)
        adj_words = []
        @dictionary.each do |w|
            failed_matches = []
            if w.length == word.length 
                w.each_char.with_index do |c, i|
                    if c != word[i]
                        failed_matches << c
                    end
                end    
            end
            adj_words << w if failed_matches.length == 1
        end
        adj_words
    end
    def run(source, target)
        @current_words = [source]
        @all_seen_words = {source => nil}
        until @current_words.empty?
            self.explore_current_words
        end 
        self.build_path(target)
    end
    def explore_current_words
        new_current_words = []
        @current_words.each do |word|
            self.adjacent_words(word).each do |adj_word|
                if !@all_seen_words.include?(adj_word)   
                    new_current_words << adj_word
                    @all_seen_words[adj_word] = word
                end
            end
        end
        @current_words = new_current_words
    end
    def build_path(target)
        prev_word = @all_seen_words[target]
        path = [target]
        until prev_word == nil
            path << prev_word
            prev_word = @all_seen_words[prev_word]
        end
        puts path.reverse
    end
end

chain = WordChainer.new('dictionary.txt')

chain.run("duck", "ruby")