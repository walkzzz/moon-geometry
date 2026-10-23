///|
/// Find k-th smallest element (quickselect). / 第 k 小元素。
pub fn kth_element(arr : Array[Double], k : Int) -> Double? {
  if k < 0 || k >= arr.length() {
    return None
  }
  let copy : Array[Double] = []
  for i in 0..<arr.length() {
    copy.push(arr[i])
  }
  copy.sort()
  Some(copy[k])
}
