#
# Complete the 'printBackward' function below.
#
# The function accepts INTEGER_SINGLY_LINKED_LIST node as parameter.
#

#
# For your reference:
#
# SinglyLinkedListNode
#     int data
#     SinglyLinkedListNode next
#
#

class SinglyLinkedListNode
  attr_accessor :data, :next
  def initialize(val = nil, _next = nil)
    @data = val
    @next = _next
  end
end

def deserialize(arr)
  return nil if !arr || arr.length == 0
  head = SinglyLinkedListNode.new arr[0]
  current = head
  (1...arr.length).each do |i|
    node = SinglyLinkedListNode.new arr[i]
    current.next = node
    current = current.next
  end
  head
end

def printBackward(node)
  # Write your code here
  s = Array.new

  current = node
  while current
    s << current.data
    current = current.next
  end
  pp s.pop while s.length != 0
end

def condense(head)
  # Write your code here
  arr = Array.new(1001).fill(0)
  current = head
  prev = nil
  while current
    if arr[current.data] == 1
      if current.next
        prev.next = current.next
        current = prev.next
        next
      else
        prev.next = nil
        return head
      end
    end
    arr[current.data] = 1
    prev = current
    current = current.next
  end
  head
end

ll = deserialize [8, 3, 4, 3, 2, 6, 1, 2, 6]
pp ll
pp condense ll

#
# Complete the 'reverseLinkedList' function below.
#
# The function is expected to return an INTEGER_SINGLY_LINKED_LIST.
# The function accepts INTEGER_SINGLY_LINKED_LIST node as parameter.
#
# For your reference:
#
# SinglyLinkedListNode
#     int data
#     SinglyLinkedListNode next

def reverseLinkedList(node)
  # Write your code here
  current = node
  prev = nil
  while current
    next_el = current.next
    current.next = prev
    prev = current
    current = next_el
  end
  prev
end

# https://leetcode.com/problems/middle-of-the-linked-list/?envType=study-plan&id=level-1
# Middle of the Linked List
# Given the head of a singly linked list, return the middle node of the linked list.
# If there are two middle nodes, return the second middle node.

# Example 1:

# Input: head = [1,2,3,4,5]
# Output: [3,4,5]
# Explanation: The middle node of the list is node 3.
# Example 2:

# Input: head = [1,2,3,4,5,6]
# Output: [4,5,6]
# Explanation: Since the list has two middle nodes with values 3 and 4, we return the second one.

# Constraints:
# The number of nodes in the list is in the range [1, 100].
# 1 <= Node.val <= 100
def middle_node(head)
  return if !head
  length = find_length head
  middle = length / 2
  index = 0
  current = head
  while current && index != middle
    index += 1
    current = current.next
  end
  current
end

def find_length(head)
  length = 0
  current = head
  while current
    length += 1
    current = current.next
  end
  length
end

# https://leetcode.com/problems/linked-list-cycle-ii/?envType=study-plan&id=level-1
# 142. Linked List Cycle II
# Given the head of a linked list, return the node where the cycle begins. If there is no cycle, return null.

# There is a cycle in a linked list if there is some node in the list that can be reached again by continuously following
# the next pointer. Internally, pos is used to denote the index of the node that tail's next pointer is connected to (0-indexed).
# It is -1 if there is no cycle. Note that pos is not passed as a parameter.
# end
# Do not modify the linked list.

# Example 1:

# Input: head = [3,2,0,-4], pos = 1
# Output: tail connects to node index 1
# Explanation: There is a cycle in the linked list, where tail connects to the second node.
# Example 2:

# Input: head = [1,2], pos = 0
# Output: tail connects to node index 0
# Explanation: There is a cycle in the linked list, where tail connects to the first node.
# Example 3:

# Input: head = [1], pos = -1
# Output: no cycle
# Explanation: There is no cycle in the linked list.
