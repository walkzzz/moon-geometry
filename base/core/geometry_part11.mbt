///|
/// Trait for 2D objects with a bounding box.
/// 有包围盒的 2D 对象 trait。
pub(open) trait Bounded2D {
  fn bbox(self : Self) -> (Double, Double, Double, Double)
}

///|
/// Trait for subdivisible curves: subdivide at parameter t into two sub-curves.
/// 可细分曲线 trait：在参数 t 处细分为两条子曲线。
pub(open) trait Subdivisible {
  fn subdivide(self : Self, t : Double) -> (Self, Self)
}
