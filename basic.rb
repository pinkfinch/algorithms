require 'set'
#indices of two numbers whose sum is a specific target from an array
#[3,5,8,1,7,9,34,66,18] target = 17

# for i in 0 - len for j in i - len sum, and if target, return
#find difference, save in hash -> h[diff]=index another loop, find diff for each element and see if in hash
def sum_numbers(arr, target)
  diff = Hash.new
  arr.each_with_index do |el, idx|
    difference = target - el
    return idx, diff[difference] if diff[difference]
    diff[difference] = idx if difference >= 0
  end
  nil
end

#https://leetcode.com/problems/container-with-most-water/
#container with most water - can there be something that stops it?
# the biggest container will be the one with the tallest height on left and tallest height from right - ?
#test cases
#height = max
#brute force - for  i in (0...height, for j in i... height) area is (j-i)* min[height[i], height[j]]

def trap(elevations)
  return 0 if elevations.nil? || elevations.length == 0
  water = 0
  elevations.each_with_index do |height, idx|
    maxL = idx > 0 ? elevations[0, idx].max : 0
    maxR =
      (
        if idx < elevations.length - 1
          elevations[idx + 1, elevations.length].max
        else
          0
        end
      )
    min = [maxL, maxR].min
    water += min - height if min > height
  end
  water
end

def trap2(elevations)
  return 0 if elevations.nil? || elevations.length == 0
  water = 0
  #find left max, right max, and difference for each el
  length = elevations.length
  left_max = Array.new(length)
  right_max = Array.new(length)
  left_max[0] = elevations[0]
  right_max[length - 1] = elevations[length - 1]

  (1..length - 1).each do |i|
    j = length - i - 1
    left_max[i] = [left_max[i - 1], elevations[i]].max
    right_max[j] = [right_max[j + 1], elevations[j]].max
  end

  elevations.each_with_index do |height, i|
    min_height = [left_max[i], right_max[i]].min
    water += min_height - height if min_height - height > 0
  end
  water
end

puts trap [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]

puts trap [4, 2, 0, 3, 2, 5]

puts trap [4, 2, 3]

puts trap2 [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]

puts trap2 [4, 2, 0, 3, 2, 5]

puts trap2 [4, 2, 3]

#https://leetcode.com/problems/backspace-string-compare/

def backspace_compare(s, t)
  a = get_final_string s
  b = get_final_string t
  return a == b
end

def get_final_string(s)
  arr = Array.new(s.length)
  (0...s.length).each do |i|
    if s[i] == "#" && arr.length > 0
      arr.pop
    else
      arr.push(s[i])
    end
  end
  arr.compact.to_s
end

def backspace_compare2(s, t)
  i = s.length - 1
  j = t.length - 1
  while i >= 0 || j >= 0
    hash_ct1, hash_ct2 = 0, 0
    if s[i] == "#" || t[j] == "#"
      if i >= 0 && s[i] == "#"
        hash_ct1 = 2
        while hash_ct1 > 0
          hash_ct1 -= 1
          i -= 1
          hash_ct1 += 2 if s[i] == "#"
        end
      end
      if j >= 0 && t[j] == "#"
        hash_ct2 = 2
        while hash_ct2 > 0
          hash_ct2 -= 1
          j -= 1
          hash_ct2 += 2 if t[j] == "#"
        end
      end
    elsif i >= 0 && j >= 0 && s[i] != t[j]
      return false
    elsif (i < 0 && j >= 0) || (j < 0 && i >= 0)
      return false
    else
      i -= 1
      j -= 1
    end
  end
  true
end

puts backspace_compare2 "ab#c", "ad#c"
puts backspace_compare2 "ab#c", "ad#c"
puts backspace_compare2 "y#fo##f", "y#f#o##f"
puts backspace_compare2 "aaa###a", "aaaa###a"
puts backspace_compare2 "bxj##tw", "bxj###tw"

#https://leetcode.com/problems/longest-substring-without-repeating-characters/

def length_of_longest_substring(s)
  h = Hash.new
  length = 0
  prev_idx = 0
  current_len = 0
  (0...s.length).each do |i|
    if h[s[i]]
      prev_idx = h[s[i]]
      current_len = i - prev_idx
    else
      current_len += 1
    end
    length = [current_len, length].max
    h[s[i]] = i
  end
  length
end

puts length_of_longest_substring "abcabcbb"
puts length_of_longest_substring "pwwkew"
puts length_of_longest_substring "au"
puts length_of_longest_substring "abba"

def getMaxKnowledge(d, s, e, a, k)
  # Write your code here
  adj_list = {}
  overall_max = 0
  (0...s.length).each do |i|
    for j in (s[i]..e[i])
      adj_list[j] ? adj_list[j] << a[i] : adj_list[j] = [a[i]]
      next if adj_list[j].length <= k
      min = adj_list[j].min
      adj_list[j].delete min
    end
  end

  adj_list.each do |key, values|
    sum = values.sum
    overall_max = [sum, overall_max].max
  end
  overall_max
end

pp getMaxKnowledge 10, [2, 5, 4, 3], [8, 9, 7, 5], [800, 1600, 200, 400], 2

# Given a string s, return the longest palindromic substring in s.
# Example 1:
# Input: s = "babad"
# Output: "bab"
# Explanation: "aba" is also a valid answer.

# Example 2:
# Input: s = "cbbd"
# Output: "bb"
# https://leetcode.com/problems/longest-palindromic-substring/

def longest_palindrome(s)
  return 0 if !s || s.length == 0
  start, finish = 0, s.length - 1
  longest_string = s[0]
  while start < finish && start < s.length
    str = s[start..finish]
    if str == str.reverse && str.length > longest_string.length
      longest_string = str
    end
    break if longest_string.length >= s[start..-1].length
    if finish == start + 1
      start = finish
      finish = s.length - 1
    else
      finish = finish - 1
    end
  end

  longest_string
end

def longest_palindrome2(s)
  return "" if !s || s.length == 0
  start, finish = 0, 0

  (0...s.length).each do |i|
    len1 = expand_around_center(s, i, i)
    len2 = expand_around_center(s, i, i + 1)
    len = [len1, len2].max
    if len > (finish - start)
      start = i - (len - 1) / 2
      finish = i + len / 2
    end
  end
  return s[start..finish]
end

def expand_around_center(s, left, right)
  l, r = left, right
  while l >= 0 && r < s.length && s[l] == s[r]
    l -= 1
    r += 1
  end
  return r - l - 1
end

pp longest_palindrome2 "babad"
pp longest_palindrome2 "cbbd"

# https://leetcode.com/problems/spiral-matrix/
# Given an m x n matrix, return all elements of the matrix in spiral order.

# Example 1:
# Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
# Output: [1,2,3,6,9,8,7,4,5]

# Example 2:
# Input: matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
# Output: [1,2,3,4,8,12,11,10,9,5,6,7]
#
def spiral_order(matrix)
  return [] if !matrix || matrix.length == 0 || matrix[0].length == 0
  row_ct = matrix.length - 1
  col_ct = matrix[0].length - 1
  output = []
  left, right = 0, col_ct
  top, bottom = 0, row_ct

  total_ct = matrix.length * matrix[0].length
  while left <= right && top <= bottom
    pp "#{left} #{right} #{top} #{bottom}"
    (left..right).each { |col| output << matrix[top][col] }
    top += 1
    break if output.length == total_ct
    (top..bottom).each { |row| output << matrix[row][right] }
    right -= 1
    break if output.length == total_ct
    right.downto(left) { |col| output << matrix[bottom][col] }
    bottom -= 1
    break if output.length == total_ct
    bottom.downto(top) { |row| output << matrix[row][left] }
    left += 1
  end
  output
end

pp spiral_order [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]

# https://leetcode.com/problems/merge-intervals/
# Given an array of intervals where intervals[i] = [starti, endi], merge all overlapping intervals, and return an array
# of the non-overlapping intervals that cover all the intervals in the input.

# Example 1:
# Input: intervals = [[1,3],[2,6],[8,10],[15,18]]
# Output: [[1,6],[8,10],[15,18]]
# Explanation: Since intervals [1,3] and [2,6] overlap, merge them into [1,6].

# Example 2:
# Input: intervals = [[1,4],[4,5]]
# Output: [[1,5]]
# Explanation: Intervals [1,4] and [4,5] are considered overlapping.

class Interval
  include Comparable
  attr_accessor :value

  def <=>(other)
    @value[0] <=> other.value[0]
  end
  def initialize(value)
    @value = value
  end
end

def find_interval(value1, value2)
  start = [value1[0], value2[0]].min
  finish = [value1[1], value2[1]].max
  return start, finish
end

def merge(intervals)
  return [] if !intervals || intervals.length == 0
  output = []
  i = 0

  interval_arr = Array.new
  (0...intervals.length).each do |i|
    interval = Interval.new(intervals[i])
    interval_arr << interval
  end
  interval_arr.sort!
  pp interval_arr

  while i < interval_arr.length
    current = interval_arr[i].value
    next_val = i < interval_arr.length - 1 ? interval_arr[i + 1].value : nil
    if output.length > 0
      last_el = output[-1]
      if last_el[1] >= current[0]
        output.pop
        new_el = find_interval last_el, current
        output << new_el
      else
        output << current
      end
      i += 1
    elsif next_val && current[1] >= next_val[0]
      output << find_interval(current, next_val)
      i += 2
    else
      output << current
      i += 1
    end
  end
  output
end

# pp merge [[1, 3], [2, 6], [8, 10], [15, 18]]
# pp merge [[1, 4], [4, 5]]
pp merge [[2, 3], [4, 5], [6, 7], [8, 9], [1, 10]]

# https://leetcode.com/problems/word-search/
# Given an m x n grid of characters board and a string word, return true if word exists in the grid.

# The word can be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or
# vertically neighboring. The same letter cell may not be used more than once.

# Example 1:
# Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
# Output: true

# Example 2:
# Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "SEE"
# Output: true

# Example 3:
# Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCB"
# Output: false
#
def exist(board, word)
  return false if !board || !word || board.length == 0 || board[0].length == 0
  directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
  starting_index = []
  board.each_with_index {|row,i|
    row.each_with_index {|el, j|
      if el == word[0]
        starting_index <<[i,j]
      end
    }
  }
  resp = false
  traverse =-> (current, pos) {
    return if !check_bounds current[0], current[1], board
    if board[current[0]][current[1]] == word[pos]
      if pos == word.length - 1
        resp = true
        return
      end
      board[current[0]][current[1]] = '#'
      directions.each {|dir|
        traverse.call([current[0]+dir[0],current[1]+dir[1]], pos+1)
      }
      board[current[0]][current[1]]= word[pos]
    end
  }
  starting_index.each { |pos|
   traverse.call(pos, 0)
   return true if resp
  }
  false
end

def check_bounds(x, y, board)
  return false if x < 0 || x >= board.length || y < 0 || y >= board[0].length
  true
end

pp exist [["A","B","C","E"],["P","F","C","S"],["A","D","E","E"]], "SEE"
pp exist [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "ABCCED"
pp exist [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "ABCB"
