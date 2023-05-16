# https://leetcode.com/problems/find-the-town-judge/
# In a town, there are n people labeled from 1 to n. There is a rumor that one of these people is secretly the town judge.

# If the town judge exists, then:

# The town judge trusts nobody.
# Everybody (except for the town judge) trusts the town judge.
# There is exactly one person that satisfies properties 1 and 2.
# You are given an array trust where trust[i] = [ai, bi] representing that the person labeled ai trusts the person labeled bi. If a trust relationship does not exist in trust array, then such a trust relationship does not exist.

# Return the label of the town judge if the town judge exists and can be identified, or return -1 otherwise.
# Example 1:

# Input: n = 2, trust = [[1,2]]
# Output: 2
# Example 2:

# Input: n = 3, trust = [[1,3],[2,3]]
# Output: 3
# Example 3:

# Input: n = 3, trust = [[1,3],[2,3],[3,1]]
# Output: -1

# Constraints:

# 1 <= n <= 1000
# 0 <= trust.length <= 104
# trust[i].length == 2
# All the pairs of trust are unique.
# ai != bi
# 1 <= ai, bi <= n

class GraphNode
  attr_accessor :storage

  def initialize
    @storage = {}
  end

  def create_graph(arr)
    arr.each do |tuple|
      @storage[tuple[0]] ?
        @storage[tuple[0]] << tuple[1] :
        @storage[tuple[0]] = [tuple[1]]
    end
  end

  def find_judge(n)
    judges = []
    (1..n).each { |person| judges << person if !@storage[person] }
    return -1 if judges.length != 1
    (1..n).each do |person|
      next if person == judges[0]
      if !@storage[person]
        return -1
      elsif !@storage[person].include? judges[0]
        return -1
      end
    end
    judges[0]
  end
end

def find_judge2(n, trust)
  in_degrees = Array.new(n + 1, 0)
  out_degrees = Array.new(n + 1, 0)

  trust.each do |tuple|
    out_degrees[tuple[0]] += 1
    in_degrees[tuple[1]] += 1
  end
  pp in_degrees
  pp out_degrees

  (1..n + 1).each do |i|
    return i if in_degrees[i] == n - 1 && out_degrees[i] == 0
  end
  -1
end

g = GraphNode.new
g.create_graph [[1, 3], [2, 3]]
# pp g.find_judge 3

pp find_judge2 3, [[1, 3], [2, 3]]
