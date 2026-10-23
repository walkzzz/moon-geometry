///|
/// Merge two sorted arrays. / 合并两个有序数组。
pub fn merge_sorted(a : Array[Double], b : Array[Double]) -> Array[Double] {
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
