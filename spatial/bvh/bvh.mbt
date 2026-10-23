///|
/// BVH node (median split). / BVH 节点（中位数分割）。
pub struct BVHNode {
  bounds : @core.Rectangle
  left : Int
  right : Int
  index : Int
} derive(Debug)

pub extend BVHNode with @moonbitlang/core/debug.Debug::{to_repr}

fn bvh_bounds(
  rects : Array[@core.Rectangle],
  indices : Array[Int],
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

fn bvh_build_rec(
  rects : Array[@core.Rectangle],
  indices : Array[Int],
  nodes : Array[BVHNode],
) -> Int {
  let bounds = bvh_bounds(rects, indices)
  if indices.length() == 1 {
    nodes.push({ bounds, left: -1, right: -1, index: indices[0] })
    return nodes.length() - 1
  }
  let split_x = bounds.max_x - bounds.min_x >= bounds.max_y - bounds.min_y
  let sorted : Array[Int] = []
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
  let left_indices : Array[Int] = []
  let right_indices : Array[Int] = []
  for i in 0..<mid {
    left_indices.push(sorted[i])
  }
  for i in mid..<sorted.length() {
    right_indices.push(sorted[i])
  }
  let left_idx = bvh_build_rec(rects, left_indices, nodes)
  let right_idx = bvh_build_rec(rects, right_indices, nodes)
  nodes.push({ bounds, left: left_idx, right: right_idx, index: -1 })
  nodes.length() - 1
}
