///|
/// # Rounded Geometry
/// # 舍入几何
///
/// Geometry operations with controlled rounding precision.
/// 受控舍入精度的几何操作。

///|
pub fn round_double(x : Double, precision : Int32) -> Double {
  let factor = pow10(precision)
  (x * factor).round() / factor
}

///|
pub fn rounded_area(points : Array[@core.Point2D], precision : Int32) -> Double {
  let n = points.length()
  if n < 3 {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    sum += points[i].x() * points[j].y() - points[j].x() * points[i].y()
  }
  round_double(sum.abs() / 2.0, precision)
}

///|
pub fn rounded_length(
  a : @core.Point2D,
  b : @core.Point2D,
  precision : Int32,
) -> Double {
  let dx = b.x() - a.x()
  let dy = b.y() - a.y()
  round_double((dx * dx + dy * dy).sqrt(), precision)
}

///|
fn pow10(n : Int32) -> Double {
  let mut result = 1.0
  for _ in 0..<n {
    result *= 10.0
  }
  result
}
