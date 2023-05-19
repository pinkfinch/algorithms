# https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/description/
# 167. Two Sum II - Input Array Is Sorted
# Given a 1-indexed array of integers numbers that is already sorted in non-decreasing order, find two numbers such that they
# add up to a specific target number. Let these two numbers be numbers[index1] and numbers[index2] where 1 <= index1 < index2 <= numbers.length.
# Return the indices of the two numbers, index1 and index2, added by one as an integer array [index1, index2] of length 2.
# The tests are generated such that there is exactly one solution. You may not use the same element twice.
# Your solution must use only constant extra space.

# Example 1:

# Input: numbers = [2,7,11,15], target = 9
# Output: [1,2]
# Explanation: The sum of 2 and 7 is 9. Therefore, index1 = 1, index2 = 2. We return [1, 2].
# Example 2:

# Input: numbers = [2,3,4], target = 6
# Output: [1,3]
# Explanation: The sum of 2 and 4 is 6. Therefore index1 = 1, index2 = 3. We return [1, 3].
# Example 3:

# Input: numbers = [-1,0], target = -1
# Output: [1,2]
# Explanation: The sum of -1 and 0 is -1. Therefore index1 = 1, index2 = 2. We return [1, 2].

# 2  7  10  12  17    target = 27
# # i             j

# if i+j < target move i+1
#   if i + j > target move j j -1

def two_sum(numbers, target)
  i, j = 0, numbers.length-1

  while (i < j)
    return [i+1, j+1] if numbers[i] + numbers[j] == target
    if numbers[i] + numbers[j] < target
      i += 1
    else
      j -= 1
    end
  end
  return []
end




# https://leetcode.com/problems/3sum/
# Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.
# Notice that the solution set must not contain duplicate triplets.



# Example 1:

# Input: nums = [-1,0,1,2,-1,-4]
# Output: [[-1,-1,2],[-1,0,1]]
# Explanation:
# nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
# nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
# nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
# The distinct triplets are [-1,0,1] and [-1,-1,2].
# Notice that the order of the output and the order of the triplets does not matter.
# Example 2:

# Input: nums = [0,1,1]
# Output: []
# Explanation: The only possible triplet does not sum up to 0.
# Example 3:

# Input: nums = [0,0,0]
# Output: [[0,0,0]]
# Explanation: The only possible triplet sums up to 0.


# -1   0   1   2  -1  -4
# i

#         j
#                      k


# def three_sum(nums)
#   return [] if nums.length < 3
#   output = []


#   hash = {}
#   (0...nums.length-2).each { |i|
#     (1...nums.length-1).each {|j|
#       (2...nums.length).each { |k|
#         next if i == j || i == k || j == k
#         if nums[i] + nums[j] + nums[k] == 0
#           sum = [nums[i], nums[j], nums[k]].sort!
#           next if output.index sum
#           output << sum
#         end
#       }
#     }
#   }
#   output
# end


def three_sum(nums)
  return [] if nums.length < 3
  output = []
  nums = nums.sort
  i = 0
  (0...nums.length-2).each { |i|
    sum_needed = -nums[i]
    j = i+1
    k = nums.length-1
    while(j < k)
      if nums[j] + nums[k] == sum_needed
        sorted = [nums[i], nums[j], nums[k]].sort
        output << sorted if !output.index sorted
        j += 1
        k -= 1
      elsif nums[j] + nums[k] < sum_needed
        j += 1
      else
        k -= 1
      end
    end
  }
  output
end
pp three_sum([-1,   0,   1 ,  2 , -1,  -4])
pp three_sum [-2,0,1,1,2]

# -4, -1, -1, 0, 1, 2
# -2,  0,  1,  1,  2
#  i      k        j

#
