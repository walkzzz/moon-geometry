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
