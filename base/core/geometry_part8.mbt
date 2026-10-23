///|
/// Trait for parametric 2D curves with eval, derivative, and arc length.
/// 参数化 2D 曲线 trait，提供求值、导数和弧长。
pub(open) trait Curve2D {
  eval(self : Self, t : Double) -> Point2D
  derivative(self : Self, t : Double) -> Point2D
  length(self : Self) -> Double
}

///|
/// Trait for measurable 2D shapes with area.
/// 可度量 2D 形状 trait，提供面积计算。
pub(open) trait Measurable {
  area(self : Self) -> Double
}


///|
/// Trait for shapes with a perimeter (boundary length).
/// 有周长（边界长度）的形状 trait。
pub(open) trait PerimeterMeasurable {
  perimeter(self : Self) -> Double
}
