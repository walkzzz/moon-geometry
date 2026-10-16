/// |
/// # Loose Octree
/// # 松散八叉树
///
/// Loose octree for fast 3D spatial queries with relaxed cell boundaries.
/// 具有松弛单元边界的快速三维空间查询松散八叉树。
///
/// ## Complexity: O(1) insert, O(log n + k) query
/// ## 复杂度: 插入 O(1)，查询 O(log n + k)

/// |
/// Loose octree node.
/// 松散八叉树节点。
pub struct LooseOctNode {
  cx : Double
  cy : Double
  cz : Double
  size : Double
  loose_factor : Double
  objects : Array[@core.Point3D]
  mut children : Array[LooseOctNode]?
  max_depth : Int
  depth : Int
}

/// |
/// Create a new loose octree.
/// 创建新的松散八叉树。
pub fn loose_octree_new(
  cx : Double,
  cy : Double,
  cz : Double,
  size : Double,
  loose_factor : Double,
  max_depth : Int,
) -> LooseOctNode {
  let lf = if loose_factor < 1.0 { 2.0 } else { loose_factor }
  {
    cx,
    cy,
    cz,
    size,
    loose_factor: lf,
    objects: [],
    children: None,
    max_depth: if max_depth < 1 { 8 } else { max_depth },
    depth: 0,
  }
}

/// |
/// Insert a point into the loose octree.
/// 向松散八叉树插入点。
pub fn loose_octree_insert(node : LooseOctNode, p : @core.Point3D) -> Unit {
  if node.depth >= node.max_depth || node.objects.length() < 8 {
    node.objects.push(p)
    return
  }
  if node.children is None {
    loose_subdivide(node)
  }
  match node.children {
    Some(children) => {
      let idx = loose_child_index(node, p)
      loose_octree_insert(children[idx], p)
    }
    None => node.objects.push(p)
  }
}

/// |
/// Range query in the loose octree.
/// 松散八叉树范围查询。
pub fn loose_octree_query(
  node : LooseOctNode,
  min_x : Double,
  min_y : Double,
  min_z : Double,
  max_x : Double,
  max_y : Double,
  max_z : Double,
) -> Array[@core.Point3D] {
  let result : Array[@core.Point3D] = []
  loose_query_impl(node, min_x, min_y, min_z, max_x, max_y, max_z, result)
  result
}

/// |
/// Count objects in the loose octree.
/// 计算松散八叉树中的对象数。
pub fn loose_octree_count(node : LooseOctNode) -> Int {
  let mut count = node.objects.length()
  match node.children {
    Some(children) =>
      for i in 0..<children.length() {
        count += loose_octree_count(children[i])
      }
    None => ()
  }
  count
}

fn loose_subdivide(node : LooseOctNode) -> Unit {
  let half = node.size / 2.0
  let quarter = node.size / 4.0
  let children : Array[LooseOctNode] = []
  for i in 0..<8 {
    let dx = if i % 2 == 0 { -quarter } else { quarter }
    let dy = if (i / 2) % 2 == 0 { -quarter } else { quarter }
    let dz = if i / 4 == 0 { -quarter } else { quarter }
    children.push({
      cx: node.cx + dx,
      cy: node.cy + dy,
      cz: node.cz + dz,
      size: half,
      loose_factor: node.loose_factor,
      objects: [],
      children: None,
      max_depth: node.max_depth,
      depth: node.depth + 1,
    })
  }
  for i in 0..<node.objects.length() {
    let p = node.objects[i]
    let idx = loose_child_index(node, p)
    children[idx].objects.push(p)
  }
  node.objects.clear()
  node.children = Some(children)
}

fn loose_child_index(node : LooseOctNode, p : @core.Point3D) -> Int {
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

fn loose_query_impl(
  node : LooseOctNode,
  min_x : Double,
  min_y : Double,
  min_z : Double,
  max_x : Double,
  max_y : Double,
  max_z : Double,
  result : Array[@core.Point3D],
) -> Unit {
  let half = node.size * node.loose_factor / 2.0
  if node.cx + half < min_x || node.cx - half > max_x ||
    node.cy + half < min_y || node.cy - half > max_y ||
    node.cz + half < min_z || node.cz - half > max_z {
    return
  }
  for i in 0..<node.objects.length() {
    let p = node.objects[i]
    if p.x >= min_x && p.x <= max_x && p.y >= min_y && p.y <= max_y &&
      p.z >= min_z && p.z <= max_z {
      result.push(p)
    }
  }
  match node.children {
    Some(children) =>
      for i in 0..<children.length() {
        loose_query_impl(
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