///|
/// # Level Set Method
/// # 水平集方法
///
/// Level set methods for interface tracking and evolution.
/// 界面追踪与演化的水平集方法。

///|
pub fn level_set_sign(phi : Double) -> Int32 {
  if phi > 0.0 {
    1
  } else if phi < 0.0 {
    -1
  } else {
    0
  }
}

///|
pub fn level_set_normal(grad_phi : (Double, Double)) -> (Double, Double) {
  let (gx, gy) = grad_phi
  let mag = (gx * gx + gy * gy).sqrt()
  if mag < 0.000000000001 {
    (0.0, 0.0)
  } else {
    (gx / mag, gy / mag)
  }
}

///|
pub fn level_set_curvature(
  grad : (Double, Double),
  hessian : (Double, Double, Double),
) -> Double {
  let (gx, gy) = grad
  let (hxx, hxy, hyy) = hessian
  let mag = (gx * gx + gy * gy).sqrt()
  if mag < 0.000000000001 {
    return 0.0
  }
  let mag3 = mag * mag * mag
  (gx * gx * hyy - 2.0 * gx * gy * hxy + gy * gy * hxx) / mag3
}

///|
pub fn reinitialize_step(phi : Double, dt : Double, s0 : Int32) -> Double {
  phi + dt * s0.to_double() * (1.0 - phi.abs())
}

///|
pub fn level_set_area(phi : Array[Double], dx : Double) -> Double {
  let mut area = 0.0
  for i in 0..<phi.length() {
    if phi[i] < 0.0 {
      area += dx * dx
    }
  }
  area
}
