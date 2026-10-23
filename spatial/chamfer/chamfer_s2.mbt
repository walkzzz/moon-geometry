///|
/// Symmetric Chamfer distance. / 对称 Chamfer 距离。
pub fn chamfer_distance(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
) -> Double {
  chamfer_directed(a, b) + chamfer_directed(b, a)
}
