/// |
/// # Cover Tree
/// # 覆盖树
///
/// Cover tree for metric space indexing with explicit covering property.
/// 具有显式覆盖性质的度量空间索引树。
///
/// ## Complexity: O(n log n) build, O(log n) query
/// ## 复杂度: 构建 O(n log n)，查询 O(log n)

///|
/// |
/// Cover tree node.
/// 覆盖树节点。
pub struct CoverNode {
  point : @core.Point2D
  children : Array[CoverNode]
  level : Int32
}

///|
/// |
/// Cover tree structure.
/// 覆盖树结构。
pub struct CoverTree {
  root : CoverNode?
  base : Double
}

///|
/// |
/// Build a cover tree from points.
/// 从点集构建覆盖树。
pub fn cover_tree_build(points : Array[@core.Point2D]) -> CoverTree {
  if points.is_empty() {
    return { root: None, base: 2.0, }
  }
  let root : CoverNode = { point: points[0], children: [], level: 0, }
  for i in 1..<points.length() {
    cover_insert(root, points[i], 0)
  }
  { root: Some(root), base: 2.0, }
}

///|
/// |
/// Find all points within radius of query.
/// 查找查询点半径内的所有点。
pub fn cover_tree_radius_search(
  tree : CoverTree,
  query : @core.Point2D,
  radius : Double,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  match tree.root {
    Some(root) => cover_search(root, query, radius, result)
    None => ()
  }
  result
}

///|
/// |
/// Count nodes in cover tree.
/// 计算覆盖树中的节点数。
pub fn cover_tree_count(tree : CoverTree) -> Int32 {
  match tree.root {
    Some(root) => cover_count(root)
    None => 0
  }
}

///|
fn cover_insert(node : CoverNode, p : @core.Point2D, level : Int32) -> Unit {
  let d = dist(node.point, p)
  let threshold = pow2(2.0, level)
  if d <= threshold {
    let mut inserted = false
    for i in 0..<node.children.length() {
      let cd = dist(node.children[i].point, p)
      if cd <= threshold / 2.0 {
        cover_insert(node.children[i], p, level - 1)
        inserted = true
        break
      }
    }
    if !inserted {
      node.children.push({ point: p, children: [], level: level - 1, })
    }
  } else {
    node.children.push({ point: p, children: [], level, })
  }
}

///|
fn cover_search(
  node : CoverNode,
  query : @core.Point2D,
  radius : Double,
  result : Array[@core.Point2D],
) -> Unit {
  let d = dist(node.point, query)
  if d <= radius {
    result.push(node.point)
  }
  for i in 0..<node.children.length() {
    let cd = dist(node.children[i].point, query)
    if cd <= radius + pow2(2.0, node.children[i].level) {
      cover_search(node.children[i], query, radius, result)
    }
  }
}

///|
fn cover_count(node : CoverNode) -> Int32 {
  let mut count = 1
  for i in 0..<node.children.length() {
    count += cover_count(node.children[i])
  }
  count
}

///|
fn dist(a : @core.Point2D, b : @core.Point2D) -> Double {
  ((a.x() - b.x()) * (a.x() - b.x()) + (a.y() - b.y()) * (a.y() - b.y())).sqrt()
}

///|
fn pow2(base : Double, exp : Int32) -> Double {
  let mut result = 1.0
  if exp >= 0 {
    for _ in 0..<exp {
      result *= base
    }
  } else {
    for _ in 0..<-exp {
      result /= base
    }
  }
  result
}
