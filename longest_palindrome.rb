# https://leetcode.com/problems/longest-palindrome/?envType=study-plan&id=level-1
# Given a string s which consists of lowercase or uppercase letters, return the length of the longest palindrome
# that can be built with those letters.

# Letters are case sensitive, for example, "Aa" is not considered a palindrome here.
# Example 1:

# Input: s = "abccccdd"
# Output: 7
# Explanation: One longest palindrome that can be built is "dccaccd", whose length is 7.
# Example 2:

# Input: s = "a"
# Output: 1
# Explanation: The longest palindrome that can be built is "a", whose length is 1.

# Constraints:

# 1 <= s.length <= 2000
# s consists of lowercase and/or uppercase English letters only.

def longest_palindrome(s)
  h = Hash.new
  length = 0
  s.each_char { |t| h[t] ? h[t] += 1 : h[t] = 1 }
  found_odd = false
  h.each do |key, value|
    if value.even?
      length += value
    elsif value.odd? && !found_odd
      length += value
      found_odd = true
    elsif found_odd
      length += (value - 1)
    end
  end
  length
end

pp longest_palindrome "abccccdd"
