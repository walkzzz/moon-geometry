///|
/// Quadtree node (PR quadtree). / 四叉树节点。
pub struct QuadNode {
  cx : Double
  cy : Double
  half : Double
  point : @core.Point2D
  has_point : Bool
  index : Int
  mut nw : Int
  mut ne : Int
  mut sw : Int
  mut se : Int
} derive(Debug)

pub extend QuadNode with @moonbitlang/core/debug.Debug::{to_repr}

fn quad_insert(
  nodes : Array[QuadNode],
  node_idx : Int,
  p : @core.Point2D,
  idx : Int,
) -> Unit {
  let node = nodes[node_idx]
  if node.has_point {
    let existing = node.point
    if @core.approx_eq(existing.x(), p.x(), 0.000000000001) && @core.approx_eq(
      existing.y(),
      p.y(),
      0.000000000001,
    ) {
      return
    }
    let existing_idx = node.index
    nodes[node_idx] = {
      cx: node.cx,
      cy: node.cy,
      half: node.half,
      point: @core.Point2D::new(0.0, 0.0),
      has_point: false,
      index: -1,
      nw: node.nw,
      ne: node.ne,
      sw: node.sw,
      se: node.se,
    }
    let h = node.half / 2.0
    nodes[node_idx].nw = quad_ensure_child(nodes, node.cx - h, node.cy + h, h)
    nodes[node_idx].ne = quad_ensure_child(nodes, node.cx + h, node.cy + h, h)
    nodes[node_idx].sw = quad_ensure_child(nodes, node.cx - h, node.cy - h, h)
    nodes[node_idx].se = quad_ensure_child(nodes, node.cx + h, node.cy - h, h)
    quad_insert_into_child(nodes, node_idx, existing, existing_idx)
    quad_insert_into_child(nodes, node_idx, p, idx)
  } else if node.nw >= 0 {
    quad_insert_into_child(nodes, node_idx, p, idx)
  } else {
    nodes[node_idx] = {
      cx: node.cx,
      cy: node.cy,
      half: node.half,
      point: p,
      has_point: true,
      index: idx,
      nw: node.nw,
      ne: node.ne,
      sw: node.sw,
      se: node.se,
    }
  }
}

fn quad_ensure_child(
  nodes : Array[QuadNode],
  cx : Double,
  cy : Double,
  half : Double,
) -> Int {
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
  nodes.length() - 1
}

fn quad_insert_into_child(
  nodes : Array[QuadNode],
  node_idx : Int,
  p : @core.Point2D,
  idx : Int,
) -> Unit {
  let node = nodes[node_idx]
  let child = if p.x() < node.cx {
    if p.y() >= node.cy {
      node.nw
    } else {
      node.sw
    }
  } else if p.y() >= node.cy {
    node.ne
  } else {
    node.se
  }
  if child >= 0 {
    quad_insert(nodes, child, p, idx)
  }
}

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

///|
/// Range query in quadtree. / 四叉树范围查询。
pub fn quadtree_range_query(
  nodes : Array[QuadNode],
  rect : @core.Rectangle,
) -> Array[Int] {
  let result : Array[Int] = []
  if nodes.length() == 0 {
    return result
  }
  quad_range_rec(nodes, 0, rect, result)
  result
}

///|
/// Count points in the quadtree. / 统计四叉树中的点数。
pub fn quadtree_count(nodes : Array[QuadNode]) -> Int {
  let mut count = 0
  for i in 0..<nodes.length() {
    if nodes[i].has_point {
      count += 1
    }
  }
  count
}