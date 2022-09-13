class LRUCache
    attr_reader :cache, :size
    def initialize(size)
        @size = size
        @cache = Array.new(size)
    end
    def count
        cache.count
    end
    def add(el)
        cache.include?(el) ? move_element_to_front(el) : add_and_remove(el)
    end
    def show
        print cache
    end

    private
    def cache_full?
        count == size
    end
    def remove_LRU
        cache.shift if cache_full?
    end
    def add_and_remove(el)
        remove_LRU
        cache.push(el)
    end
    def include?(el)
        cache.include?(el)
    end
    def move_element_to_front(el)
        cache.delete_at(get_index(el))
        cache.push(el)
    end
    def get_index(el)
        cache.index(el)
    end
end


  johnny_cache = LRUCache.new(4)

  johnny_cache.add("I walk the line")
  johnny_cache.add(5)

  johnny_cache.count # => returns 2

  johnny_cache.add([1,2,3])
  johnny_cache.add(5)
  johnny_cache.add(-5)
  johnny_cache.add({a: 1, b: 2, c: 3})
  johnny_cache.add([1,2,3,4])
  johnny_cache.add("I walk the line")
  johnny_cache.add(:ring_of_fire)
  johnny_cache.add("I walk the line")
  johnny_cache.add({a: 1, b: 2, c: 3})


  johnny_cache.show # => prints [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]