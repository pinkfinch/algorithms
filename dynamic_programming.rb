#Given array of coins and target total, return how many unique ways there are to use coins to make up that total
# Example 1:
# Input: [1,2,3], 4
# Output: 4
# Possible Combinations:
# 1+1+1+1
# 1+3
# 1+1+2
# 2+2

# Example 2:
# Input: [2,5,3,6], 10
# Output: 5
# Possible Combinations:
# 2+3+5
# 5+5
# 2+3+2+3
# 2+2+6
# 2+2+2+2+2
#!/bin/ruby

require "json"
require "stringio"

#
# Complete the 'coinSum' function below.
#
# The function is expected to return an INTEGER.
# The function accepts following parameters:
#  1. INTEGER_ARRAY coins
#  2. INTEGER total
#

def coinSum(coins, total)
  # Write your code here
  cache = [0] * (total + 1)
  cache[0] = 1
  coins.each do |coin|
    (coin..total).each { |i| cache[i] = cache[i] + cache[i - coin] }
  end
  cache[total]
end

pp coinSum [1, 2, 3], 4
pp coinSum [1, 2, 4], 5

def fibonacci(n)
  cache = [0] * (n + 1)
  cache[0] = 1
  cache[1] = 1

  (2..n).each { |i| cache[i] = cache[i - 1] + cache[i - 2] }
  cache[n]
end

pp fibonacci 20

# https://leetcode.com/problems/climbing-stairs/
def climb_stairs(n)
  return 1 if n <= 1
  return 2 if n == 2
  return climb_stairs(n - 1) + climb_stairs(n - 2)
end

def climb_stairs(n)
  cache = [0] * (n + 1)
  cache[0] = 1
  cache[1] = 1
  cache[2] = 2

  (2..n).each { |i| cache[i] = cache[i - 1] + cache[i - 2] }
  cache[n]
end
pp climb_stairs 10
pp climb_stairs 2
pp climb_stairs 3

def minimumStepsToOne(num)
  # Write your code here
  return steps if num == 1
  steps_arr = []
  count_steps = ->(num, steps) do
    if num == 1
      steps_arr << steps
      return
    end
    count_steps.call(num / 3, steps + 1) if num % 3 == 0
    count_steps.call(num / 2, steps + 1) if num % 2 == 0
    count_steps.call(num - 1, steps + 1)
  end
  count_steps.call(num, 0)
  return steps_arr.min
end
# pp minimumStepsToOne 5
# pp minimumStepsToOne 11

def minimumStepsToOne(num)
  # Write your code here

  steps = [0] * (num + 1)
  steps[2] = 1
  steps[3] = 1
  steps[4] = 2
  return steps[num] if num <= 4
  (5..num).each do |n|
    min_steps = []
    min_steps << steps[n / 3] if n % 3 == 0
    min_steps << steps[n / 2] if n % 2 == 0
    min_steps << steps[n - 1]
    steps[n] = min_steps.min + 1
  end
  return steps[num]
end
pp minimumStepsToOne 5
pp minimumStepsToOne 11
