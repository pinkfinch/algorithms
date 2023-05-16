class Node
  attr_accessor :value, :left, :right
  def initialize(value = nil, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end
end

def create_bin_tree(arr)
  return if !arr || arr.length == 0
  root = Node.new arr[0]
  index = 1
  parent = nil
  traverse = ->(val, parent) do
    if val < parent.value
      if !parent.left
        left = Node.new val
        parent.left = left
      else
        traverse val, parent.left
      end
    elsif val > parent.value
      if !parent.right
        right = Node.new val
        parent.right = right
      else
        traverse val, parent.right
      end
    end
  end
end
