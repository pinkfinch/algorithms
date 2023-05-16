# Given unsorted array of integers, return sorted array using heapsort. Must be performed in place without extra space.
# bubbledown = swap parent, children to maintain heap conditions
# getchild = calculate and return relevant child index based on given parent index in array based heap
# bubbleup = swap children w/parents to maintain heap
# child1 = 2*parent + 1
# child2 = 2* parent +2
# parent = floor((child-1)/2)

def heapsort(arr)
  # Write your code here
  for i in (0...arr.length)
    bubble_down(arr, arr.length - i - 1, arr.length)
  end
  for i in (0...arr.length)
    wall = arr.length - 1 - i
    arr[wall], arr[0] = arr[0], arr[wall]
    bubble_down(arr, 0, wall)
  end
  arr
end

def bubble_down(arr, parent_index, length)
  child_idx = get_child_index(arr, parent_index, length)
  while child_idx < length && arr[child_idx] > arr[parent_index]
    arr[child_idx], arr[parent_index] = arr[parent_index], arr[child_idx]
    parent_index = child_idx
    child_idx = get_child_index(arr, parent_index, length)
  end
end

def get_child_index(arr, index, length)
  child_1 = 2 * index + 1
  child_2 = 2 * index + 2
  if child_1 >= length
    return child_1
  elsif child_2 >= length
    return child_1
  elsif arr[child_1] > arr[child_2]
    return child_1
  else
    return child_2
  end
end

# Given n ropes of different lengths represented by an array of integers, connect them all into a single rope in a way
# that minimizes the cost of connecting them.

# The cost of connecting two ropes is equal to sum of their lengths

# In: [4, 3, 2, 6]
# Out: 29

# Explanation:

# First we connect 3 + 2 = 5, giving the following ropes: [4,5,6]
# Then we connect 5 + 4 = 9, giving the following ropes: [9,6]
# Then we connect 9 + 6 = 15, giving the final combination of all ropes: [15]

# So in total the cost for the most efficient approach is: 5 + 9 + 15 = 29

# A less efficient way would be:

# First we connect 4 + 6 = 10, giving the following ropes: [10,3,2]
# Then we connect 10 + 3 = 13, giving the following ropes: [13,2]
# Then we connect 13 + 2 = 15, giving the final combination of all ropes: [15]

# So in total the cost for the less efficient approach is: 10 + 13 + 15 = 38

# Although in both cases we need to make the same number of connections, the costs are different
#
# Time - O(NlogN)
# Space - O(1) or O(N)

#       4  2  3  6

# are we using min heap so picking 2 smallest elements -

# min - heap
# find minimum 2 elements - so create a min heap class
# heapify
#   - sortify
#   - pop top element twice
#   - add them - and add the sum to final cost
#   - push sum into heap
#   - keep repeating

# Given a positive integer n, return the nth Power Number.

# A Power Number is a positive integer i that can be written as two positive integers x and y where i = x^y and x > 1 and y > 1.

# So for example:

# The number 4 is a power number, because 4 == 2^2. The number 25 is a power number, because 25 == 5^2. The number 8 is a
#  power number, because 8 == 2^3. The number 7 is NOT a power number, because it can't be written as some number squared, cubed, etc.

# Your goal is to return the nth power number. Meaning, if you were to sort all power numbers in ascending order, there
# would be a first, second, third... nth.
# end
# Here is a list of the first 10 power numbers: [4, 8, 9, 16, 25, 27, 32, 36, 49, 64]

# In: 1
# Out: 4

# In: 10
# Out: 64
#
#
# Given an array of sorted arrays of numbers, return the result of merging all those sorted arrays into a single sorted array

# Input:
# [
# [1, 10, 11, 15],
# [2, 4,  9,  14],
# [5, 6,  8,  16],
# [3, 7,  12, 13]
# ]

# [
# [1, 2, 5]
# [3, 4, 6]
# [10, 11, 12]
# ]

# Output: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
#
# Time complexity = O(NK)
# Space complexity = O(NK)
# heap.push elements by index - so first elements
# pop the elements one by one O(N*klogN*K)
# arrs[i][0].each {
# push elements to Array
# do a heapsort
#   pop the elements one by one and push to new array

#

class Heap
  attr_accessor :storage, :type

  #heap_types = %i[min max].freeze

  def initialize(type = "min")
    @storage = []
    @type = type == "min" ? "min" : "max"
  end

  # Time Complexity: O(1)
  # Auxiliary Space Complexity: O(1)
  def compare(a, b)
    #YOUR WORK HERE
    return @storage[a] < @storage[b] if @type == "min"
    return @storage[a] > @storage[b] if @type == "max"
  end

  # Time Complexity: O(1)
  # Auxiliary Space Complexity: O(1)
  def swap(index1, index2)
    @storage[index1], @storage[index2] = @storage[index2], @storage[index1]
  end

  # Time Complexity: O(1)
  # Auxiliary Space Complexity: O(1)
  def peak()
    return @storage[0]
  end

  # Time Complexity: O(1)
  # Auxiliary Space Complexity: O(1)
  def size()
    return @storage.length
  end

  # Time Complexity: O(logN)
  # Auxiliary Space Complexity:O(1)
  def insert(value)
    @storage << value
    bubble_up @storage.length - 1
  end

  # Time Complexity: O(logN)
  # Auxiliary Space Complexity: O(1)
  def bubble_up(index)
    return if index >= @storage.length
    child = index
    parent = get_parent child
    while parent && parent >= 0
      if !compare parent, child
        swap(parent, child)
        child = parent
        parent = get_parent child
      else
        break
      end
    end
  end

  def get_parent(index)
    return nil if index <= 0
    return (index - 2) / 2 if index.even?
    return (index - 1) / 2
    pp index
  end

  def get_child(index)
    child1 = index * 2 + 1
    child2 = index * 2 + 2
    if child1 >= size
      return nil
    elsif child2 >= size
      return child1
    else
      return compare(child1, child2) ? child1 : child2
    end
  end
  # Time Complexity: O(logN)
  # Auxiliary Space Complexity: O(1)
  def remove_peak()
    return nil if !@storage || @storage.length == 0
    swap(0, @storage.length - 1)
    result = @storage.pop
    bubble_down(0)
    result
  end

  # Time Complexity: O(logN)
  # Auxiliary Space Complexity: O(1)
  def bubble_down(index)
    return if index >= @storage.length || index < 0
    parent = index
    while parent && parent < @storage.length
      child = get_child parent
      if child && !compare(parent, child)
        swap parent, child
        parent = child
      else
        break
      end
    end
  end

  # Time Complexity:
  # Auxiliary Space Complexity:
  def remove(value)
    index = -1
    (0..@storage.length).each do |i|
      if @storage[i] == value
        index = i
        break
      end
    end
    return if index == -1

    swap(index, @storage.length - 1)
    value = @storage.pop
    bubble_up(index)
    bubble_down(index)
    value
  end
end

def merge_sorted_arrays(matrix)
  return matrix if !matrix || matrix.length == 0 || matrix[0].length == 0
  h = Heap.new "min"
  initial_arr = []
  matrix.each { |arr| arr.each { |el| h.insert el } }

  sorted_arr = []

  while h.size > 1
    size = h.size

    last_el = h.remove_peak
    sorted_arr << last_el
  end
  sorted_arr << h.peak
  sorted_arr
end

pp merge_sorted_arrays [
                         [1, 10, 11, 15],
                         [2, 4, 9, 14],
                         [5, 6, 8, 16],
                         [3, 7, 12, 13]
                       ]

# ------------------------------------------------------------

# The median is the middle value in an ordered integer list. If the size of the list is even,
# there is no middle value and the median is the mean of the two middle values.

# Example: arr = [2, 3, 4], the median is 3.
# Example: arr = [1, -2, 3], the median is 1.
# Example: arr = [1, 8, 7, 4, 3, 10], the median is 5.5.

# space and time constraints:
# time - O(logN)
# space - O(n)

# create a min heap -
# insert - O(logN)
# pop elements till I get to n/2 for odd number
# pop elements till I get to n/2 - 1 and n/2 for even
# median = (n/2 - 1 + n/2) elements divided by 2 for even length
# median is n/2th element for odd

#  create min Heap
#   ->  [1, 8, 7, 4, 3, 10]    [1, 3, 4, 7, 8, 10] 5.5
#     min heap    [1  3, 7, 8, 4, 10]
#   1              10, 3, 7, 8, 4
#                   3, 10, 7, 8, 4
#                   3, 4, 7, 8, 10

# 3               10, 4, 7, 8
#                 4, 10, 7, 8
#                 4, 7, 8, 10

#     max heap    [10, 4, 8, 1, 3, 7]
# 10              7, 4, 8, 1, 3
#                 8, 4, 7, 1, 3

# 8               3, 4, 7, 1
#                 7, 4, 3, 1

#

def find_median(arr)
  min_h = Heap.new "min"
  max_h = Heap.new "max"
  arr.each do |el|
    min_h.insert el
    max_h.insert el
  end
  length = arr.length
  i = 0
  median = 0
  while i <= length / 2
    if i == (length / 2) && length.even?
      median += min_h.remove_peak
      median += max_h.remove_peak
      median = median / 2.0
      break
    elsif i == length / 2
      median = min_h.remove_peak
      break
    else
      min_h.remove_peak
      max_h.remove_peak
    end
    i += 1
  end
  median
end

pp find_median [2, 3, 4]
pp find_median [1, 3, 4, 7, 8, 10]
