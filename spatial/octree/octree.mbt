/// |
/// # Octree
/// # 八叉树
///
/// Octree for 3D spatial point indexing. Supports insertion and range queries.
/// 用于三维空间点索引的八叉树。支持插入和范围查询。
///
/// ## Complexity: O(log n) insertion, O(log n + k) query
/// ## 复杂度: 插入 O(log n)，查询 O(log n + k)

///|
/// |
/// Octree node.
/// 八叉树节点。
pub struct OctreeNode {
  cx : Double
  cy : Double
  cz : Double
  size : Double
  points : Array[@core.Point3D]
  mut children : Array[OctreeNode]?
  capacity : Int32
  max_depth : Int32
  depth : Int32
}

///|
/// |
/// Create a new octree.
/// 创建新的八叉树。
pub fn octree_new(
  cx : Double,
  cy : Double,
  cz : Double,
  size : Double,
  capacity : Int32,
  max_depth : Int32,
) -> OctreeNode {
  {
    cx,
    cy,
    cz,
    size,
    points: [],
    children: None,
    capacity: if capacity < 1 {
      8
    } else {
      capacity
    },
    max_depth: if max_depth < 1 {
      10
    } else {
      max_depth
    },
    depth: 0,
  }
}

///|
/// |
/// Insert a point into the octree.
/// 向八叉树插入点。
pub fn octree_insert(node : OctreeNode, p : @core.Point3D) -> Unit {
  if node.depth >= node.max_depth || node.points.length() < node.capacity {
    node.points.push(p)
    return
  }
  if node.children is None {
    octree_subdivide(node)
  }
  let idx = octree_child_index(node, p)
  match node.children {
    Some(children) => octree_insert(children[idx], p)
    None => node.points.push(p)
  }
}

///|
/// |
/// Query all points within a bounding box.
/// 查询包围盒内所有点。
pub fn octree_range_query(
  node : OctreeNode,
  min_x : Double,
  min_y : Double,
  min_z : Double,
  max_x : Double,
  max_y : Double,
  max_z : Double,
) -> Array[@core.Point3D] {
  let result : Array[@core.Point3D] = []
  octree_query_impl(node, min_x, min_y, min_z, max_x, max_y, max_z, result)
  result
}

///|
/// |
/// Count total points in the octree.
/// 计算八叉树中的总点数。
pub fn octree_size(node : OctreeNode) -> Int32 {
  let mut count = node.points.length()
  match node.children {
    Some(children) =>
      for i in 0..<children.length() {
        count += octree_size(children[i])
      }
    None => ()
  }
  count
}

///|
fn octree_subdivide(node : OctreeNode) -> Unit {
  let half = node.size / 2.0
  let quarter = node.size / 4.0
  let children : Array[OctreeNode] = []
  for i in 0..<8 {
    let dx = if i % 2 == 0 { -quarter } else { quarter }
    let dy = if i / 2 % 2 == 0 { -quarter } else { quarter }
    let dz = if i / 4 == 0 { -quarter } else { quarter }
    children.push({
      cx: node.cx + dx,
      cy: node.cy + dy,
      cz: node.cz + dz,
      size: half,
      points: [],
      children: None,
      capacity: node.capacity,
      max_depth: node.max_depth,
      depth: node.depth + 1,
    })
  }
  for i in 0..<node.points.length() {
    let p = node.points[i]
    let idx = octree_child_index(node, p)
    children[idx].points.push(p)
  }
  node.points.clear()
  node.children = Some(children)
}

///|
fn octree_child_index(node : OctreeNode, p : @core.Point3D) -> Int32 {
  let mut idx = 0
  if p.x >= node.cx {
    idx += 1
  }
  if p.y >= node.cy {
    idx += 2
  }
  if p.z >= node.cz {
    idx += 4
  }
  idx
}

///|
fn octree_query_impl(
  node : OctreeNode,
  min_x : Double,
  min_y : Double,
  min_z : Double,
  max_x : Double,
  max_y : Double,
  max_z : Double,
  result : Array[@core.Point3D],
) -> Unit {
  let half = node.size / 2.0
  if node.cx + half < min_x ||
    node.cx - half > max_x ||
    node.cy + half < min_y ||
    node.cy - half > max_y ||
    node.cz + half < min_z ||
    node.cz - half > max_z {
    return
  }
  for i in 0..<node.points.length() {
    let p = node.points[i]
    if p.x >= min_x &&
      p.x <= max_x &&
      p.y >= min_y &&
      p.y <= max_y &&
      p.z >= min_z &&
      p.z <= max_z {
      result.push(p)
    }
  }
  match node.children {
    Some(children) =>
      for i in 0..<children.length() {
        octree_query_impl(
          children[i],
          min_x,
          min_y,
          min_z,
          max_x,
          max_y,
          max_z,
          result,
        )
      }
    None => ()
  }
}
