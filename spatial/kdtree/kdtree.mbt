///|
/// K-d tree node. / K-d 树节点。
pub struct KDNode {
  point : @core.Point2D
  left : Int32
  right : Int32
  axis : Int32
  index : Int32
} derive(Debug)

///|
pub extend KDNode with @moonbitlang/core/debug.Debug::{to_repr}

///|
fn kdtree_build_rec(
  points : Array[@core.Point2D],
  indices : Array[Int32],
  axis : Int32,
  nodes : Array[KDNode],
) -> Int32 {
  let n = indices.length()
  if n == 0 {
    return -1
  }
  if n == 1 {
    nodes.push({
      point: points[indices[0]],
      left: -1,
      right: -1,
      axis,
      index: indices[0],
    })
    return nodes.length() - 1
  }
  let sorted : Array[Int32] = []
  for i in 0..<n {
    sorted.push(indices[i])
  }
  sorted.sort_by(fn(a, b) {
    let va = if axis == 0 { points[a].x() } else { points[a].y() }
    let vb = if axis == 0 { points[b].x() } else { points[b].y() }
    if va < vb {
      -1
    } else if va > vb {
      1
    } else {
      0
    }
  })
  let mid = n / 2
  let left_indices : Array[Int32] = []
  let right_indices : Array[Int32] = []
  for i in 0..<mid {
    left_indices.push(sorted[i])
  }
  for i in (mid + 1)..<n {
    right_indices.push(sorted[i])
  }
  let left_idx = kdtree_build_rec(points, left_indices, 1 - axis, nodes)
  let right_idx = kdtree_build_rec(points, right_indices, 1 - axis, nodes)
  nodes.push({
    point: points[sorted[mid]],
    left: left_idx,
    right: right_idx,
    axis,
    index: sorted[mid],
  })
  nodes.length() - 1
}
