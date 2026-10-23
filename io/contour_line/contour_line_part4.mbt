///|
/// Extract multiple contour levels. / 提取多个等值层。
pub fn extract_contours(
  g : ContourGrid,
  levels : Array[Double],
) -> Array[(Double, Array[ContourSegment])] {
  let result : Array[(Double, Array[ContourSegment])] = []
  for level in levels {
    let segs = marching_squares(g, level)
    result.push((level, segs))
  }
  result
}
