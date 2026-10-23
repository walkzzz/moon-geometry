///|
/// Sort medial balls by radius descending (most significant first).
/// 按半径降序排列中轴球（最重要的在前）。
pub fn medial_axis_sort(balls : Array[MedialBall3D]) -> Array[MedialBall3D] {
  let result : Array[MedialBall3D] = []
  for b in balls {
    result.push(b)
  }
  result.sort_by(fn(b1, b2) {
    if b2.radius > b1.radius { 1 } else if b2.radius < b1.radius { -1 } else { 0 }
  })
  result
}