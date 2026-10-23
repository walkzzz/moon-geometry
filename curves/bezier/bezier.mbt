///|
/// Quadratic Bezier curve with 3 control points.
/// 二次贝塞尔曲线，3 个控制点。
pub struct Bezier2 {
  p0 : @core.Point2D
  p1 : @core.Point2D
  p2 : @core.Point2D
} derive(Debug)

///|
pub extend Bezier2 with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend Bezier2 with @core.Curve2D::{eval, derivative, length}

///|
pub extend Bezier2 with @core.Bounded2D::{bbox}

///|
pub extend Bezier2 with @core.Subdivisible::{subdivide}

///|
/// Cubic Bezier curve with 4 control points.
/// 三次贝塞尔曲线，4 个控制点。
pub struct Bezier3 {
  p0 : @core.Point2D
  p1 : @core.Point2D
  p2 : @core.Point2D
  p3 : @core.Point2D
} derive(Debug)

///|
pub extend Bezier3 with @moonbitlang/core/debug.Debug::{to_repr}
