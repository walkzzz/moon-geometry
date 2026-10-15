///|
/// A line segment defined by two endpoints.
pub struct Segment {
  start : Point2D
  end : Point2D
} derive(Debug)

///|
/// Construct a segment.
pub fn Segment::new(start : Point2D, end : Point2D) -> Segment {
  { start, end, }
}

///|
/// Length of the segment.
pub fn Segment::length(self : Segment) -> Double {
  self.start.dist(self.end)
}

///|
/// Direction vector of the segment (end - start).
pub fn Segment::direction(self : Segment) -> Point2D {
  self.end.sub(self.start)
}

///|
/// Midpoint of the segment.
pub fn Segment::midpoint(self : Segment) -> Point2D {
  Point2D::new(
    (self.start.x + self.end.x) / 2.0,
    (self.start.y + self.end.y) / 2.0,
  )
}

///|
/// A line in general form: a*x + b*y + c = 0.
pub struct Line {
  a : Double
  b : Double
  c : Double
} derive(Debug)

///|
/// Construct a line from general form coefficients.
pub fn Line::new(a : Double, b : Double, c : Double) -> Line {
  { a, b, c, }
}

///|
/// Construct a line from two distinct points.
pub fn Line::from_points(p1 : Point2D, p2 : Point2D) -> Line {
  // a = y1 - y2, b = x2 - x1, c = x1*y2 - x2*y1
  { a: p1.y - p2.y, b: p2.x - p1.x, c: p1.x * p2.y - p2.x * p1.y, }
}

///|
/// Perpendicular distance from a point to the line.
pub fn Line::point_distance(self : Line, p : Point2D) -> Double {
  let denom = (self.a * self.a + self.b * self.b).sqrt()
  if denom == 0.0 {
    0.0
  } else {
    (self.a * p.x + self.b * p.y + self.c).abs() / denom
  }
}

///|
/// Evaluate the line equation at a point (sign indicates side).
pub fn Line::evaluate(self : Line, p : Point2D) -> Double {
  self.a * p.x + self.b * p.y + self.c
}

///|
pub extend Segment with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend Line with @moonbitlang/core/debug.Debug::{to_repr}
