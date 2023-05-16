require "set"

def bfs(origin)
  # Write your code here
  return "" if !origin
  q = Queue.new
  q << origin
  return_str = ""
  visited = { origin => true }
  while !q.empty?
    current = q.pop
    return_str << current.id
    for v in current.edges
      next if visited[v]
      visited[v] = true
      q << v
    end
  end
  return_str
end

#using backtracking - to remove the edge id from path after recursive call
#Similarly removing from visited, so that other paths can be found out

def find_all_paths(origin, destination)
  # Write your code here
  visited = {}
  output = []
  traverse = ->(current, path) do
    return if visited[current]
    if current.id == destination
      output << path.join
      return
    end
    visited[current] = true
    current.edges.each do |edge|
      next if visited[edge]
      path << edge.id
      traverse.call edge, path
      path.pop
    end
    visited.delete current
  end
  traverse.call origin, [origin.id]
  return output.sort
end

def valid_tree(n, edges)
  return true if n == 1
  return false if edges.length == 0 && n > 1
  adj_list = create_adj_list(edges)
  visited = Set.new
  has_cycle = false

  dfs = ->(node, parent) do
    return if visited.include? node
    visited << node
    neighbours = adj_list[node]
    neighbours.each do |n|
      next if n == parent
      if visited.include? n
        has_cycle = true
        return
      end
      dfs.call n, node
    end
  end
  dfs.call adj_list.keys[0], nil
  return visited.length == n && !has_cycle
end

def create_adj_list(edges)
  adj_list = {}
  edges.each do |tuple|
    adj_list[tuple[0]] ?
      adj_list[tuple[0]] << tuple[1] :
      adj_list[tuple[0]] = [tuple[1]]
    adj_list[tuple[1]] ?
      adj_list[tuple[1]] << tuple[0] :
      adj_list[tuple[1]] = [tuple[0]]
  end
  adj_list
  pp adj_list
end

#https://leetcode.com/problems/number-of-connected-components-in-an-undirected-graph/description/
def count_components(n, edges)
  adj_list = create_adj_list edges
  visited = Set.new
  count = 0
  dfs = ->(node) do
    return if visited.include? node
    visited << node
    neighbours = adj_list[node]
    #pp neighbours, node
    neighbours.each do |n|
      next if visited.include? n
      dfs.call n
    end
  end

  adj_list.keys.each do |node|
    next if visited.include? node
    dfs.call node
    count += 1
    return count if visited.length == n
  end
  count += n - adj_list.keys.length
  count
end

def dfs(origin)
  visited = Set.new
  result = []
  adj_list = create_adj_list_directed(origin)

  traverse = ->(current) do
    return if visited.include? current
    result << current
    visited << current
    neighbours = adj_list[current]
    return if !neighbours
    neighbours.each do |n|
      next if visited.include? n
      traverse.call(n)
    end
  end
  traverse.call(adj_list.keys[0])
  result
end

def create_adj_list_directed(edges)
  adj_list = {}
  edges.each do |tuple|
    adj_list[tuple[0]] ?
      adj_list[tuple[0]] << tuple[1] :
      adj_list[tuple[0]] = [tuple[1]]
  end
  adj_list
  pp adj_list
end

def bfs_directed(origin)
  adj_list = create_adj_list_directed(origin)
  q = Queue.new
  visited = Set.new
  result = []
  q << adj_list.keys[0]
  while !q.empty?
    current = q.pop
    next if visited.include? current
    visited << current
    result << current
    neighbours = adj_list[current]
    next if !neighbours
    neighbours.each do |n|
      next if visited.include? n
      q << n
    end
  end
  result
end

def bfs_degree(start, edges, n)
  adj_list = create_adj_list(edges)
  q = Queue.new
  visited = Set.new
  q << [adj_list.keys[0], 0]
  result = []
  while !q.empty?
    node_degree = q.pop
    current = node_degree[0]
    degree = node_degree[1]
    next if visited.include? current
    result << current if degree == n
    visited << current
    neighbours = adj_list[current]
    next if !neighbours
    neighbours.each { |n| q << [n, degree + 1] }
  end
  result
end

def dfs_with_while_loop(start, edges)
  adj_list = create_adj_list(edges)
  stack = []
  visited = Set.new
  stack << start
  result = []
  while !stack.empty?
    current = stack.pop
    next if visited.include? current
    result << current
    visited << current
    neighbours = adj_list[current]
    next if !neighbours
    neighbours.each { |n| stack << n }
  end
  result
end

# https://outco.teachable.com/courses/438359/lectures/6721874
def valid_path(edges, origin, destination)
  visited = Set.new
  adj_list = create_adj_list_directed(edges)

  traverse = ->(current) do
    return [current] if current == destination
    return if visited.include? current
    visited << current
    neighbours = adj_list[current]
    return [] if !neighbours
    neighbours.each do |n|
      path = traverse.call(n)
      if path.length > 0
        path << current
        return path
      end
    end
    return []
  end

  path = traverse.call(origin)
  path.reverse
end

def detect_cycle(edges)
  visited = Set.new
  adj_list = create_adj_list_directed(edges)
  ancestors = Set.new
  dfs = ->(current) do
    return true if ancestors.include? current
    return false if visited.include? current
    visited << current
    ancestors << current
    neighbours = adj_list[current]
    return false if !neighbours
    neighbours.each { |n| return true if dfs(n) }
    ancestors.delete(current)
    return false
  end

  adj_list.keys.each { |key| return true if dfs.call adj_list[key] }
  false
end

def dfs_post_with_stack(start, edges)
  result = []
  stack = [start]
  visited = { start => "pre" }
  adj_list = create_adj_list(edges)

  while !stack.empty?
    current = stack[-1]
    if visited[current] == "pre"
      neighbours = adj_list[current]

      neighbours.each do |n|
        if !visited[n]
          stack << n
          visited[n] = "pre"
        end
      end
      visited[current] = "post"
    else
      result << stack.pop
    end
  end
  result
end

#directed acyclic graph
def topological_sort(edges)
  adj_list = create_adj_list_directed edges
  result = []
  visited = Set.new
  post_dfs = ->(current) do
    return if visited.include? current
    visited << current
    neighbours = adj_list[current]
    if !neighbours
      result << current
      return
    end
    neighbours.each { |n| post_dfs.call(n) if !visited.include? n }
    result << current
  end
  adj_list.keys.each { |key| post_dfs.call(key) }

  result.reverse
end

pp dfs [[1, 2], [2, 3], [3, 4], [4, 1], [1, 5]]
pp dfs_with_while_loop 1, [[1, 2], [2, 3], [3, 4], [4, 1], [1, 5]]
pp "dfs post with stack #{dfs_post_with_stack 1, [[1, 2], [2, 3], [3, 4], [4, 1], [1, 5]]}"
pp bfs_directed [[1, 2], [2, 3], [3, 4], [4, 1], [1, 5]]

pp detect_cycle [[1, 2], [2, 4], [4, 1], [1, 3], [3, 4]]
pp bfs_degree(1, [[1, 2], [2, 3], [3, 4], [4, 1], [1, 5]], 2)

pp "topological sort:  #{topological_sort([[1, 2], [1, 3], [4, 3], [2, 5], [3, 5]])}"
