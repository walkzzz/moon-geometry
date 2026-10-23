///|
/// Upper bound: first index where arr[i] > target. / 上界。
pub fn upper_bound(arr : Array[Double], target : Double) -> Int32 {
  let mut lo = 0
  let mut hi = arr.length()
  while lo < hi {
    let mid = lo + (hi - lo) / 2
    if arr[mid] <= target {
      lo = mid + 1
    } else {
      hi = mid
    }
  }
  lo
}

///|
/// Remove duplicates from a sorted array. / 去重有序数组。
pub fn unique_sorted(arr : Array[Double]) -> Array[Double] {
  let result : Array[Double] = []
  if arr.length() == 0 {
    return result
  }
  result.push(arr[0])
  for i in 1..<arr.length() {
    if arr[i] != arr[i - 1] {
      result.push(arr[i])
    }
  }
  result
}
