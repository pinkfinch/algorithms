#Given a matrix of zeros determine how many unique paths there are from the top left corner to bottom right corner,

# Example 1:
#  Input:
#  [[ 0, 0, 0, 0],
#   [ 0, 0, 0, 0],
#   [ 0, 0, 0, 0]]

#  Output: 38

# Example 2:

#  Input:
#  [[ 0, 0, 0],
#   [ 0, 0, 0]]

#  Output: 4

# Example 3:
#  Input:
#  [[ 0, 0, 0, 0, 0, 0, 0, 0],
#   [ 0, 0, 0, 0, 0, 0, 0, 0],
#   [ 0, 0, 0, 0, 0, 0, 0, 0],
#   [ 0, 0, 0, 0, 0, 0, 0, 0],
#   [ 0, 0, 0, 0, 0, 0, 0, 0]]

#  Output: 7110272
def robotPaths(matrix)
  return 0 if !matrix || matrix.length == 0
  # Write your code here
  result = 0
  traverse = ->(row, col) do
    if row < 0 || col < 0 || row >= matrix.length || col >= matrix[0].length
      return
    end
    return if matrix[row][col] == 1
    if row == matrix.length - 1 && col == matrix[0].length - 1
      result += 1
      return
    end
    matrix[row][col] = 1
    traverse.call(row + 1, col)
    traverse.call(row, col + 1)
    traverse.call(row - 1, col)
    traverse.call(row, col - 1)
    matrix[row][col] = 0
  end
  traverse.call(0, 0)
  return result
end

def robotPaths(matrix)
  return 0 if !matrix || matrix.length == 0
  # Write your code here
  result = 0
  visited = Set.new
  traverse = ->(row, col) do
    key = row.to_s + "-" + col.to_s
    if row < 0 || col < 0 || row >= matrix.length || col >= matrix[0].length
      return
    end
    return if visited.include? key
    if row == matrix.length - 1 && col == matrix[0].length - 1
      result += 1
      return
    end

    visited << key
    traverse.call(row + 1, col)
    traverse.call(row, col + 1)
    traverse.call(row - 1, col)
    traverse.call(row, col - 1)
    visited.delete key
  end
  traverse.call(0, 0)
  return result
end

=begin
Write an efficient algorithm that searches for a value in an M x N matrix. This matrix has the following properties:

Integers in each row are sorted from left to right
The first integer of each row is greater than the last integer of the previous row.

Input: Matrix of Integers, Target Integer
Output: Boolean

matrix = [
  [1,   3,  5,  7],
  [10, 11, 16, 20],
  [23, 30, 34, 50]
]

target = 3

assume it is a long array - then bin search
so we need to find the coordinates given a particular index

left = 0
right = m*n
find middle element  =
if middle < target go right
  if middle > target go left

find the element given middle
      0   1  2  3
    0  1  3  5  7
    1  10 11 16 20
    2  23 30 34 50

    so if index = 6

    index = 10
    row = 10/3 = 3-1
    col = 10%4 = 2

    row = index/m - 1
    col = index%n?
=end

def find_element(arr, target)
  return if !arr || arr.length == 0 || arr[0].length == 0

  binary_search = ->(left, right) do
    return false if right < left
    if left == right && arr[left] == target
      return true
    elsif left == right
      return false
    end
    middle = (left + right) / 2
    indexes = find_arr_index arr, middle
    pp indexes
    return true if arr[indexes[0]][indexes[1]] == target
    if arr[indexes[0]][indexes[1]] > target
      binary_search.call(left, middle)
    else
      binary_search.call(middle + 1, right)
    end
  end

  return binary_search.call(0, arr.length * arr[0].length)
end

def find_arr_index(arr, index)
  pp index
  m = arr.length
  n = arr[0].length
  return nil if index < 0 || index > m * n
  row = (index / m) - 1 >= 0 ? (index / m) - 1 : 0
  col = index % n
  [row, col]
end

pp find_element [[1, 3, 5, 7], [10, 11, 16, 20], [23, 30, 34, 50]], 3

# Given a maze, represented by a matrix of bits (values 0 and 1), a rat must find a path from index [0][0] to [n-1][m-1].
#  The rat can only travel to the right or down, and can only travel on 0 values. 1 values represent walls.

# Input:   maze (Matrix of elements with values either 0 or 1)
# Output:  Array of two-item arrays indicating the path.

# Input:   [[0, 0, 0, 1],
#           [0, 1, 0, 1],
#           [0, 1, 0, 0],
#           [0, 0, 1, 0]]

# Output:  [[0, 0],
#           [0, 1],
#           [0, 2],
#           [1, 2],
#           [2, 2],
#           [2, 3],
#           [3, 3]]

# For M x N matrix.
# Time Complexity: 0(MN)
# Auxiliary Space Complexity: O(MN)

#         [ [0, 0, 0, 1],
#           [0, 1, 0, 1],
#           [0, 1, 0, 0],
#           [0, 0, 1, 0]]

def find_path_for_rat(matrix)
  return -1, -1 if !matrix || matrix.length == 0 || matrix[0].length == 0
  path = []
  length = matrix.length
  width = matrix[0].length

  traverse = ->(row, col) do
    if row < 0 || row >= length || col < 0 || col >= width ||
         matrix[row][col] == 1
      return
    end
    return true if row == length - 1 && col == width - 1
    path << [row, col]
    traverse.call(row, col + 1)
    traverse.call(row + 1, col)
  end
  path
end

pp find_path_for_rat [[0, 0, 0, 1], [0, 1, 0, 1], [0, 1, 0, 0], [0, 0, 1, 0]]
