///|
/// Generate points along a Hermite spline. / 沿 Hermite 样条生成点。
pub fn hermite_points(
  points : Array[@core.Point2D],
  tangents : Array[@core.Point2D],
  num_segments : Int32,
) -> Array[@core.Point2D] {
  let n = points.length()
  if n < 2 || tangents.length() < n {
    return []
  }
  let result : Array[@core.Point2D] = []
  for i in 0..<(n - 1) {
    for j in 0..<num_segments {
      let t = j.to_double() / num_segments.to_double()
      result.push(
        hermite_eval(points[i], points[i + 1], tangents[i], tangents[i + 1], t),
      )
    }
  }
  result.push(points[n - 1])
  result
}
