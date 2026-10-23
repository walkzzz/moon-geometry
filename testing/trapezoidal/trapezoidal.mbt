///|
/// A trapezoid in the trapezoidal decomposition. / 梯形分解中的梯形。
pub struct Trapezoid {
  left : Double
  right : Double
  top : Int
  bottom : Int
  left_p : @core.Point2D?
  right_p : @core.Point2D?
}


///|
/// Trapezoidal map for point location queries. / 用于点定位查询的梯形图。
pub struct TrapezoidalMap {
  segments : Array[@core.Segment]
  trapezoids : Array[Trapezoid]
}
