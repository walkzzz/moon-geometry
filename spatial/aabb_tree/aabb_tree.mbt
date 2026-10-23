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
