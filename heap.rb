



#left node - 2*parent + 1
#right node = 2*parent + 2
#parent node = (child - 1)/2

class MinHeap

  attr_reader :storage, :size
  def initialize
    @storage = []
    @size = 0
  end

  def insert(el)
    if @storage.empty?
      @storage << el
      @size += 1
    else
      @storage[@size] = el
      @size += 1
      bubble_up(@size-1)
    end
  end


  def bubble_up(index)
    return if index < 0 || index >= @size
    parent_idx = get_parent(index)
    while parent_idx >= 0 && @storage[index] < @storage[parent_idx]
      @storage[index], @storage[parent_idx] = @storage[parent_idx], @storage[index]
      index = parent_idx
      parent_idx = get_parent(parent_idx)
    end
  end

  def pop
    return if @storage.empty?
    output = @storage[0]
    @storage[0] = @storage.pop
    @size -= 1
    bubble_down(0)
    output
  end

  def bubble_down(index)
    return if index < 0 || index >= @size
    while(index <= @size-1)
      left_idx = get_left(index)
      right_idx = get_right(index)
      return if left_idx >= @size
      left_idx <= @size - 1  ? left = @storage[left_idx] : left = nil
      right_idx <= @size - 1 ? right = @storage[right_idx]  : right = nil
      if (left && @storage[index] > left) || (right && @storage[index] > right)
        if left && right && right < left
          @storage[index], @storage[right_idx] = @storage[right_idx], @storage[index]
          index = right_idx
        else
          @storage[index], @storage[left_idx] = @storage[left_idx], @storage[index]
          index = left_idx
        end
      end
    end
  end

  def get_parent(child)
    (child-1)/2
  end

  def get_left(parent)
    parent*2 + 1
  end

  def get_right(parent)
    parent*2 + 2
  end
end



class MaxHeap

  attr_reader :storage, :size
  def initialize
    @storage = []
    @size = 0
  end

  def insert(el)
    if @storage.empty?
      @storage << el
      @size += 1
    else
      @storage[@size] = el
      @size += 1
      bubble_up(@size-1)
    end
  end


  def bubble_up(index)
    return if index < 0 || index >= @size
    parent_idx = get_parent(index)
    while parent_idx >= 0 && @storage[index] > @storage[parent_idx]
      @storage[index], @storage[parent_idx] = @storage[parent_idx], @storage[index]
      index = parent_idx
      parent_idx = get_parent(parent_idx)
    end
  end

  def pop
    return if @storage.empty?
    output = @storage[0]
    @storage[0] = @storage.pop
    @size -= 1
    bubble_down(0)
    output
  end

  def bubble_down(index)
    return if index < 0 || index >= @size
    while(index <= @size-1)
      left_idx = get_left(index)
      right_idx = get_right(index)
      return if left_idx >= @size
      left_idx <= @size - 1  ? left = @storage[left_idx] : left = nil
      right_idx <= @size - 1 ? right = @storage[right_idx]  : right = nil
      if (left && @storage[index] < left) || (right && @storage[index] < right)
        if left && right && right > left
          @storage[index], @storage[right_idx] = @storage[right_idx], @storage[index]
          index = right_idx
        else
          @storage[index], @storage[left_idx] = @storage[left_idx], @storage[index]
          index = left_idx
        end
      end
    end
  end

  def get_parent(child)
    (child-1)/2
  end

  def get_left(parent)
    parent*2 + 1
  end

  def get_right(parent)
    parent*2 + 2
  end
end
