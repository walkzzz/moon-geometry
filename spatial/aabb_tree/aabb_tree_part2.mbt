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
