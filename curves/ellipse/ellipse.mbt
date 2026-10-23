///|
/// Ellipse defined by center, semi-major axis a, semi-minor axis b,
/// and rotation angle (radians) of the major axis.
///
/// 椭圆：由中心、半长轴 a、半短轴 b、长轴旋转角度（弧度）定义。
pub struct Ellipse {
  center : @core.Point2D
  a : Double
  b : Double
  angle : Double
} derive(Debug)


///|
pub extend Ellipse with @moonbitlang/core/debug.Debug::{to_repr}


///|
pub extend Ellipse with @core.Measurable::{area}


///|
pub extend Ellipse with @core.PerimeterMeasurable::{perimeter}


///|
pub extend Ellipse with @core.Containable::{contains}


///|
/// Construct an ellipse. / 构造椭圆。
pub fn Ellipse::new(
  center : @core.Point2D,
  a : Double,
  b : Double,
  angle : Double,
) -> Ellipse {
  { center, a, b, angle, }
}
