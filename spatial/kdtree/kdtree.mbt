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

///|
/// Build a k-d tree from points. / 由点集构建 k-d 树。
pub fn build_kdtree(points : Array[@core.Point2D]) -> Array[KDNode] {
  if points.length() == 0 {
    return []
  }
  let nodes : Array[KDNode] = []
  let indices : Array[Int32] = []
  for i in 0..<points.length() {
    indices.push(i)
  }
  ignore(kdtree_build_rec(points, indices, 0, nodes))
  nodes
}

///|
fn kdtree_nearest_rec(
  nodes : Array[KDNode],
  node_idx : Int32,
  query : @core.Point2D,
  best : Array[(Int32, Double)],
) -> Unit {
  if node_idx < 0 || node_idx >= nodes.length() {
    return
  }
  let node = nodes[node_idx]
  let dx = node.point.x() - query.x()
  let dy = node.point.y() - query.y()
  let dist = (dx * dx + dy * dy).sqrt()
  let (_, cur_dist) = best[0]
  if cur_dist > dist {
    best[0] = (node.index, dist)
  }
  let diff = if node.axis == 0 {
    query.x() - node.point.x()
  } else {
    query.y() - node.point.y()
  }
  let (near, far) = if diff < 0.0 {
    (node.left, node.right)
  } else {
    (node.right, node.left)
  }
  kdtree_nearest_rec(nodes, near, query, best)
  let (_, cur_dist2) = best[0]
  if diff.abs() < cur_dist2 {
    kdtree_nearest_rec(nodes, far, query, best)
  }
}

///|
/// Find nearest neighbor. Returns (index, distance) or None. / 最近邻搜索。
pub fn kdtree_nearest(
  nodes : Array[KDNode],
  query : @core.Point2D,
) -> (Int32, Double)? {
  if nodes.length() == 0 {
    return None
  }
  let best : Array[(Int32, Double)] = [(-1, 999999999.0)]
  kdtree_nearest_rec(nodes, nodes.length() - 1, query, best)
  let (best_idx, _) = best[0]
  if best_idx >= 0 {
    Some(best[0])
  } else {
    None
  }
}

///|
fn kdtree_range_rec(
  nodes : Array[KDNode],
  node_idx : Int32,
  rect : @core.Rectangle,
  result : Array[Int32],
) -> Unit {
  if node_idx < 0 || node_idx >= nodes.length() {
    return
  }
  let node = nodes[node_idx]
  let px = node.point.x()
  let py = node.point.y()
  if px >= rect.min_x &&
    px <= rect.max_x &&
    py >= rect.min_y &&
    py <= rect.max_y {
    result.push(node.index)
  }
  kdtree_range_rec(nodes, node.left, rect, result)
  kdtree_range_rec(nodes, node.right, rect, result)
}

///|
/// Range query: find all point indices within a rectangle. / 范围查询。
pub fn kdtree_range_query(
  nodes : Array[KDNode],
  rect : @core.Rectangle,
) -> Array[Int32] {
  let result : Array[Int32] = []
  if nodes.length() == 0 {
    return result
  }
  kdtree_range_rec(nodes, nodes.length() - 1, rect, result)
  result
}
