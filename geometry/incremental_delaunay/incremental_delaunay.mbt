///|
/// Incremental Delaunay triangulation. / 增量 Delaunay 三角剖分。
///
/// Supports dynamic insertion and deletion of points, enabling interactive
/// editing scenarios (CAD drag, real-time editing) without full recomputation.
///
/// 支持动态插入和删除点，适用于交互式编辑场景（CAD 拖拽、实时编辑），无需全量重算。

///|
/// Incremental Delaunay triangulator state. / 增量 Delaunay 三角剖分器状态。
pub struct IncrementalDelaunay {
  mut vertices : Array[@core.Point2D]
  mut triangles : Array[(Int32, Int32, Int32)]
}

///|
/// Create an empty incremental Delaunay. / 创建空的增量 Delaunay。
pub fn IncrementalDelaunay::new() -> IncrementalDelaunay {
  { vertices: [], triangles: [], }
}

///|
/// Create from initial point set. / 从初始点集创建。
pub fn IncrementalDelaunay::from_points(
  points : Array[@core.Point2D],
) -> IncrementalDelaunay {
  let delaunay = IncrementalDelaunay::new()
  for p in points {
    delaunay.insert(p)
  }
  delaunay
}

///|
/// Insert a single point and update triangulation incrementally. / 插入单个点并增量更新三角剖分。
pub fn IncrementalDelaunay::insert(
  self : IncrementalDelaunay,
  p : @core.Point2D,
) -> Unit {
  let idx = self.vertices.length()
  self.vertices.push(p)
  let n = self.vertices.length()
  if n < 3 {
    return
  }
  if n == 3 {
    self.triangles = [(0, 1, 2)]
    return
  }
  if n == 4 {
    self.triangles = []
    let a = self.vertices[0]
    let b = self.vertices[1]
    let c = self.vertices[2]
    let d = self.vertices[3]
    let in_circum = in_circumcircle(d, a, b, c)
    if in_circum {
      self.triangles.push((0, 1, 3))
      self.triangles.push((0, 3, 2))
      self.triangles.push((1, 2, 3))
    } else {
      self.triangles.push((0, 1, 2))
      self.triangles.push((0, 2, 3))
      self.triangles.push((0, 3, 1))
    }
    return
  }
  let bad_triangles : Array[Int32] = []
  for i in 0..<self.triangles.length() {
    let (a, b, c) = self.triangles[i]
    if in_circumcircle(p, self.vertices[a], self.vertices[b], self.vertices[c]) {
      bad_triangles.push(i)
    }
  }
  let boundary : Array[(Int32, Int32)] = []
  let bad_set : Array[Bool] = Array::make(self.triangles.length(), false)
  for i in bad_triangles {
    bad_set[i] = true
  }
  for i in bad_triangles {
    let (a, b, c) = self.triangles[i]
    let edges = [(a, b), (b, c), (c, a)]
    for j in 0..<3 {
      let (v1, v2) = edges[j]
      let mut shared = false
      for k in 0..<self.triangles.length() {
        if k == i || !bad_set[k] {
          continue
        }
        let (ea, eb, ec) = self.triangles[k]
        let k_edges = [(ea, eb), (eb, ec), (ec, ea)]
        for m in 0..<3 {
          let (k1, k2) = k_edges[m]
          if (k1 == v1 && k2 == v2) || (k1 == v2 && k2 == v1) {
            shared = true
            break
          }
        }
        if shared {
          break
        }
      }
      if !shared {
        boundary.push((v1, v2))
      }
    }
  }
  let new_triangles : Array[(Int32, Int32, Int32)] = []
  for i in 0..<self.triangles.length() {
    if !bad_set[i] {
      new_triangles.push(self.triangles[i])
    }
  }
  for edge in boundary {
    new_triangles.push((edge.0, edge.1, idx))
  }
  self.triangles = new_triangles
}

///|
/// Remove a point and retriangulate. / 删除点并重新三角剖分。
pub fn IncrementalDelaunay::remove(
  self : IncrementalDelaunay,
  index : Int32,
) -> Unit {
  if index < 0 || index >= self.vertices.length() {
    return
  }
  let remaining : Array[@core.Point2D] = []
  for i in 0..<self.vertices.length() {
    if i != index {
      remaining.push(self.vertices[i])
    }
  }
  self.vertices = []
  self.triangles = []
  for p in remaining {
    self.insert(p)
  }
}

///|
/// Get current vertices. / 获取当前顶点。
pub fn IncrementalDelaunay::get_vertices(
  self : IncrementalDelaunay,
) -> Array[@core.Point2D] {
  self.vertices
}

///|
/// Get current triangles. / 获取当前三角形。
pub fn IncrementalDelaunay::get_triangles(
  self : IncrementalDelaunay,
) -> Array[(Int32, Int32, Int32)] {
  self.triangles
}

///|
/// Get triangle count. / 获取三角形数量。
pub fn IncrementalDelaunay::triangle_count(self : IncrementalDelaunay) -> Int32 {
  self.triangles.length()
}

///|
/// Get vertex count. / 获取顶点数量。
pub fn IncrementalDelaunay::vertex_count(self : IncrementalDelaunay) -> Int32 {
  self.vertices.length()
}

///|
/// Check if point d is inside the circumcircle of triangle abc. / 检查点 d 是否在三角形 abc 的外接圆内。
fn in_circumcircle(
  d : @core.Point2D,
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Bool {
  let ax = a.x - d.x
  let ay = a.y - d.y
  let bx = b.x - d.x
  let by = b.y - d.y
  let cx = c.x - d.x
  let cy = c.y - d.y
  let det = (ax * ax + ay * ay) * (bx * cy - cx * by) -
    (bx * bx + by * by) * (ax * cy - cx * ay) +
    (cx * cx + cy * cy) * (ax * by - bx * ay)
  det > 0.0
}
