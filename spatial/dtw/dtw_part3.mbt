///|
/// DTW distance ratio (normalized by path length). / 归一化 DTW 距离。
pub fn dtw_normalized(
  c1 : Array[@core.Point2D],
  c2 : Array[@core.Point2D],
) -> Double {
  let n = c1.length()
  let m = c2.length()
  if n == 0 || m == 0 {
    return 0.0
  }
  dtw_distance(c1, c2) / (n + m).to_double()
}