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
