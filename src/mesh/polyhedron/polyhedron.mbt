///|
/// Polyhedron represented as vertices and faces (polygon face = vertex indices). / 多面体（顶点 + 面，面为顶点索引数组）。
pub struct Polyhedron {
  vertices : Array[@core.Point3D]
  faces : Array[Array[Int]]
}

///|
/// Construct an empty polyhedron. / 构造空多面体。
pub fn Polyhedron::new() -> Polyhedron {
  { vertices: [], faces: [] }
}

///|
/// Add a vertex, returns index. / 添加顶点，返回索引。
pub fn Polyhedron::add_vertex(p : Polyhedron, v : @core.Point3D) -> Int {
  let idx = p.vertices.length()
  p.vertices.push(v)
  idx
}

///|
/// Add a face (list of vertex indices). / 添加面（顶点索引列表）。
pub fn Polyhedron::add_face(p : Polyhedron, indices : Array[Int]) -> Unit {
  p.faces.push(indices)
}

///|
/// Number of vertices. / 顶点数。
pub fn Polyhedron::vertex_count(p : Polyhedron) -> Int {
  p.vertices.length()
}

///|
/// Number of faces. / 面数。
pub fn Polyhedron::face_count(p : Polyhedron) -> Int {
  p.faces.length()
}

///|
/// Number of edges (unique). / 边数（去重）。
pub fn Polyhedron::edge_count(p : Polyhedron) -> Int {
  let edges : Array[(Int, Int)] = []
  for face in p.faces {
    let n = face.length()
    for i in 0..<n {
      let a = face[i]
      let b = face[(i + 1) % n]
      add_edge(edges, a, b)
    }
  }
  edges.length()
}

fn add_edge(edges : Array[(Int, Int)], a : Int, b : Int) -> Unit {
  let (x, y) = if a < b { (a, b) } else { (b, a) }
  for e in edges {
    if e.0 == x && e.1 == y {
      return
    }
  }
  edges.push((x, y))
}

///|
/// Compute volume using divergence theorem. / 使用散度定理计算体积。
pub fn Polyhedron::volume(p : Polyhedron) -> Double {
  let mut vol = 0.0
  for face in p.faces {
    let n = face.length()
    if n < 3 {
      continue
    }
    let v0 = p.vertices[face[0]]
    let mut face_vol = 0.0
    for i in 1..<(n - 1) {
      let v1 = p.vertices[face[i]]
      let v2 = p.vertices[face[i + 1]]
      face_vol += v0.dot(v1.cross(v2))
    }
    vol += face_vol
  }
  vol / 6.0
}

///|
/// Compute surface area. / 计算表面积。
pub fn Polyhedron::surface_area(p : Polyhedron) -> Double {
  let mut area = 0.0
  for face in p.faces {
    let n = face.length()
    if n < 3 {
      continue
    }
    let v0 = p.vertices[face[0]]
    for i in 1..<(n - 1) {
      let v1 = p.vertices[face[i]]
      let v2 = p.vertices[face[i + 1]]
      let cross = v1.sub(v0).cross(v2.sub(v0))
      area += 0.5 * (cross.x * cross.x + cross.y * cross.y + cross.z * cross.z).sqrt()
    }
  }
  area
}

///|
/// Compute centroid (volume-weighted). / 计算质心（体积加权）。
pub fn Polyhedron::centroid(p : Polyhedron) -> @core.Point3D {
  let mut cx = 0.0
  let mut cy = 0.0
  let mut cz = 0.0
  let mut total_vol = 0.0
  for face in p.faces {
    let n = face.length()
    if n < 3 {
      continue
    }
    let v0 = p.vertices[face[0]]
    for i in 1..<(n - 1) {
      let v1 = p.vertices[face[i]]
      let v2 = p.vertices[face[i + 1]]
      let det = v0.dot(v1.cross(v2))
      let vol = det / 6.0
      cx += vol * (v0.x + v1.x + v2.x) / 4.0
      cy += vol * (v0.y + v1.y + v2.y) / 4.0
      cz += vol * (v0.z + v1.z + v2.z) / 4.0
      total_vol += vol
    }
  }
  if total_vol.abs() < 0.0000000001 {
    return @core.Point3D::new(0.0, 0.0, 0.0)
  }
  @core.Point3D::new(cx / total_vol, cy / total_vol, cz / total_vol)
}

///|
/// Create a unit cube. / 创建单位立方体。
pub fn Polyhedron::cube(
  min_x : Double,
  min_y : Double,
  min_z : Double,
  max_x : Double,
  max_y : Double,
  max_z : Double,
) -> Polyhedron {
  let p = Polyhedron::new()
  let v0 = p.add_vertex(@core.Point3D::new(min_x, min_y, min_z))
  let v1 = p.add_vertex(@core.Point3D::new(max_x, min_y, min_z))
  let v2 = p.add_vertex(@core.Point3D::new(max_x, max_y, min_z))
  let v3 = p.add_vertex(@core.Point3D::new(min_x, max_y, min_z))
  let v4 = p.add_vertex(@core.Point3D::new(min_x, min_y, max_z))
  let v5 = p.add_vertex(@core.Point3D::new(max_x, min_y, max_z))
  let v6 = p.add_vertex(@core.Point3D::new(max_x, max_y, max_z))
  let v7 = p.add_vertex(@core.Point3D::new(min_x, max_y, max_z))
  p.add_face([v0, v3, v2, v1])
  p.add_face([v4, v5, v6, v7])
  p.add_face([v0, v1, v5, v4])
  p.add_face([v1, v2, v6, v5])
  p.add_face([v2, v3, v7, v6])
  p.add_face([v3, v0, v4, v7])
  p
}

///|
/// Create a tetrahedron. / 创建四面体。
pub fn Polyhedron::tetrahedron(
  p0 : @core.Point3D,
  p1 : @core.Point3D,
  p2 : @core.Point3D,
  p3 : @core.Point3D,
) -> Polyhedron {
  let p = Polyhedron::new()
  let v0 = p.add_vertex(p0)
  let v1 = p.add_vertex(p1)
  let v2 = p.add_vertex(p2)
  let v3 = p.add_vertex(p3)
  p.add_face([v0, v2, v1])
  p.add_face([v0, v1, v3])
  p.add_face([v0, v3, v2])
  p.add_face([v1, v2, v3])
  p
}