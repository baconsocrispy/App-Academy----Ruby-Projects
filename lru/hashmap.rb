require_relative 'linkedlist'

class HashMap
    attr_reader :store
    def initialize(size = 8)
        @store = Array.new(size) { LinkedList.new }
    end
    def set(key, val)
        @store[bucket(key)].update(key, val) if @store[bucket(key)].include?(key)
    end
    private
    def bucket(key)
        key % store.length
    end
end

hash = HashMap.new

hash.set()