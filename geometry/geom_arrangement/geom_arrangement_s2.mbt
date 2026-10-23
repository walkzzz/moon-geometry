///|
/// Compute the intersection point of two lines a1*x+b1*y=c1 and a2*x+b2*y=c2. / 计算两条直线 a1*x+b1*y=c1 与 a2*x+b2*y=c2 的交点。
pub fn line_intersection(
  a1 : Double,
  b1 : Double,
  c1 : Double,
  a2 : Double,
  b2 : Double,
  c2 : Double,
) -> (Double, Double) {
  let det = a1 * b2 - a2 * b1
  ((c1 * b2 - c2 * b1) / det, (a1 * c2 - a2 * c1) / det)
}

///|
/// Compute the zone theorem complexity for n lines. / 计算 n 条直线的区域定理复杂度。
pub fn zone_complexity(n : Int32) -> Int32 {
  6 * n - 12
}

///|
/// Count the number of faces in an arrangement of n lines. / 计算 n 条直线安排的面数。
pub fn arrangement_faces(n : Int32) -> Int32 {
  n * (n + 1) / 2 + 1
}
