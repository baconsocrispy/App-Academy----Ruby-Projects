class MaxIntSet
    attr_reader :store, :max
    def initialize(max)
        @max = max
        @store = Array.new(max, false)
    end
    def insert(int)
        raise "Integer must be between 0 and #{max}!" if int < 0 || int > max
        store[int] = true
    end
    def remove(int)
        raise "Integer must be between 0 and #{max}!" if int < 0 || int > max
        store[int] = false
    end
    def include?(int)
        raise "Integer must be between 0 and #{max}!" if int < 0 || int > max
        store[int] == true
    end
    private
end 

set = MaxIntSet.new(10)

set.insert(9)
p set.include?(9)


