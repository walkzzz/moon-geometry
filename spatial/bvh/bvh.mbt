///|
/// BVH node (median split). / BVH 节点（中位数分割）。
pub struct BVHNode {
  bounds : @core.Rectangle
  left : Int32
  right : Int32
  index : Int32
} derive(Debug)

///|
pub extend BVHNode with @moonbitlang/core/debug.Debug::{to_repr}

///|
fn bvh_bounds(
  rects : Array[@core.Rectangle],
  indices : Array[Int32],
) -> @core.Rectangle {
  let mut min_x = rects[indices[0]].min_x
  let mut min_y = rects[indices[0]].min_y
  let mut max_x = rects[indices[0]].max_x
  let mut max_y = rects[indices[0]].max_y
  for i in 1..<indices.length() {
    let r = rects[indices[i]]
    if r.min_x < min_x {
      min_x = r.min_x
    }
    if r.min_y < min_y {
      min_y = r.min_y
    }
    if r.max_x > max_x {
      max_x = r.max_x
    }
    if r.max_y > max_y {
      max_y = r.max_y
    }
  }
  @core.Rectangle::new(min_x, min_y, max_x, max_y)
}

///|
fn bvh_build_rec(
  rects : Array[@core.Rectangle],
  indices : Array[Int32],
  nodes : Array[BVHNode],
) -> Int32 {
  let bounds = bvh_bounds(rects, indices)
  if indices.length() == 1 {
    nodes.push({ bounds, left: -1, right: -1, index: indices[0], })
    return nodes.length() - 1
  }
  let split_x = bounds.max_x - bounds.min_x >= bounds.max_y - bounds.min_y
  let sorted : Array[Int32] = []
  for i in 0..<indices.length() {
    sorted.push(indices[i])
  }
  sorted.sort_by(fn(a, b) {
    let ca = if split_x {
      rects[a].min_x + rects[a].max_x
    } else {
      rects[a].min_y + rects[a].max_y
    }
    let cb = if split_x {
      rects[b].min_x + rects[b].max_x
    } else {
      rects[b].min_y + rects[b].max_y
    }
    if ca < cb {
      -1
    } else if ca > cb {
      1
    } else {
      0
    }
  })
  let mid = sorted.length() / 2
  let left_indices : Array[Int32] = []
  let right_indices : Array[Int32] = []
  for i in 0..<mid {
    left_indices.push(sorted[i])
  }
  for i in mid..<sorted.length() {
    right_indices.push(sorted[i])
  }
  let left_idx = bvh_build_rec(rects, left_indices, nodes)
  let right_idx = bvh_build_rec(rects, right_indices, nodes)
  nodes.push({ bounds, left: left_idx, right: right_idx, index: -1, })
  nodes.length() - 1
}

///|
/// Build a BVH from rectangles (median split). / 构建 BVH。
pub fn build_bvh(rects : Array[@core.Rectangle]) -> Array[BVHNode] {
  if rects.length() == 0 {
    return []
  }
  let nodes : Array[BVHNode] = []
  let indices : Array[Int32] = []
  for i in 0..<rects.length() {
    indices.push(i)
  }
  ignore(bvh_build_rec(rects, indices, nodes))
  nodes
}

///|
fn bvh_overlap(a : @core.Rectangle, b : @core.Rectangle) -> Bool {
  a.min_x <= b.max_x &&
  a.max_x >= b.min_x &&
  a.min_y <= b.max_y &&
  a.max_y >= b.min_y
}

///|
fn bvh_query_rec(
  nodes : Array[BVHNode],
  node_idx : Int32,
  rect : @core.Rectangle,
  result : Array[Int32],
) -> Unit {
  if node_idx < 0 || node_idx >= nodes.length() {
    return
  }
  let node = nodes[node_idx]
  if !bvh_overlap(node.bounds, rect) {
    return
  }
  if node.index >= 0 {
    result.push(node.index)
    return
  }
  bvh_query_rec(nodes, node.left, rect, result)
  bvh_query_rec(nodes, node.right, rect, result)
}

///|
/// Query overlapping rectangle indices. / 查询重叠矩形索引。
pub fn bvh_query(
  nodes : Array[BVHNode],
  rect : @core.Rectangle,
) -> Array[Int32] {
  let result : Array[Int32] = []
  if nodes.length() == 0 {
    return result
  }
  bvh_query_rec(nodes, nodes.length() - 1, rect, result)
  result
}

///|
fn bvh_point_rec(
  nodes : Array[BVHNode],
  node_idx : Int32,
  p : @core.Point2D,
  result : Array[Int32],
) -> Unit {
  if node_idx < 0 || node_idx >= nodes.length() {
    return
  }
  let node = nodes[node_idx]
  if p.x() < node.bounds.min_x ||
    p.x() > node.bounds.max_x ||
    p.y() < node.bounds.min_y ||
    p.y() > node.bounds.max_y {
    return
  }
  if node.index >= 0 {
    result.push(node.index)
    return
  }
  bvh_point_rec(nodes, node.left, p, result)
  bvh_point_rec(nodes, node.right, p, result)
}

///|
/// Query rectangle indices containing a point. / 查询包含点的矩形索引。
pub fn bvh_query_point(
  nodes : Array[BVHNode],
  p : @core.Point2D,
) -> Array[Int32] {
  let result : Array[Int32] = []
  if nodes.length() == 0 {
    return result
  }
  bvh_point_rec(nodes, nodes.length() - 1, p, result)
  result
}

///|
/// Count leaf nodes. / 统计叶子节点数。
pub fn bvh_count_leaves(nodes : Array[BVHNode]) -> Int32 {
  let mut count = 0
  for i in 0..<nodes.length() {
    if nodes[i].index >= 0 {
      count += 1
    }
  }
  count
}
