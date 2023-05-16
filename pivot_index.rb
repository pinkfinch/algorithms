#https://leetcode.com/problems/find-pivot-index/?envType=study-plan&id=level-1
def pivot_index(nums)
  return if !nums || nums.length == 0

  left_sum = 0
  right_sum = nums[1..nums.length-1].reduce(:+)
  nums.each_with_index {|num, idx|
      if idx == 0
        return 0 if left_sum == right_sum
        next
      end
      left_sum += nums[idx-1]
      right_sum -= num
      pp left_sum, right_sum
      return idx if left_sum == right_sum
  }
  -1
end

pp pivot_index [1,7,3,6,5,6]
