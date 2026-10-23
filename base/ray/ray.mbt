///|
/// Ray type: origin + direction. / 射线类型：起点 + 方向。
pub struct Ray {
  origin : @core.Point2D
  dir : @core.Point2D
} derive(Debug)

///|
pub extend Ray with @moonbitlang/core/debug.Debug::{to_repr}

///|
/// Construct a ray from origin and direction. / 由起点和方向构造射线。
pub fn Ray::new(origin : @core.Point2D, dir : @core.Point2D) -> Ray {
  { origin, dir, }
}

///|
/// Construct a ray from two points (origin through target). / 由两点构造射线。
pub fn Ray::from_points(origin : @core.Point2D, through : @core.Point2D) -> Ray {
  {
    origin,
    dir: @core.Point2D::new(through.x() - origin.x(), through.y() - origin.y()),
  }
}

///|
/// Evaluate ray at parameter t (t >= 0). / 计算射线上参数 t 处的点。
pub fn Ray::eval(r : Ray, t : Double) -> @core.Point2D {
  @core.Point2D::new(r.origin.x() + r.dir.x() * t, r.origin.y() + r.dir.y() * t)
}

///|
/// Ray-segment intersection. Returns parameter t >= 0 or None. / 射线与线段交点。
pub fn ray_segment_intersect(r : Ray, seg : @core.Segment) -> @core.Point2D? {
  let x1 = r.origin.x()
  let y1 = r.origin.y()
  let x2 = r.origin.x() + r.dir.x()
  let y2 = r.origin.y() + r.dir.y()
  let x3 = seg.start.x()
  let y3 = seg.start.y()
  let x4 = seg.end.x()
  let y4 = seg.end.y()
  let denom = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4)
  if @core.approx_eq(denom, 0.0, 0.000000000001) {
    return None
  }
  let t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / denom
  let u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / denom
  if t >= 0.0 && u >= 0.0 && u <= 1.0 {
    Some(Ray::eval(r, t))
  } else {
    None
  }
}

///|
/// Ray-line intersection. Returns parameter t >= 0 or None. / 射线与直线交点。
pub fn ray_line_intersect(r : Ray, line : @core.Line) -> @core.Point2D? {
  let a = line.a
  let b = line.b
  let c = line.c
  let denom = a * r.dir.x() + b * r.dir.y()
  if @core.approx_eq(denom, 0.0, 0.000000000001) {
    return None
  }
  let t = -(a * r.origin.x() + b * r.origin.y() + c) / denom
  if t >= 0.0 {
    Some(Ray::eval(r, t))
  } else {
    None
  }
}

///|
/// Ray-polygon boundary intersections. / 射线与多边形边界交点。
pub fn ray_polygon_intersect(
  r : Ray,
  poly : @core.Polygon,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  let n = poly.vertices.length()
  for i in 0..<n {
    let start = poly.vertices[i]
    let end = poly.vertices[(i + 1) % n]
    let seg = @core.Segment::new(start, end)
    match ray_segment_intersect(r, seg) {
      Some(p) => result.push(p)
      None => ()
    }
  }
  result
}

///|
/// Check if ray origin is inside polygon (odd crossing count). / 检查射线起点是否在多边形内。
pub fn ray_polygon_contains(r : Ray, poly : @core.Polygon) -> Bool {
  let n = poly.vertices.length()
  let mut inside = false
  let px = r.origin.x()
  let py = r.origin.y()
  for i in 0..<n {
    let j = (i + n - 1) % n
    let xi = poly.vertices[i].x()
    let yi = poly.vertices[i].y()
    let xj = poly.vertices[j].x()
    let yj = poly.vertices[j].y()
    if (yi > py) != (yj > py) {
      let x_cross = (xj - xi) * (py - yi) / (yj - yi) + xi
      if px < x_cross {
        inside = !inside
      }
    }
  }
  inside
}
