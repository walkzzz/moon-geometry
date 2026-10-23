///|
/// # Fast Marching Method
/// # 快速行进法
///
/// Fast marching method for solving Eikonal equation |grad u| = 1/f.
/// 求解 Eikonal 方程 |grad u| = 1/f 的快速行进法。

///|
pub fn solve_eikonal_2d(
  u_left : Double,
  u_down : Double,
  f : Double,
  h : Double,
) -> Double {
  let inv_f = 1.0 / f
  let hh = h * h * inv_f * inv_f
  let disc = 2.0 * hh - (u_left - u_down) * (u_left - u_down)
  if disc < 0.0 {
    if u_left < u_down {
      u_left + inv_f * h
    } else {
      u_down + inv_f * h
    }
  } else {
    let result = (u_left + u_down + disc.sqrt()) / 2.0
    if result > u_left && result > u_down {
      result
    } else if u_left < u_down {
      u_left + inv_f * h
    } else {
      u_down + inv_f * h
    }
  }
}

///|
pub fn fast_marching_step(
  narrow_band : Array[(Int32, Double)],
  f : Double,
  h : Double,
) -> Array[(Int32, Double)] {
  let result : Array[(Int32, Double)] = []
  for i in 0..<narrow_band.length() {
    let (idx, u) = narrow_band[i]
    result.push((idx, u + h / f))
  }
  result
}

///|
pub fn is_far(value : Double) -> Bool {
  value > 99999999.0
}

///|
pub fn is_frozen(value : Double) -> Bool {
  value >= 0.0 && value < 99999999.0
}
