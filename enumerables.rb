require "byebug"

class Array

    def my_each(&prc)
        self.length.times do |i|
            prc.call(self[i])
        end

        self
    end

    def my_select(&prc)
        result = []
        self.my_each do |ele|
            result << ele if prc.call(ele) == true
        end
        result
    end

    def my_reject(&prc)
        result = []
        self.my_each do |ele|
            result << ele if prc.call(ele) == false
        end
        result
    end

    def my_any?(&prc)
        self.my_each do |ele|
            return true if prc.call(ele) == true
        end
        false
    end

    def my_all?(&prc)
        self.my_each do |ele|
            return false if prc.call(ele) == false
        end
        true
    end

    def my_flatten
    #    return [] if self.empty?
       flattened = []
          self.my_each do |ele|
            if ele.is_a?(Integer)
                flattened << ele
            else
                flattened += ele.my_flatten
            end
          end  
       flattened 
    end

    def my_zip(*args)
        result = Array.new(self.length) { [] }
        args.unshift(self)

        (0...self.length).to_a.my_each do |i|
            args.my_each do |arg|
                result[i] << arg[i]
            end
        end

        result
    end

    def my_rotate(n=1)
        rotations = n % self.length
        dup = self.dup

        rotations.times do
            dup.push(dup.shift)
        end

        dup
    end


end

a = [ "a", "b", "c", "d" ]
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten
# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

# # calls my_each twice on the array, printing all the numbers twice.
# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end
# # => 1
#      2
#      3
#      1
#      2
#      3

# p return_value  # => [1, 2, 3]