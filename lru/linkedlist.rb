require 'byebug'
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{self.key}: #{self.val}"
  end

  def remove
    self.prev.next = self.next if self.prev
    self.next.prev = self.prev if self.next
    self.next = nil
    self.prev = nil
    self
  end

end

class LinkedList
    attr_reader :head, :tail
    include Enumerable
    def initialize
        @head = Node.new
        @tail = Node.new
        @head.next = @tail
        @tail.prev = @head
    end
    def empty?
        @head.next == @tail && @tail.prev == @head
    end
    def first
        head.next unless empty?
    end
    def append(key, val)
        node = Node.new(key, val)
        node.next = tail
        node.prev = tail.prev
        tail.prev.next = node
        tail.prev = node
    end
    def update(key, val)
        node(key).val = val if node(key) != tail
    end
    def get(key)
        node(key).val if node(key) != tail
    end
    def include?(key)
        node(key).key == key
    end 
    def remove(key)
        node(key).next.prev = node(key).prev
        node(key).prev.next = node(key).next
    end
    def each
        node = self.head.next
        until node == self.tail
            yield node
            node = node.next
        end
    end
    # def to_s
    #     list = self.each { |node| node.to_s }
    # end
    private
    def node(key) 
        node = @head.next
        node = node.next until search_over(node, key)
        node
    end
    def search_over(node, key)
        node.key == key || node == tail
    end
end

list = LinkedList.new

list.append("C", 37)
list.append("D", 25)
list.append("E", [1,2,3])


p list.map { |node| print node.val }

