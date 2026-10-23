///|
/// Root mean square Chamfer distance. / 均方根 Chamfer 距离。
pub fn chamfer_rms(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
) -> Double {
  (chamfer_squared_directed(a, b) + chamfer_squared_directed(b, a)).sqrt()
}
