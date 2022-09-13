class MyQueue
    def initialize
        @store = []
    end
    def enqueue(el)
        @store.push(el)
    end
    def dequeue
        @store.shift
    end
    def empty?
        @store.empty?
    end
    def peek
        @store[0]
    end
end

class MyStack
    def initialize
        @store = []
    end
    def push(el)
        @store.push(el)
    end
    def pop
        @store.pop
    end
    def peek
        @store[-1]
    end
    def size
        @store.length
    end
    def empty?
        @store.empty?
    end
end

class StackQueue
    def initialize
        @queue = MyQueue.new
    end
    def enqueue(el)
        @queue.enqueue(el)
    end
    def dequeue
        
    end
end