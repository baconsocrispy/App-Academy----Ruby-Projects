def range(start, finish)
    return [] if finish < start
    return [start] if start == finish
    range(start, finish - 1) + [finish] 
end

# p range(1,5)

def exp1(base, power)
    return 1 if power == 0
    base * exp1(base, power - 1)
end

# p exp1(5, 256)

def exp2(base, power)
    return 1 if power == 0
    return base if power == 1
    if power.even? 
        exp2(base, power / 2) ** 2
    else
        base * (exp2(base, (power - 1) / 2 ) ** 2 )
    end
end

# p exp2(5, 256)
class Array
    def deep_dup(duped = [])
        self.each do |el|
            if !el.is_a?(Array)
                duped << el
            else
                duped << el.dup
                el.deep_dup
            end
        end
        duped
    end
    def median
        self.sort
        mid = self.length / 2
        self[mid]
    end
    def subsets
        return [self] if self == []
        return [[], [self]] if self.length == 1
        
        
        self
    end
    
end
#     p [].subsets # => [[]]
#     p [1].subsets # => [[], [1]]
#     p [1, 2].subsets # => [[], [1], [2], [1, 2]]
#     p [1, 2, 3].subsets # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
# # p [1].median
# p [1,2,3,4,5].median

# arr = [1, [2], [3, [4]]]
# p arr.object_id
# p arr.deep_dup.object_id

def it_fib(n)
    fibs = []
    (1..n).each { |num| fibs << fibonacci(num) }
    fibs
end
def fibonacci(n)
    return 1 if n == 1
    return 1 if n == 2
    fibonacci(n - 1) + fibonacci(n - 2)
end

# p it_fib(3)
# p it_fib(4)
# p it_fib(5)
# p it_fib(6)
# p it_fib(7)

def bsearch(arr, target)
    median = arr.median
    median_index = arr.index(median)
    return arr.index(target) if target == median
    return nil if arr.empty?
    left = arr[0...median_index]
    right = arr[median_index + 1..-1]
    left_search = bsearch(left, target)
    right_search = bsearch(right, target)
    if median > target  
        left_search 
    elsif right_search != nil
        right_search + left.length + 1
    end
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

def merge_sort(array)
    return array if array.length == 1
    return [] if array.length == 0
    med = array.median
    left = merge_sort(array[0..med])
    right = merge_sort(array[med + 1..-1])
    
    merge_arrays(left, right)
end

def merge_arrays(arr1, arr2)
    merged = []
    arr1.each do |n1|
        arr2.each do |n2| 
            if n2 <= n1
                merged << n2
            end
        end
        merged << n1
    end
    merged
end

p [38,27,43,3,9,82,10].sort
p merge_sort([38,27,43,3,9,82,10])


