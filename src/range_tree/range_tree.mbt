///|
/// 2D range tree (sorted by x and y). / 二维范围树。
pub struct RangeTree {
  points : Array[@core.Point2D]
  sorted_x : Array[Int]
  sorted_y : Array[Int]
} derive(Debug)

pub extend RangeTree with @moonbitlang/core/debug.Debug::{to_repr}

///|
/// Build a range tree from points. / 构建范围树。
pub fn build_range_tree(points : Array[@core.Point2D]) -> RangeTree {
  let n = points.length()
  let sorted_x : Array[Int] = []
  let sorted_y : Array[Int] = []
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
  { points, sorted_x, sorted_y }
}

///|
/// Orthogonal range query: find indices in [x_lo, x_hi] × [y_lo, y_hi]. / 正交范围查询。
pub fn range_query(
  tree : RangeTree,
  x_lo : Double,
  x_hi : Double,
  y_lo : Double,
  y_hi : Double,
) -> Array[Int] {
  let result : Array[Int] = []
  for i in 0..<tree.points.length() {
    let px = tree.points[i].x()
    let py = tree.points[i].y()
    if px >= x_lo && px <= x_hi && py >= y_lo && py <= y_hi {
      result.push(i)
    }
  }
  result
}

///|
/// Query by x-range only. / 仅按 x 范围查询。
pub fn range_query_x(
  tree : RangeTree,
  x_lo : Double,
  x_hi : Double,
) -> Array[Int] {
  let result : Array[Int] = []
  for i in 0..<tree.sorted_x.length() {
    let idx = tree.sorted_x[i]
    let px = tree.points[idx].x()
    if px > x_hi {
      return result
    }
    if px >= x_lo {
      result.push(idx)
    }
  }
  result
}

///|
/// Query by y-range only. / 仅按 y 范围查询。
pub fn range_query_y(
  tree : RangeTree,
  y_lo : Double,
  y_hi : Double,
) -> Array[Int] {
  let result : Array[Int] = []
  for i in 0..<tree.sorted_y.length() {
    let idx = tree.sorted_y[i]
    let py = tree.points[idx].y()
    if py > y_hi {
      return result
    }
    if py >= y_lo {
      result.push(idx)
    }
  }
  result
}

///|
/// Number of points in the tree. / 范围树中的点数。
pub fn range_tree_size(tree : RangeTree) -> Int {
  tree.points.length()
}