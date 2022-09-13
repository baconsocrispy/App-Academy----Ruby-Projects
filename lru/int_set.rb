class IntSet
    attr_reader :store
    def initialize(size)
        @store = Array.new(size) { Array.new }
    end
    def insert(int)
        i = int % store.length
        store[i] << int
    end
    def remove(int)
        i = int % store.length
        store[i].delete(int)
    end
    def include?(int)
        i = int % store.length
        store[i].include?(int)
    end
    def [](i)
        store[i]
    end
    private
end

set = IntSet.new(1)

set.insert(30)
set.insert(-20)
set.insert(4)
set.insert(13)
set.insert(1032)

set.remove(4)

p set.include?(-20)
p set