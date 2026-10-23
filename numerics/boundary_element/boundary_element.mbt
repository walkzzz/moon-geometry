///|
/// # Boundary Element Method
/// # 边界元方法
///
/// BEM for boundary integral equations.
/// 边界积分方程的边界元方法。

///|
pub fn fundamental_solution_2d(r : Double) -> Double {
  if r < 0.000000000001 {
    0.0
  } else {
    -@math.ln(r) / (2.0 * 3.141592653589793)
  }
}
