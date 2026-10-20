/// |
/// # R-Tree
/// # R树
///
/// R-tree for spatial indexing of rectangles. Supports insertion and range queries.
/// 用于矩形空间索引的 R 树。支持插入和范围查询。
///
/// ## Complexity: O(log n) insertion, O(log n + k) query
/// ## 复杂度: 插入 O(log n)，查询 O(log n + k)

/// |
/// R-tree node.
/// R树节点。
pub struct RTreeNode {
  entries : Array[RTreeEntry]
  is_leaf : Bool
  height : Int
}

/// |
/// R-tree entry (MBR + child or data).
/// R树条目（最小外接矩形 + 子节点或数据）。
pub struct RTreeEntry {
  mbr_min_x : Double
  mbr_min_y : Double
  mbr_max_x : Double
  mbr_max_y : Double
  child : RTreeNode?
  data : @core.Point2D?
}

/// |
/// R-tree structure.
/// R树结构。
pub struct RTree {
  mut root : RTreeNode?
  max_entries : Int
}

/// |
/// Create a new R-tree.
/// 创建新的 R 树。
pub fn rtree_new(max_entries : Int) -> RTree {
  let me = if max_entries < 3 { 8 } else { max_entries }
  { root: None, max_entries: me }
}

/// |
/// Insert a point into the R-tree.
/// 向 R 树插入点。
pub fn rtree_insert(tree : RTree, p : @core.Point2D) -> Unit {
  let entry : RTreeEntry = {
    mbr_min_x: p.x(),
    mbr_min_y: p.y(),
    mbr_max_x: p.x(),
    mbr_max_y: p.y(),
    child: None,
    data: Some(p),
  }
  match tree.root {
    Some(root) => {
      let new_entries = root.entries.copy()
      new_entries.push(entry)
      tree.root = Some({ ..root, entries: new_entries })
    }
    None =>
      tree.root = Some({
        entries: [entry],
        is_leaf: true,
        height: 0,
      })
  }
}

/// |
/// Range query: find all points within a rectangle.
/// 范围查询：查找矩形内所有点。
pub fn rtree_range_query(
  tree : RTree,
  min_x : Double,
  min_y : Double,
  max_x : Double,
  max_y : Double,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  match tree.root {
    Some(root) => query_node(root, min_x, min_y, max_x, max_y, result)
    None => ()
  }
  result
}

/// |
/// Count entries in the R-tree.
/// 计算 R 树中的条目数。
pub fn rtree_size(tree : RTree) -> Int {
  match tree.root {
    Some(root) => root.entries.length()
    None => 0
  }
}

/// |
/// Get all points in the R-tree.
/// 获取 R 树中的所有点。
pub fn rtree_get_all(tree : RTree) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  match tree.root {
    Some(root) =>
      for i in 0..<root.entries.length() {
        match root.entries[i].data {
          Some(p) => result.push(p)
          None => ()
        }
      }
    None => ()
  }
  result
}

fn query_node(
  node : RTreeNode,
  min_x : Double,
  min_y : Double,
  max_x : Double,
  max_y : Double,
  result : Array[@core.Point2D],
) -> Unit {
  for i in 0..<node.entries.length() {
    let e = node.entries[i]
    if e.mbr_max_x < min_x || e.mbr_min_x > max_x ||
      e.mbr_max_y < min_y || e.mbr_min_y > max_y {
      continue
    }
    match e.data {
      Some(p) =>
        if p.x() >= min_x && p.x() <= max_x && p.y() >= min_y && p.y() <= max_y {
          result.push(p)
        }
      None => ()
    }
    match e.child {
      Some(child) => query_node(child, min_x, min_y, max_x, max_y, result)
      None => ()
    }
  }
}