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

///|
/// Check if a point is in the half-plane. / 检查点是否在半平面内。
pub fn HalfPlane::contains(hp : HalfPlane, p : @core.Point2D) -> Bool {
  hp.a * p.x() + hp.b * p.y() + hp.c <= 0.0
}

///|
/// Evaluate the signed value at a point. / 计算点处的有符号值。
pub fn HalfPlane::eval(hp : HalfPlane, p : @core.Point2D) -> Double {
  hp.a * p.x() + hp.b * p.y() + hp.c
}

///|
/// Intersection of multiple half-planes. Returns convex polygon vertices (CCW) or empty. / 半平面交。
pub fn half_plane_intersect(planes : Array[HalfPlane]) -> Array[@core.Point2D] {
  let big = 1000000.0
  let polygon : Array[@core.Point2D] = [
    @core.Point2D::new(-big, -big),
    @core.Point2D::new(big, -big),
    @core.Point2D::new(big, big),
    @core.Point2D::new(-big, big),
  ]
  let mut result = polygon
  for i in 0..<planes.length() {
    result = clip_by_half_plane(result, planes[i])
    if result.length() == 0 {
      return []
    }
  }
  result
}

fn clip_by_half_plane(
  poly : Array[@core.Point2D],
  hp : HalfPlane,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  let n = poly.length()
  if n == 0 {
    return result
  }
  for i in 0..<n {
    let cur = poly[i]
    let nxt = poly[(i + 1) % n]
    let cur_in = HalfPlane::contains(hp, cur)
    let nxt_in = HalfPlane::contains(hp, nxt)
    if cur_in {
      result.push(cur)
    }
    if cur_in != nxt_in {
      let dc = HalfPlane::eval(hp, cur)
      let dn = HalfPlane::eval(hp, nxt)
      let t = dc / (dc - dn)
      result.push(
        @core.Point2D::new(cur.x() + (nxt.x() - cur.x()) * t, cur.y() + (nxt.y() - cur.y()) * t),
      )
    }
  }
  result
}