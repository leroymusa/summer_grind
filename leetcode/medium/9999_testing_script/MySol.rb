class Solution
  def find_kth_largest(nums, k)
    min_heap = MinHeap.new(nums[0...k])
    
    (k...nums.length).each do |i|
      min_heap.push(nums[i]) if nums[i] > min_heap.peek
    end
    
    min_heap.peek
  end
end

class MinHeap
  attr_reader :heap
  
  def initialize(array = [])
    @heap = build_heap(array)
  end
  
  def build_heap(array)
    last_parent = (array.length - 2) / 2
    (last_parent).downto(0).each do |i|
      sift_down(i, array.length - 1, array)
    end
    array
  end
  
  def sift_down(start, end_idx, heap)
    root = start
    while root * 2 + 1 <= end_idx
      child = root * 2 + 1
      swap = root
      swap = child if heap[swap] > heap[child]
      swap = child + 1 if child + 1 <= end_idx && heap[swap] > heap[child + 1]
      break if swap == root
      heap[root], heap[swap] = heap[swap], heap[root]
      root = swap
    end
  end
  
  def peek
    heap.first
  end
  
  def push(value)
    heap.push(value)
    sift_down(0, heap.length - 1, heap)
  end
end
