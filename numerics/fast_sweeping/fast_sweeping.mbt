///|
/// # Fast Sweeping Method
/// # 快速扫描法
///
/// Fast sweeping method for Eikonal equations via Gauss-Seidel iterations.
/// 通过 Gauss-Seidel 迭代求解 Eikonal 方程的快速扫描法。

///|
pub fn sweep_update(
  u_center : Double,
  u_neighbor1 : Double,
  u_neighbor2 : Double,
  f : Double,
  h : Double,
) -> Double {
  let inv_f = h / f
  let t1 = if u_neighbor1 < u_center { u_neighbor1 + inv_f } else { u_center }
  let t2 = if u_neighbor2 < u_center { u_neighbor2 + inv_f } else { u_center }
  if t1 > t2 {
    t1
  } else {
    t2
  }
}

///|
pub fn fast_sweeping_iterate(
  u : Array[Double],
  f : Array[Double],
  h : Double,
  nx : Int32,
  ny : Int32,
) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<u.length() {
    result.push(u[i])
  }
  let dirs = [(1, 1), (1, -1), (-1, 1), (-1, -1)]
  for d in 0..<4 {
    let (dx, dy) = dirs[d]
    let i_start = if dx > 0 { 1 } else { nx - 2 }
    let i_end = if dx > 0 { nx - 1 } else { 0 }
    let j_start = if dy > 0 { 1 } else { ny - 2 }
    let j_end = if dy > 0 { ny - 1 } else { 0 }
    let i_range : Array[Int32] = []
    let mut i = i_start
    while (dx > 0 && i <= i_end) || (dx < 0 && i >= i_end) {
      i_range.push(i)
      i += dx
    }
    let j_range : Array[Int32] = []
    let mut j = j_start
    while (dy > 0 && j <= j_end) || (dy < 0 && j >= j_end) {
      j_range.push(j)
      j += dy
    }
    for ii in 0..<i_range.length() {
      for jj in 0..<j_range.length() {
        let idx = i_range[ii] + j_range[jj] * nx
        let idx_l = i_range[ii] - 1 + j_range[jj] * nx
        let idx_r = i_range[ii] + 1 + j_range[jj] * nx
        let idx_d = i_range[ii] + (j_range[jj] - 1) * nx
        let idx_u = i_range[ii] + (j_range[jj] + 1) * nx
        if idx_l >= 0 &&
          idx_r < result.length() &&
          idx_d >= 0 &&
          idx_u < result.length() {
          result[idx] = sweep_update(
            result[idx],
            result[idx_l],
            result[idx_d],
            f[idx],
            h,
          )
        }
      }
    }
  }
  result
}

///|
pub fn sweeping_converged(
  u_old : Array[Double],
  u_new : Array[Double],
  tol : Double,
) -> Bool {
  let mut max_diff = 0.0
  for i in 0..<u_old.length() {
    let diff = (u_new[i] - u_old[i]).abs()
    if diff > max_diff {
      max_diff = diff
    }
  }
  max_diff < tol
}
