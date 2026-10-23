///|
/// Half-plane: a*x + b*y + c <= 0. / 半平面。
pub struct HalfPlane {
  a : Double
  b : Double
  c : Double
} derive(Debug)

pub extend HalfPlane with @moonbitlang/core/debug.Debug::{to_repr}


///|
/// Construct a half-plane a*x + b*y + c <= 0. / 构造半平面。
pub fn HalfPlane::new(a : Double, b : Double, c : Double) -> HalfPlane {
  { a, b, c }
}


///|
/// Construct from a line, keeping the left side. / 从直线构造，保留左侧。
pub fn HalfPlane::from_line_left(line : @core.Line) -> HalfPlane {
  { a: line.a, b: line.b, c: line.c }
}


///|
/// Construct from a line, keeping the right side. / 从直线构造，保留右侧。
pub fn HalfPlane::from_line_right(line : @core.Line) -> HalfPlane {
  { a: -line.a, b: -line.b, c: -line.c }
}
