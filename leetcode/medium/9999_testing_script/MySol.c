#include <stdio.h>
#include <stdlib.h>

void minHeapify(int arr[], int n, int i) {
    int smallest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;
    
    if (left < n && arr[left] < arr[smallest]) {
        smallest = left;
    }
    
    if (right < n && arr[right] < arr[smallest]) {
        smallest = right;
    }
    
    if (smallest != i) {
        int temp = arr[i];
        arr[i] = arr[smallest];
        arr[smallest] = temp;
        minHeapify(arr, n, smallest);
    }
}

void buildMinHeap(int arr[], int n) {
    for (int i = n / 2 - 1; i >= 0; --i) {
        minHeapify(arr, n, i);
    }
}

int findKthLargest(int arr[], int n, int k) {
    buildMinHeap(arr, k);
    
    for (int i = k; i < n; ++i) {
        if (arr[i] > arr[0]) {
            arr[0] = arr[i];
            minHeapify(arr, k, 0);
        }
    }
    
    return arr[0];
}

int main() {
    int arr[] = {3, 2, 1, 5, 6, 4};
    int n = sizeof(arr) / sizeof(arr[0]);
    int k = 2;
    int kthLargest = findKthLargest(arr, n, k);
    printf("The %dth largest element is %d\n", k, kthLargest);
    return 0;
}
