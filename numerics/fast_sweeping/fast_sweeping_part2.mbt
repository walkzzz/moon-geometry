///|
pub fn fast_sweeping_iterate(u : Array[Double], f : Array[Double], h : Double, nx : Int, ny : Int) -> Array[Double] {
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
    let i_range : Array[Int] = []
    let mut i = i_start
    while (dx > 0 && i <= i_end) || (dx < 0 && i >= i_end) {
      i_range.push(i)
      i += dx
    }
    let j_range : Array[Int] = []
    let mut j = j_start
    while (dy > 0 && j <= j_end) || (dy < 0 && j >= j_end) {
      j_range.push(j)
      j += dy
    }
    for ii in 0..<i_range.length() {
      for jj in 0..<j_range.length() {
        let idx = i_range[ii] + j_range[jj] * nx
        let idx_l = (i_range[ii] - 1) + j_range[jj] * nx
        let idx_r = (i_range[ii] + 1) + j_range[jj] * nx
        let idx_d = i_range[ii] + (j_range[jj] - 1) * nx
        let idx_u = i_range[ii] + (j_range[jj] + 1) * nx
        if idx_l >= 0 && idx_r < result.length() && idx_d >= 0 && idx_u < result.length() {
          result[idx] = sweep_update(result[idx], result[idx_l], result[idx_d], f[idx], h)
        }
      }
    }
  }
  result
}
