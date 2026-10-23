///|
/// 2D range tree (sorted by x and y). / 二维范围树。
pub struct RangeTree {
  points : Array[@core.Point2D]
  sorted_x : Array[Int32]
  sorted_y : Array[Int32]
} derive(Debug)

///|
pub extend RangeTree with @moonbitlang/core/debug.Debug::{to_repr}

///|
/// Build a range tree from points. / 构建范围树。
pub fn build_range_tree(points : Array[@core.Point2D]) -> RangeTree {
  let n = points.length()
  let sorted_x : Array[Int32] = []
  let sorted_y : Array[Int32] = []
  for i in 0..<n {
    sorted_x.push(i)
    sorted_y.push(i)
  }
  sorted_x.sort_by(fn(a, b) {
    if points[a].x() < points[b].x() {
      -1
    } else if points[a].x() > points[b].x() {
      1
    } else {
      0
    }
  })
  sorted_y.sort_by(fn(a, b) {
    if points[a].y() < points[b].y() {
      -1
    } else if points[a].y() > points[b].y() {
      1
    } else {
      0
    }
  })
  { points, sorted_x, sorted_y, }
}
