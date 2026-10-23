///|
/// Minkowski sum of two convex polygons.
/// Returns the result as an array of points (CCW).
/// Both inputs must be convex. / 两个凸多边形的 Minkowski 和，返回 CCW 点数组。输入必须为凸。
pub fn minkowski_sum_convex(
  poly1 : @core.Polygon,
  poly2 : @core.Polygon,
) -> Array[@core.Point2D] {
  let n1 = poly1.size()
  let n2 = poly2.size()
  if n1 == 0 || n2 == 0 {
    return []
  }
  let pts1 = ensure_ccw(poly1)
  let pts2 = ensure_ccw(poly2)
  let start1 = bottom_left_index(pts1)
  let start2 = bottom_left_index(pts2)
  let result : Array[@core.Point2D] = []
  let start = @core.Point2D::new(
    pts1[start1].x() + pts2[start2].x(),
    pts1[start1].y() + pts2[start2].y(),
  )
  result.push(start)
  let mut i = 0
  let mut j = 0
  let mut count = 0
  let total = n1 + n2
  while count < total - 1 {
    let idx1 = (start1 + i) % n1
    let idx2 = (start2 + j) % n2
    let a1 = edge_angle(pts1, idx1)
    let a2 = edge_angle(pts2, idx2)
    let (dx, dy) = if j >= n2 || (i < n1 && a1 <= a2) {
      let ddx = pts1[(idx1 + 1) % n1].x() - pts1[idx1].x()
      let ddy = pts1[(idx1 + 1) % n1].y() - pts1[idx1].y()
      i += 1
      (ddx, ddy)
    } else {
      let ddx = pts2[(idx2 + 1) % n2].x() - pts2[idx2].x()
      let ddy = pts2[(idx2 + 1) % n2].y() - pts2[idx2].y()
      j += 1
      (ddx, ddy)
    }
    let last = result[result.length() - 1]
    result.push(@core.Point2D::new(last.x() + dx, last.y() + dy))
    count += 1
  }
  if result.length() > 1 {
    ignore(result.remove(result.length() - 1))
  }
  remove_collinear(result)
}
