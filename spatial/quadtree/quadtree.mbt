///|
/// Quadtree node (PR quadtree). / 四叉树节点。
pub struct QuadNode {
  cx : Double
  cy : Double
  half : Double
  point : @core.Point2D
  has_point : Bool
  index : Int32
  mut nw : Int32
  mut ne : Int32
  mut sw : Int32
  mut se : Int32
} derive(Debug)

///|
pub extend QuadNode with @moonbitlang/core/debug.Debug::{to_repr}

///|
fn quad_insert(
  nodes : Array[QuadNode],
  node_idx : Int32,
  p : @core.Point2D,
  idx : Int32,
) -> Unit {
  let node = nodes[node_idx]
  if node.has_point {
    let existing = node.point
    if @core.approx_eq(existing.x(), p.x(), 0.000000000001) &&
      @core.approx_eq(existing.y(), p.y(), 0.000000000001) {
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

///|
fn quad_ensure_child(
  nodes : Array[QuadNode],
  cx : Double,
  cy : Double,
  half : Double,
) -> Int32 {
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

///|
fn quad_insert_into_child(
  nodes : Array[QuadNode],
  node_idx : Int32,
  p : @core.Point2D,
  idx : Int32,
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
