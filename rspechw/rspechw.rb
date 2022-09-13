class Array
    def my_uniq
        new_array = []
        self.each { |el| new_array << el if !new_array.include?(el) }
        new_array
    end
end

arr = [1, 1, 3, 5, 7, 7, "a", "a", "b"]

p arr.my_uniq
