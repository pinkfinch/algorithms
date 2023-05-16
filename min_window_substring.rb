# Given a string, and a set of characters return the substring representing the smallest window containing those characters

# Example 1:

# Input: "ADOBECODEBANC", "ABC"
# Output: "BANC"

# Explanation:
# Though there are many substrings containing all the characters "BANC" is the shortest.

# Example 2:

# Input: "HELLO WORLD", "FOO"
# Output: ""

# Explanation:
# The target characters are not contained within the original string, so the output is empty.

# Notes:
# 1. No repeated characters
# 2.ignore capitalization

# Extra credit:
# How would you handle repeats - meaning if you were given two "A" characters, a valid window must contain two "A"s?


def minimumWindowSubstring(word, target)
  # Write your code here
  left, right = 0, 0
  counts = {}
  missing_chars = target.length
  result = [0, Float::INFINITY]
  target.each_char { |el|
      if counts[el]
          counts[el] += 1
      else
          counts[el] = 1
      end
  }

  while right < word.length
      if missing_chars > 0
          ch = word[right]
          if counts[ch]
              if counts[ch] > 0
                  missing_chars -= 1
              end
              counts[ch] -= 1
          end
      end
      right += 1
      while missing_chars == 0
          if (right-left) < result[1]-result[0]
              result = [left, right]
              pp result
          end
          ch = word[left]
          if counts[ch]
              counts[ch] += 1
              if counts[ch] > 0
                  missing_chars += 1
              end
          end
          left += 1
      end
  end
  #pp result[0], result[1]
  return "" if result[1] == Float::INFINITY
  word[result[0], result[1]-1]
end
