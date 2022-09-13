require_relative 'card'

class StateCard < Card
    attr_reader :state_name, :electoral_votes, :population, :base_color
    def initialize(state_name, electoral_votes, population, base_color, )
        super
        @state_name = state_name
        @electoral_votes = electoral_votes
        @population = population
        @base_color = base_color
    end
end