///|
/// Earth Mover's Distance for 1D distributions (sorted arrays). / 一维分布的 EMD（已排序数组）。
pub fn emd_1d(a : Array[Double], b : Array[Double]) -> Double {
  let n = a.length()
  let m = b.length()
  if n == 0 || m == 0 {
    return 0.0
  }
  let sa = a.copy()
  let sb = b.copy()
  sa.sort()
  sb.sort()
  let mut i = 0
  let mut j = 0
  let mut result = 0.0
  let mut ai = 1.0 / n.to_double()
  let mut bj = 1.0 / m.to_double()
  while i < n && j < m {
    let diff = (sa[i] - sb[j]).abs()
    let w = if ai < bj { ai } else { bj }
    result += w * diff
    if ai < bj {
      bj = bj - ai
      i += 1
      if i < n {
        ai = 1.0 / n.to_double()
      }
    } else {
      ai = ai - bj
      j += 1
      if j < m {
        bj = 1.0 / m.to_double()
      }
    }
  }
  result
}
