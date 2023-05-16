# https://leetcode.com/problems/walls-and-gates/description/
# you are given an m x n grid rooms initialized with these three possible values.

# -1 A wall or an obstacle.
# 0 A gate.
# INF Infinity means an empty room. We use the value 231 - 1 = 2147483647 to represent INF as you may assume that the
# distance to a gate is less than 2147483647.
# Fill each empty room with the distance to its nearest gate. If it is impossible to reach a gate, it should be filled with INF.

# Input: rooms = [[2147483647,-1,0,2147483647],[2147483647,2147483647,2147483647,-1],[2147483647,-1,2147483647,-1],[0,-1,2147483647,2147483647]]
# Output: [[3,-1,0,1],[2,2,1,-1],[1,-1,2,-1],[0,-1,3,4]]
# Example 2:

# Input: rooms = [[-1]]
# Output: [[-1]]
#
def walls_and_gates(rooms)
  q = Queue.new
  directions = [[-1, 0], [1, 0], [0, 1], [0, -1]]
  rooms.each_with_index do |row, i|
    rows.each_with_index { |el, j| q << [i, j] if rooms[i][j] == 0 }
  end

  while !q.empty?
    row, col = q.pop
    directions.each do |dir|
      c_row = row + dir[0]
      c_col = col + dir[1]
      next if !check_bounds(c_row, c_col, rooms)
      rooms[c_row][c_col] = rooms[row][col] + 1
      q << [c_row][c_col]
    end
  end
  rooms
end

def check_bounds(row, col, rooms)
  if row < 0 || row > rooms.length
    return false
  elsif col < 0 || col > rooms[0].length
    return false
  elsif rooms[row][col] != 2_147_483_647
    return false
  end
  return true
end
