#https://leetcode.com/problems/add-two-numbers/
# You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order,
# and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

# You may assume the two numbers do not contain any leading zero, except the number 0 itself.

class ListNode
  attr_accessor :val, :next
  def initialize(val = 0, _next = nil)
    @val = val
    @next = _next
  end
end

def add_two_numbers(l1, l2)
  return l2 if !l1
  return l1 if !l2
  ll3 = nil

  current3 = nil
  current1 = l1
  current2 = l2
  carry = nil
  val = 0
  while current1 || current2
    val = carry if carry
    val += current1.val if current1
    val += current2.val if current2
    pp val
    if val >= 10
      carry = val / 10
      val = val % 10
    else
      carry = 0
    end
    current1 = current1.next if current1
    current2 = current2.next if current2
    node = ListNode.new val
    if current3
      current3.next = node
      current3 = current3.next
    else
      current3 = node
      ll3 = current3
    end
  end
  if carry && carry > 0
    node = ListNode.new carry
    current3.next = node
  end
  ll3
end

l17 = ListNode.new 9
l16 = ListNode.new 9, l17
l15 = ListNode.new 9, l16
l14 = ListNode.new 9, l15
l13 = ListNode.new 9, l14
l12 = ListNode.new 9, l13
h1 = ListNode.new 9, l12

l23 = ListNode.new 9
l22 = ListNode.new 9, l23
l21 = ListNode.new 9, l22
h2 = ListNode.new 9, l21

pp add_two_numbers h1, h2
