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

///|
/// EMD for uniform point distributions (using x-coordinates). / 均匀点分布的 EMD（使用 x 坐标）。
pub fn emd_uniform(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
) -> Double {
  let xs_a : Array[Double] = []
  let xs_b : Array[Double] = []
  for p in a {
    xs_a.push(p.x())
  }
  for p in b {
    xs_b.push(p.x())
  }
  emd_1d(xs_a, xs_b)
}

///|
/// EMD for 1D weighted distributions. / 一维加权分布的 EMD。
pub fn emd_weighted(
  positions : Array[Double],
  weights_a : Array[Double],
  weights_b : Array[Double],
) -> Double {
  let n = positions.length()
  if n == 0 {
    return 0.0
  }
  let mut result = 0.0
  let mut cum_a = 0.0
  let mut cum_b = 0.0
  for i in 0..<n {
    cum_a += weights_a[i]
    cum_b += weights_b[i]
    result += (cum_a - cum_b).abs()
  }
  result
}
