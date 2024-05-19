import Foundation

class Solution {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var minHeap = Heap(priorityFunction: >, elements: Array(nums[0..<k]))
        
        for i in k..<nums.count {
            if nums[i] > minHeap.peek()! {
                minHeap.replace(element: nums[i])
            }
        }
        
        return minHeap.peek()!
    }
}

struct Heap<Element> {
    var elements: [Element]
    let priorityFunction: (Element, Element) -> Bool
    
    init(priorityFunction: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
        self.priorityFunction = priorityFunction
        self.elements = elements
        buildHeap()
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var count: Int {
        return elements.count
    }
    
    func peek() -> Element? {
        return elements.first
    }
    
    mutating func buildHeap() {
        for i in stride(from: (elements.count / 2 - 1), through: 0, by: -1) {
            siftDown(from: i)
        }
    }
    
    mutating func siftDown(from index: Int) {
        var parent = index
        while true {
            let left = 2 * parent + 1
            let right = 2 * parent + 2
            var candidate = parent
            if left < elements.count && priorityFunction(elements[left], elements[candidate]) {
                candidate = left
            }
            if right < elements.count && priorityFunction(elements[right], elements[candidate]) {
                candidate = right
            }
            if candidate == parent {
                return
            }
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
    
    mutating func replace(element: Element) {
        elements[0] = element
        siftDown(from: 0)
    }
}
