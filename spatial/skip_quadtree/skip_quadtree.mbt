/// |
/// # Skip Quadtree
/// # 跳跃四叉树
///
/// Skip quadtree for dynamic spatial indexing with logarithmic operations.
/// 用于动态空间索引的对数操作跳跃四叉树。
///
/// ## Complexity: O(log n) insert/delete/query
/// ## 复杂度: 插入/删除/查询 O(log n)

///|
/// |
/// Skip quadtree node.
/// 跳跃四叉树节点。
pub struct SkipQuadNode {
  cx : Double
  cy : Double
  size : Double
  points : Array[@core.Point2D]
  mut children : Array[SkipQuadNode]?
  level : Int32
}

///|
/// |
/// Skip quadtree structure.
/// 跳跃四叉树结构。
pub struct SkipQuadtree {
  root : SkipQuadNode?
  max_level : Int32
}

///|
/// |
/// Create a new skip quadtree.
/// 创建新的跳跃四叉树。
pub fn skip_quadtree_new(
  cx : Double,
  cy : Double,
  size : Double,
  max_level : Int32,
) -> SkipQuadtree {
  let root : SkipQuadNode = {
    cx,
    cy,
    size,
    points: [],
    children: None,
    level: 0,
  }
  { root: Some(root), max_level: if max_level < 1 { 10 } else { max_level }, }
}

///|
/// |
/// Insert a point.
/// 插入点。
pub fn skip_quadtree_insert(tree : SkipQuadtree, p : @core.Point2D) -> Unit {
  match tree.root {
    Some(root) => skip_insert_impl(root, p, tree.max_level)
    None => ()
  }
}

///|
/// |
/// Range query.
/// 范围查询。
pub fn skip_quadtree_query(
  tree : SkipQuadtree,
  min_x : Double,
  min_y : Double,
  max_x : Double,
  max_y : Double,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  match tree.root {
    Some(root) => skip_query_impl(root, min_x, min_y, max_x, max_y, result)
    None => ()
  }
  result
}

///|
/// |
/// Count points.
/// 计算点数。
pub fn skip_quadtree_count(tree : SkipQuadtree) -> Int32 {
  match tree.root {
    Some(root) => skip_count(root)
    None => 0
  }
}

///|
fn skip_insert_impl(
  node : SkipQuadNode,
  p : @core.Point2D,
  max_level : Int32,
) -> Unit {
  if node.level >= max_level || node.points.length() < 4 {
    node.points.push(p)
    return
  }
  if node.children is None {
    skip_subdivide(node)
  }
  match node.children {
    Some(children) => {
      let idx = skip_child_index(node, p)
      skip_insert_impl(children[idx], p, max_level)
    }
    None => node.points.push(p)
  }
}

///|
fn skip_subdivide(node : SkipQuadNode) -> Unit {
  let half = node.size / 2.0
  let quarter = node.size / 4.0
  let children : Array[SkipQuadNode] = []
  for i in 0..<4 {
    let dx = if i % 2 == 0 { -quarter } else { quarter }
    let dy = if i / 2 == 0 { -quarter } else { quarter }
    children.push({
      cx: node.cx + dx,
      cy: node.cy + dy,
      size: half,
      points: [],
      children: None,
      level: node.level + 1,
    })
  }
  for i in 0..<node.points.length() {
    let p = node.points[i]
    let idx = skip_child_index(node, p)
    children[idx].points.push(p)
  }
  node.points.clear()
  node.children = Some(children)
}

///|
fn skip_child_index(node : SkipQuadNode, p : @core.Point2D) -> Int32 {
  let mut idx = 0
  if p.x() >= node.cx {
    idx += 1
  }
  if p.y() >= node.cy {
    idx += 2
  }
  idx
}

///|
fn skip_query_impl(
  node : SkipQuadNode,
  min_x : Double,
  min_y : Double,
  max_x : Double,
  max_y : Double,
  result : Array[@core.Point2D],
) -> Unit {
  let half = node.size / 2.0
  if node.cx + half < min_x ||
    node.cx - half > max_x ||
    node.cy + half < min_y ||
    node.cy - half > max_y {
    return
  }
  for i in 0..<node.points.length() {
    let p = node.points[i]
    if p.x() >= min_x && p.x() <= max_x && p.y() >= min_y && p.y() <= max_y {
      result.push(p)
    }
  }
  match node.children {
    Some(children) =>
      for i in 0..<children.length() {
        skip_query_impl(children[i], min_x, min_y, max_x, max_y, result)
      }
    None => ()
  }
}

///|
fn skip_count(node : SkipQuadNode) -> Int32 {
  let mut count = node.points.length()
  match node.children {
    Some(children) =>
      for i in 0..<children.length() {
        count += skip_count(children[i])
      }
    None => ()
  }
  count
}
