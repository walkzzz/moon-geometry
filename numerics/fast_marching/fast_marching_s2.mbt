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
