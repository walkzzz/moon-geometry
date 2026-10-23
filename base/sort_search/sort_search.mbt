///|
/// Binary search in a sorted array. Returns index or None. / 二分查找。
pub fn binary_search(arr : Array[Double], target : Double) -> Int32? {
  let mut lo = 0
  let mut hi = arr.length() - 1
  while lo <= hi {
    let mid = lo + (hi - lo) / 2
    if arr[mid] < target {
      lo = mid + 1
    } else if arr[mid] > target {
      hi = mid - 1
    } else {
      return Some(mid)
    }
  }
  None
}

///|
/// Lower bound: first index where arr[i] >= target. / 下界。
pub fn lower_bound(arr : Array[Double], target : Double) -> Int32 {
  let mut lo = 0
  let mut hi = arr.length()
  while lo < hi {
    let mid = lo + (hi - lo) / 2
    if arr[mid] < target {
      lo = mid + 1
    } else {
      hi = mid
    }
  }
  lo
}
