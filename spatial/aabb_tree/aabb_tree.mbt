///|
/// AABB tree node. / AABB 树节点。
pub struct AABBNode {
  bounds : @core.Rectangle
  left : Int32
  right : Int32
  index : Int32
} derive(Debug)

///|
pub extend AABBNode with @moonbitlang/core/debug.Debug::{to_repr}

///|
fn compute_bounds(
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
fn build_recursive(
  rects : Array[@core.Rectangle],
  indices : Array[Int32],
  nodes : Array[AABBNode],
) -> Int32 {
  let bounds = compute_bounds(rects, indices)
  if indices.length() == 1 {
    nodes.push({ bounds, left: -1, right: -1, index: indices[0], })
    return nodes.length() - 1
  }
  let split_x = bounds.max_x - bounds.min_x >= bounds.max_y - bounds.min_y
  let mid_val = if split_x {
    (bounds.min_x + bounds.max_x) / 2.0
  } else {
    (bounds.min_y + bounds.max_y) / 2.0
  }
  let left_indices : Array[Int32] = []
  let right_indices : Array[Int32] = []
  for i in 0..<indices.length() {
    let idx = indices[i]
    let r = rects[idx]
    let centroid = if split_x {
      (r.min_x + r.max_x) / 2.0
    } else {
      (r.min_y + r.max_y) / 2.0
    }
    if centroid < mid_val {
      left_indices.push(idx)
    } else {
      right_indices.push(idx)
    }
  }
  if left_indices.length() == 0 {
    let mid = right_indices.length() / 2
    for i in 0..<mid {
      left_indices.push(right_indices[i])
    }
    let new_right : Array[Int32] = []
    for i in mid..<right_indices.length() {
      new_right.push(right_indices[i])
    }
    right_indices.clear()
    for i in 0..<new_right.length() {
      right_indices.push(new_right[i])
    }
  }
  if right_indices.length() == 0 {
    let mid = left_indices.length() / 2
    for i in mid..<left_indices.length() {
      right_indices.push(left_indices[i])
    }
    let new_left : Array[Int32] = []
    for i in 0..<mid {
      new_left.push(left_indices[i])
    }
    left_indices.clear()
    for i in 0..<new_left.length() {
      left_indices.push(new_left[i])
    }
  }
  let left_idx = build_recursive(rects, left_indices, nodes)
  let right_idx = build_recursive(rects, right_indices, nodes)
  nodes.push({ bounds, left: left_idx, right: right_idx, index: -1, })
  nodes.length() - 1
}

///|
/// Build an AABB tree from an array of rectangles. / 由矩形数组构建 AABB 树。
pub fn build_aabb_tree(rects : Array[@core.Rectangle]) -> Array[AABBNode] {
  if rects.length() == 0 {
    return []
  }
  let nodes : Array[AABBNode] = []
  let indices : Array[Int32] = []
  for i in 0..<rects.length() {
    indices.push(i)
  }
  ignore(build_recursive(rects, indices, nodes))
  nodes
}

///|
fn rects_overlap(a : @core.Rectangle, b : @core.Rectangle) -> Bool {
  a.min_x <= b.max_x &&
  a.max_x >= b.min_x &&
  a.min_y <= b.max_y &&
  a.max_y >= b.min_y
}

///|
fn rect_contains_point(r : @core.Rectangle, p : @core.Point2D) -> Bool {
  p.x() >= r.min_x && p.x() <= r.max_x && p.y() >= r.min_y && p.y() <= r.max_y
}

///|
fn query_recursive(
  nodes : Array[AABBNode],
  node_idx : Int32,
  query : @core.Rectangle,
  result : Array[Int32],
) -> Unit {
  if node_idx < 0 || node_idx >= nodes.length() {
    return
  }
  let node = nodes[node_idx]
  if !rects_overlap(node.bounds, query) {
    return
  }
  if node.index >= 0 {
    result.push(node.index)
    return
  }
  query_recursive(nodes, node.left, query, result)
  query_recursive(nodes, node.right, query, result)
}

///|
/// Query all rectangle indices overlapping the query rectangle. / 查询所有与查询矩形重叠的矩形索引。
pub fn query_aabb(
  nodes : Array[AABBNode],
  query : @core.Rectangle,
) -> Array[Int32] {
  let result : Array[Int32] = []
  if nodes.length() == 0 {
    return result
  }
  query_recursive(nodes, nodes.length() - 1, query, result)
  result
}

///|
fn query_point_recursive(
  nodes : Array[AABBNode],
  node_idx : Int32,
  p : @core.Point2D,
  result : Array[Int32],
) -> Unit {
  if node_idx < 0 || node_idx >= nodes.length() {
    return
  }
  let node = nodes[node_idx]
  if !rect_contains_point(node.bounds, p) {
    return
  }
  if node.index >= 0 {
    result.push(node.index)
    return
  }
  query_point_recursive(nodes, node.left, p, result)
  query_point_recursive(nodes, node.right, p, result)
}

///|
/// Query all rectangle indices containing the point. / 查询所有包含点的矩形索引。
pub fn query_point_aabb(
  nodes : Array[AABBNode],
  p : @core.Point2D,
) -> Array[Int32] {
  let result : Array[Int32] = []
  if nodes.length() == 0 {
    return result
  }
  query_point_recursive(nodes, nodes.length() - 1, p, result)
  result
}

///|
/// Count leaf nodes in the tree. / 统计树中叶子节点数。
pub fn count_leaves(nodes : Array[AABBNode]) -> Int32 {
  let mut count = 0
  for i in 0..<nodes.length() {
    if nodes[i].index >= 0 {
      count += 1
    }
  }
  count
}
