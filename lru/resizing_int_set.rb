class HashSet
    attr_accessor :store, :count
    def initialize
        @count = 0
        @store = Array.new(1) { Array.new }
    end
    def insert(n)
        hashed = n.hash
        store[bucket(hashed)] << hashed
        self.count += 1
        readjust_store if count >= store.length
    end
    def remove(n)
        hashed = n.hash
        store[bucket(hashed)].delete(hashed)
        count -= 1
    end
    def include?(n)
        hashed = n.hash
        store[bucket(hashed)].include?(hashed)
    end
    
    private
    def bucket(n)
        bucket = n % store.length
    end
    def readjust_store
        resize
        rebucket
    end
    def resize
        store.length.times { |i| store << [] }
    end
    def rebucket
        store.each do |b|
            b.each do |hash|
                b.delete(hash)
                store[bucket(hash)] << hash
            end
        end
        true
    end
end

set = HashSet.new
set.insert(35)
p set
set.insert(47)
p set
set.insert(10239)
set.insert(932432)
p set