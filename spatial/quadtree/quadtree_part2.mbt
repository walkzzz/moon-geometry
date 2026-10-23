///|
/// Build a quadtree from points within a bounding region. / 构建四叉树。
pub fn build_quadtree(
  points : Array[@core.Point2D],
  bounds : @core.Rectangle,
) -> Array[QuadNode] {
  let cx = (bounds.min_x + bounds.max_x) / 2.0
  let cy = (bounds.min_y + bounds.max_y) / 2.0
  let half = if bounds.max_x - bounds.min_x > bounds.max_y - bounds.min_y {
    (bounds.max_x - bounds.min_x) / 2.0
  } else {
    (bounds.max_y - bounds.min_y) / 2.0
  }
  let nodes : Array[QuadNode] = []
  nodes.push({
    cx,
    cy,
    half,
    point: @core.Point2D::new(0.0, 0.0),
    has_point: false,
    index: -1,
    nw: -1,
    ne: -1,
    sw: -1,
    se: -1,
  })
  for i in 0..<points.length() {
    quad_insert(nodes, 0, points[i], i)
  }
  nodes
}

fn quad_range_rec(
  nodes : Array[QuadNode],
  node_idx : Int,
  rect : @core.Rectangle,
  result : Array[Int],
) -> Unit {
  if node_idx < 0 || node_idx >= nodes.length() {
    return
  }
  let node = nodes[node_idx]
  let min_nx = node.cx - node.half
  let max_nx = node.cx + node.half
  let min_ny = node.cy - node.half
  let max_ny = node.cy + node.half
  if min_nx > rect.max_x || max_nx < rect.min_x || min_ny > rect.max_y || max_ny < rect.min_y {
    return
  }
  if node.has_point {
    let px = node.point.x()
    let py = node.point.y()
    if px >= rect.min_x && px <= rect.max_x && py >= rect.min_y && py <= rect.max_y {
      result.push(node.index)
    }
  }
  quad_range_rec(nodes, node.nw, rect, result)
  quad_range_rec(nodes, node.ne, rect, result)
  quad_range_rec(nodes, node.sw, rect, result)
  quad_range_rec(nodes, node.se, rect, result)
}
