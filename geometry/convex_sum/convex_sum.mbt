///|
/// All pairwise sums of two point sets. / 两个点集的所有成对和。
pub fn point_set_sum(
  points1 : Array[@core.Point2D],
  points2 : Array[@core.Point2D],
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for i in 0..<points1.length() {
    for j in 0..<points2.length() {
      result.push(
        @core.Point2D::new(
          points1[i].x() + points2[j].x(),
          points1[i].y() + points2[j].y(),
        ),
      )
    }
  }
  result
}

///|
/// All pairwise differences of two point sets. / 两个点集的所有成对差。
pub fn point_set_difference(
  points1 : Array[@core.Point2D],
  points2 : Array[@core.Point2D],
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for i in 0..<points1.length() {
    for j in 0..<points2.length() {
      result.push(
        @core.Point2D::new(
          points1[i].x() - points2[j].x(),
          points1[i].y() - points2[j].y(),
        ),
      )
    }
  }
  result
}

///|
/// Scale a point set by a factor. / 缩放点集。
pub fn point_set_scale(
  points : Array[@core.Point2D],
  factor : Double,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for i in 0..<points.length() {
    result.push(
      @core.Point2D::new(points[i].x() * factor, points[i].y() * factor),
    )
  }
  result
}

///|
/// Translate a point set. / 平移点集。
pub fn point_set_translate(
  points : Array[@core.Point2D],
  dx : Double,
  dy : Double,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for i in 0..<points.length() {
    result.push(@core.Point2D::new(points[i].x() + dx, points[i].y() + dy))
  }
  result
}

///|
/// Centroid of a point set. / 点集质心。
pub fn point_set_centroid(points : Array[@core.Point2D]) -> @core.Point2D? {
  if points.length() == 0 {
    return None
  }
  let mut sx = 0.0
  let mut sy = 0.0
  for i in 0..<points.length() {
    sx += points[i].x()
    sy += points[i].y()
  }
  let n = points.length().to_double()
  Some(@core.Point2D::new(sx / n, sy / n))
}

///|
/// Check if two point sets are equal (same points, any order). / 检查两个点集是否相等。
pub fn point_set_equal(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
  eps : Double,
) -> Bool {
  if a.length() != b.length() {
    return false
  }
  let used : Array[Bool] = []
  for _ in 0..<b.length() {
    used.push(false)
  }
  for i in 0..<a.length() {
    let mut found = false
    for j in 0..<b.length() {
      if !used[j] {
        if @core.approx_eq(a[i].x(), b[j].x(), eps) &&
          @core.approx_eq(a[i].y(), b[j].y(), eps) {
          used[j] = true
          found = true
          break
        }
      }
    }
    if !found {
      return false
    }
  }
  true
}
