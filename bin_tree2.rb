# https://leetcode.com/problems/cousins-in-binary-tree/submissions/
# Given the root of a binary tree with unique values and the values of two different nodes of the tree x and y, return true if the nodes corresponding to the values x and y in the tree are cousins, or false otherwise.

# Two nodes of a binary tree are cousins if they have the same depth with different parents.
# Note that in a binary tree, the root node is at the depth 0, and children of each depth k node are at the depth k + 1.
# Example 1:
# Input: root = [1,2,3,4], x = 4, y = 3
# Output: false

# Example 2:
# Input: root = [1,2,3,null,4,null,5], x = 5, y = 4
# Output: true

# Example 3:
# Input: root = [1,2,3,null,4], x = 2, y = 3
# Output: false

def is_cousins_dfs(root, x, y)
  level_x, level_y = 0, 0
  parent_x, parent_y = nil, nil
  traverse =-> (current, parent, level){
      return if !current || (parent_x && parent_y)
      if current.val == x
          level_x = level
          parent_x = parent
      end
      if current.val == y
          level_y = level
          parent_y = parent
      end
      level_y = level if current.val == y
      traverse.call(current.left, current, level+1)
      traverse.call(current.right,current, level+1)
  }
  traverse.call(root,nil, 0)
  return true if level_x == level_y && parent_x != parent_y
  return false
end

def is_cousins_bfs(root, x, y)
  level_x, level_y = 0, 0
  parent_x, parent_y = nil, nil
  current_level = 0
  q = Queue.new
  q << root
  while !q.empty?
    size = q.size
    current_level += 1
    (0...size).each {
      current = q.pop
      if current.left && current.left.val == x || current.right && current.right.val ==x
        parent_x = current
        level_x = current_level
      elsif current.left && current.left.val == y || current.right && current.right.val == y
        parent_y = current
        level_y = current_level
      end
      q << current.left if current.left
      q << current.right if current.right
    }
  end
  return true if level_x == level_y && parent_x != parent_y
  return false

end
