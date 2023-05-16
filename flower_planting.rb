#https://leetcode.com/problems/flower-planting-with-no-adjacent/
# You have n gardens, labeled from 1 to n, and an array paths where paths[i] = [xi, yi] describes a bidirectional path between garden xi to garden yi. In each garden, you want to plant one of 4 types of flowers.

# All gardens have at most 3 paths coming into or leaving it.

# Your task is to choose a flower type for each garden such that, for any two gardens connected by a path, they have different types of flowers.

# Return any such a choice as an array answer, where answer[i] is the type of flower planted in the (i+1)th garden. The flower types are denoted 1, 2, 3, or 4. It is guaranteed an answer exists.

# Example 1:

# Input: n = 3, paths = [[1,2],[2,3],[3,1]]
# Output: [1,2,3]
# Explanation:
# Gardens 1 and 2 have different types.
# Gardens 2 and 3 have different types.
# Gardens 3 and 1 have different types.
# Hence, [1,2,3] is a valid answer. Other valid answers include [1,2,4], [1,4,2], and [3,2,1].
# Example 2:

# Input: n = 4, paths = [[1,2],[3,4]]
# Output: [1,2,1,2]
# Example 3:

# Input: n = 4, paths = [[1,2],[2,3],[3,4],[4,1],[1,3],[2,4]]
# Output: [1,2,3,4]

# Constraints:

# 1 <= n <= 104
# 0 <= paths.length <= 2 * 104
# paths[i].length == 2
# 1 <= xi, yi <= n
# xi != yi
# Every garden has at most 3 paths coming into or leaving it.

def garden_no_adj(n, paths)
  return [1] if n == 1
  adj_list = create_adj_list n, paths
  result = Array.new(n).fill(0)
  flowers = [1, 2, 3, 4]

  dfs = ->(garden, i) do
    return if result[garden - 1] != 0
    neighbours = adj_list[garden]

    if !neighbours
      result[garden - 1] = 1
      return
    end
    result[garden - 1] = flowers[i]

    neighbours.each do |n|
      if result[n - 1] == flowers[i]
        result[garden - 1] = 0
        return
      end
    end

    neighbours.each { |n| dfs.call n, (i == 3) ? 0 : i + 1 }
  end
  flowers.each_with_index do |flower, i|
    (1..n).each { |garden| dfs.call garden, i }
    return result if result.index(0) == -1
  end
  result
end

def create_adj_list(n, paths)
  adj_list = {}
  paths.each do |tuple|
    adj_list[tuple[0]] ?
      adj_list[tuple[0]] << tuple[1] :
      adj_list[tuple[0]] = [tuple[1]]
    adj_list[tuple[1]] ?
      adj_list[tuple[1]] << tuple[0] :
      adj_list[tuple[1]] = [tuple[0]]
  end
  pp adj_list
  return adj_list
end

# pp garden_no_adj 4, [[1, 2], [3, 4]]
# pp garden_no_adj 3, [[1, 2], [2, 3], [3, 1]]
# pp garden_no_adj 4, [[1, 2], [2, 3], [3, 4], [4, 1], [1, 3], [2, 4]]
pp garden_no_adj 6, [[6, 4], [6, 1], [3, 1], [4, 5], [2, 1], [5, 6], [5, 2]]
