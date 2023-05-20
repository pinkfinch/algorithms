# https://leetcode.com/problems/minimum-rounds-to-complete-all-tasks/

# 2244. Minimum Rounds to Complete All Tasks
# You are given a 0-indexed integer array tasks, where tasks[i] represents the difficulty level of a task. In each round,
# you can complete either 2 or 3 tasks of the same difficulty level.

# Return the minimum rounds required to complete all the tasks, or -1 if it is not possible to complete all the tasks.

# Example 1:

# Input: tasks = [2,2,3,3,2,4,4,4,4,4]
# Output: 4
# Explanation: To complete all the tasks, a possible plan is:
# - In the first round, you complete 3 tasks of difficulty level 2.
# - In the second round, you complete 2 tasks of difficulty level 3.
# - In the third round, you complete 3 tasks of difficulty level 4.
# - In the fourth round, you complete 2 tasks of difficulty level 4.
# It can be shown that all the tasks cannot be completed in fewer than 4 rounds, so the answer is 4.
# Example 2:

# Input: tasks = [2,3,3]
# Output: -1
# Explanation: There is only 1 task of difficulty level 2, but in each round, you can only complete either 2 or 3 tasks of
#  the same difficulty level. Hence, you cannot complete all the tasks, and the answer is -1.
require_relative "heap"
def minimum_rounds(tasks)
  hash = {}
  tasks.each { |task|
    hash[task] ? hash[task] += 1 : hash[task] = 1
  }
  rounds = 0
  hash.keys.each {|key|
    value = hash[key]
    return -1 if value == 1
    if value == 2
      rounds += 1
    else
      rounds += value/3
      reminder = value % 3
      rounds += 1 if reminder != 0
    end
  }
  rounds
end

pp minimum_rounds [2,2,3,3,2,4,4,4,4,4]

# https://leetcode.com/problems/minimize-deviation-in-array/
# 1675. Minimize Deviation in Array

# You are given an array nums of n positive integers.

# You can perform two types of operations on any element of the array any number of times:

# If the element is even, divide it by 2.
# For example, if the array is [1,2,3,4], then you can do this operation on the last element, and the array will be [1,2,3,2].
# If the element is odd, multiply it by 2.
# For example, if the array is [1,2,3,4], then you can do this operation on the first element, and the array will be [2,2,3,4].
# The deviation of the array is the maximum difference between any two elements in the array.

# Return the minimum deviation the array can have after performing some number of operations.


# Example 1:

# Input: nums = [1,2,3,4]
# Output: 1
# Explanation: You can transform the array to [1,2,3,2], then to [2,2,3,2], then the deviation will be 3 - 2 = 1.
# Example 2:

# Input: nums = [4,1,5,20,3]
# Output: 3
# Explanation: You can transform the array after two operations to [4,2,5,5,3], then the deviation will be 5 - 2 = 3.
# Example 3:

# Input: nums = [2,10,8]
# Output: 3

def minimum_deviation(nums)
  min_val = nums[0]
  heap = MaxHeap.new
  nums.each { |num|
    num = num * 2 if num.odd?
    min_val = [num, min_val].min
    heap.insert(num)
  }
  pp heap

  current = heap.pop
  while(current.even?)
    current = current/2
    heap.push(current)
    current = heap.pop
  end

  heap.pop - min_val

end

# pp minimum_deviation [1,2,3,4]
# pp minimum_deviation [4,1,5,20,3]
pp minimum_deviation [2,10,8]
pp minimum_deviation [5,1,2,8]
