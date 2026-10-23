///|
/// Trait for shapes that can test point containment.
/// 可测试点包含的形状 trait。
pub(open) trait Containable {
  fn contains(self : Self, p : Point2D) -> Bool
}

///|
/// Trait for measurable 3D shapes with volume and surface area.
/// 可度量 3D 形状 trait，提供体积和表面积计算。
pub(open) trait Measurable3D {
  fn volume(self : Self) -> Double
  fn surface_area(self : Self) -> Double
}

///|
/// Trait for composable transforms: compose(self, other) applies self after other.
/// 可组合变换 trait：compose(self, other) 先应用 other 再应用 self。
pub(open) trait Composable {
  fn compose(self : Self, other : Self) -> Self
}
