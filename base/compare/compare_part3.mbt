///|
/// Lexicographic comparison of two points. Returns -1, 0, or 1. / 点的字典序比较。
pub fn compare_points(a : @core.Point2D, b : @core.Point2D) -> Int {
  if a.x() < b.x() {
    -1
  } else if a.x() > b.x() {
    1
  } else if a.y() < b.y() {
    -1
  } else if a.y() > b.y() {
    1
  } else {
    0
  }
}


///|
/// Compare two segments by start point lexicographically. / 按起点字典序比较线段。
pub fn compare_segments(s1 : @core.Segment, s2 : @core.Segment) -> Int {
  let c = compare_points(s1.start, s2.start)
  if c != 0 {
    return c
  }
  compare_points(s1.end, s2.end)
}
