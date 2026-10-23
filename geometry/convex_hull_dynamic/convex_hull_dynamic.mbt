///|
/// Dynamic convex hull supporting point insertion. / 支持点插入的动态凸包。
pub struct DynamicHull {
  points : Array[@core.Point2D]
  hull : Array[@core.Point2D]
}

///|
/// Create an empty dynamic convex hull. / 创建空的动态凸包。
pub fn DynamicHull::new() -> DynamicHull {
  { points: [], hull: [], }
}
