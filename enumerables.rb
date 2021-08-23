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
        result = Array.new(self.length){Array.new(args.length + 1)}
        args.unshift(self)

    end


end
p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten
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