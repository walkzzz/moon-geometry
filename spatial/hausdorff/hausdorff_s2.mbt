///|
/// Hausdorff distance between two point sets. / 两个点集的 Hausdorff 距离。
pub fn hausdorff_distance(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
) -> Double {
  let d1 = hausdorff_directed(a, b)
  let d2 = hausdorff_directed(b, a)
  if d1 > d2 {
    d1
  } else {
    d2
  }
}


///|
/// Hausdorff distance with early termination (epsilon check). / 带提前终止的 Hausdorff 距离。
pub fn hausdorff_within(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
  eps : Double,
) -> Bool {
  hausdorff_distance(a, b) <= eps
}
