///|
/// Clip a point array by a line, keeping the left side. / 用直线裁剪点数组。
pub fn clip_points_by_line(
  points : Array[@core.Point2D],
  line : @core.Line,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for i in 0..<points.length() {
    if line.a * points[i].x() + line.b * points[i].y() + line.c <= 0.0 {
      result.push(points[i])
    }
  }
  result
}

///|
/// Area of a convex polygon given as vertex array. / 凸多边形面积。
pub fn convex_area(vertices : Array[@core.Point2D]) -> Double {
  let n = vertices.length()
  if n < 3 {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    sum += vertices[i].x() * vertices[j].y() - vertices[j].x() * vertices[i].y()
  }
  sum.abs() / 2.0
}
