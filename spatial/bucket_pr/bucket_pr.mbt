///|
/// Bucket PR k-d tree node. / 桶 PR k-d 树节点。
pub struct BucketPRNode {
  is_leaf : Bool
  bucket : Array[Int32]
  axis : Int32
  split_val : Double
  left : Int32
  right : Int32
} derive(Debug)

///|
pub extend BucketPRNode with @moonbitlang/core/debug.Debug::{to_repr}

///|
fn bucket_pr_build_rec(
  points : Array[@core.Point2D],
  indices : Array[Int32],
  axis : Int32,
  bucket_size : Int32,
  nodes : Array[BucketPRNode],
) -> Int32 {
  if indices.length() <= bucket_size {
    nodes.push({
      is_leaf: true,
      bucket: indices,
      axis,
      split_val: 0.0,
      left: -1,
      right: -1,
    })
    return nodes.length() - 1
  }
  let sorted : Array[Int32] = []
  for i in 0..<indices.length() {
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
  let mid = sorted.length() / 2
  let split_val = if axis == 0 {
    points[sorted[mid]].x()
  } else {
    points[sorted[mid]].y()
  }
  let left_indices : Array[Int32] = []
  let right_indices : Array[Int32] = []
  for i in 0..<mid {
    left_indices.push(sorted[i])
  }
  for i in mid..<sorted.length() {
    right_indices.push(sorted[i])
  }
  let left_idx = bucket_pr_build_rec(
    points,
    left_indices,
    1 - axis,
    bucket_size,
    nodes,
  )
  let right_idx = bucket_pr_build_rec(
    points,
    right_indices,
    1 - axis,
    bucket_size,
    nodes,
  )
  nodes.push({
    is_leaf: false,
    bucket: [],
    axis,
    split_val,
    left: left_idx,
    right: right_idx,
  })
  nodes.length() - 1
}
