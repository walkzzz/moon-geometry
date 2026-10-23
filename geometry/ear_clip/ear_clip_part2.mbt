///|
/// Find an ear vertex index. / 找到一个耳顶点索引。
pub fn find_ear(
  poly : Array[@core.Point2D],
  indices : Array[Int],
) -> Int? {
  let n = indices.length()
  if n < 3 {
    return None
  }
  for i in 0..<n {
    if is_ear(poly, indices, i) {
      return Some(i)
    }
  }
  None
}
