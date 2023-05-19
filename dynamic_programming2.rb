# https://leetcode.com/problems/flip-string-to-monotone-increasing/
# 926. Flip String to Monotone Increasing
# A binary string is monotone increasing if it consists of some number of 0's (possibly none), followed by some number of 1's (also possibly none).
# You are given a binary string s. You can flip s[i] changing it from 0 to 1 or from 1 to 0.
# Return the minimum number of flips to make s monotone increasing.


# Example 1:
# Input: s = "00110"
# Output: 1
# Explanation: We flip the last digit to get 00111.

# Example 2:
# Input: s = "010110"
# Output: 2
# Explanation: We flip to get 011111, or alternatively 000111

# Example 3:
# Input: s = "00011000"
# Output: 2
# Explanation: We flip to get 00000000.


# 0  1  0 1 1 0

# 0  0  0  1  1  0  0  0
# 0  0  0  1  1  0  0  0
# get total number of zeros


def min_flips_mono_incr(s)
  zero_ct = 0
  s.each_char { |ch|
      zero_ct += 1 if ch == '0'
  }
  ans = zero_ct
  s.each_char {|ch|
    if ch == '0'
      zero_ct -= 1
      ans = [zero_ct, ans].min
    else
      zero_ct += 1
    end
  }
  ans

end

pp min_flips_mono_incr "00110"
pp min_flips_mono_incr "010110"
pp min_flips_mono_incr "00011000"



