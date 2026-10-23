///|
/// Remove collinear vertices from a polygon vertex array.
/// 移除多边形顶点数组中的共线顶点。
fn remove_collinear(pts : Array[@core.Point2D]) -> Array[@core.Point2D] {
  let n = pts.length()
  if n < 3 {
    return pts
  }
  let result : Array[@core.Point2D] = []
  for i in 0..<n {
    let prev = pts[(i - 1 + n) % n]
    let curr = pts[i]
    let next = pts[(i + 1) % n]
    let cross = @core.turn(prev, curr, next)
    if @core.approx_eq(cross, 0.0, 0.0000000001) {
      continue
    }
    result.push(curr)
  }
  result
}
