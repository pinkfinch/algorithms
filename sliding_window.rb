# Shortest Substring With 3 Unique Characters
# Given a string, return the shortest substring that has at least 3 unique characters, or false if there is no such string
#
# Input: String
# Output: String or Boolean
#
# Input: aabaca => Output: bac
# Input: abaacc => Output: baac
# Input: abc => Output: abc
# Input: aabb => Output: False
#
# N ~ Length of input string
# K ~ Number of unique characters in input string
#
# Time Complexity: O(N)
# Auxiliary Space Complexity: O(K)
#
# h = Hash.new
# a = 4
# b= 1
# c=1
#
# output_string = "ab"
#               a   a   b   a  a   c   a
#                       p1
#                                      p2
#               a   a  b  b
#

def shortest_substring(str)
  p1 = 0
  p2 = 0
  h = {}
  output_indices = nil
  while p2 < str.length
    if h[str[p2]]
      h[str[p2]] += 1
    else
      h[str[p2]] = 1
    end
    p2 += 1
    if h.length == 3

      while h[str[p1]] > 1
        p1 += 1
        h[str[p1]] -= 1
      end
      if !output_indices || output_indices[2] > p2-p1
        output_indices = [p1, p2-1, p2-p1]
      end
    end
  end
  return false if !output_indices
  str[output_indices[0]..output_indices[1]]
end


pp shortest_substring 'aabaaca'
pp shortest_substring 'aabaca'
pp shortest_substring 'aabb'
pp shortest_substring 'abc'

#
# Input: abcabcbb =>	Output: abc
# Input: bbbbb	 	=>	Output: b
# Input: pwwkew		=>	Output: wke
#
# Time constraint: O(N)
# Space constraint: O(k)
# N ~ Length of input string
# K ~ Number of unique characters in input string
#
# Another info:
# s consists of English letters, digits, symbols and spaces.
#
#
# a [3]
# b [4]
# c [5]
#
# output_String = abcd
#
#             a   b  c  a  b  c  d  b
#                       p1
#                                  p2
# initialize p1, p2 to 0
# create hash with indexes
#
# add elements with index to Hash
# when I find duplicate, move p1 to p2
# check if p2 - p1 +1 > length of output string and if so update output String
#
#

def longest_unique_substring(input)
  p1 = 0
  p2 = 0
  h = {}
  output_string = ''
  while p1 < input.length && p2 < input.length
    p1 = p2 if h[input[p2]]
    h[input[p2]] = p2
    current_max = p2 - p1 + 1
    output_string = input[p1..p2] if output_string.length < current_max
    p2 += 1
  end
  output_string
end

pp longest_unique_substring 'abcabcbb'
pp longest_unique_substring 'bbbbb'
pp longest_unique_substring 'pwwkew'
