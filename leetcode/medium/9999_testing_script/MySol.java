import java.util.PriorityQueue;

class Solution {
    public int findKthLargest(int[] nums, int k) {
        // Min-Heap to store the K largest elements
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        
        // Insert the first K elements into the min-heap
        for (int i = 0; i < k; i++) {
            minHeap.offer(nums[i]);
        }
        
        // For the rest of the elements, only keep the K largest elements in the heap
        for (int i = k; i < nums.length; i++) {
            if (nums[i] > minHeap.peek()) {
                minHeap.poll();
                minHeap.offer(nums[i]);
            }
        }
        
        // The root of the min-heap will be the Kth largest element
        return minHeap.peek();
    }
}
