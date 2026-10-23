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
pub fn ray_polygon_intersect(r : Ray, poly : @core.Polygon) -> Array[@core.Point2D] {
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
