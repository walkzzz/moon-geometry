///|
/// Compute the total length of a path. / 计算路径总长度。
pub fn path_length(path : Array[@core.Point2D]) -> Double {
  let mut sum = 0.0
  for i in 1..<path.length() {
    sum += path[i - 1].dist(path[i])
  }
  sum
}

///|
/// Reduce path to key points by removing collinear points. / 通过移除共线点将路径简化为关键点。
pub fn simplify_path(
  path : Array[@core.Point2D],
  eps : Double,
) -> Array[@core.Point2D] {
  let n = path.length()
  if n <= 2 {
    return path
  }
  let result : Array[@core.Point2D] = [path[0]]
  for i in 1..<(n - 1) {
    let prev = path[i - 1]
    let cur = path[i]
    let next = path[i + 1]
    let area = ((cur.x() - prev.x()) * (next.y() - prev.y()) -
    (cur.y() - prev.y()) * (next.x() - prev.x())).abs()
    if area > eps {
      result.push(cur)
    }
  }
  result.push(path[n - 1])
  result
}
