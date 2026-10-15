///|
/// Binary search in a sorted array. Returns index or None. / 二分查找。
pub fn binary_search(arr : Array[Double], target : Double) -> Int? {
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
pub fn lower_bound(arr : Array[Double], target : Double) -> Int {
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

///|
/// Upper bound: first index where arr[i] > target. / 上界。
pub fn upper_bound(arr : Array[Double], target : Double) -> Int {
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

///|
/// Merge two sorted arrays. / 合并两个有序数组。
pub fn merge_sorted(
  a : Array[Double],
  b : Array[Double],
) -> Array[Double] {
  let result : Array[Double] = []
  let mut i = 0
  let mut j = 0
  while i < a.length() && j < b.length() {
    if a[i] <= b[j] {
      result.push(a[i])
      i += 1
    } else {
      result.push(b[j])
      j += 1
    }
  }
  while i < a.length() {
    result.push(a[i])
    i += 1
  }
  while j < b.length() {
    result.push(b[j])
    j += 1
  }
  result
}