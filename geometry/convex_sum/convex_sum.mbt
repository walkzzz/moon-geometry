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
