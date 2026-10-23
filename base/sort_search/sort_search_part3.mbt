///|
/// Check if an array is sorted in non-decreasing order. / 检查数组是否有序。
pub fn is_sorted(arr : Array[Double]) -> Bool {
  for i in 1..<arr.length() {
    if arr[i] < arr[i - 1] {
      return false
    }
  }
  true
}
