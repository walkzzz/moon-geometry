///|
/// Map a function over an array of 2D points.
/// 对 2D 点数组映射函数。
pub fn map_points(
  pts : Array[Point2D],
  f : (Point2D) -> Point2D,
) -> Array[Point2D] {
  let result : Array[Point2D] = []
  for p in pts {
    result.push(f(p))
  }
  result
}

///|
/// Trait for transforms that can be applied to 2D points.
/// 可应用于 2D 点的变换 trait。
pub(open) trait PointTransform {
  apply(self : Self, p : Point2D) -> Point2D
  apply_batch(self : Self, points : Array[Point2D]) -> Array[Point2D] = _
}


///|
/// Default implementation of `apply_batch` for `PointTransform`.
/// `PointTransform` 的 `apply_batch` 默认实现。
impl PointTransform with apply_batch(self, points) {
  map_points(points, fn(p) { self.apply(p) })
}