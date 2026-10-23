/// |
/// # Surface Mesh Operations
/// # 曲面网格操作
///
/// Mesh subdivision, normal computation, and area calculation for triangle meshes.
/// 三角网格的细分、法线计算和面积计算。
///
/// ## Representation: vertices Array[(x,y,z)], faces Array[(i,j,k)]
/// ## 表示: 顶点 Array[(x,y,z)], 面 Array[(i,j,k)]

///|
/// |
/// Compute face normal of a triangle.
/// 计算三角面的法线。
///
/// # Arguments / 参数
/// - `vertices`: vertex array / 顶点数组
/// - `face`: triangle indices (i, j, k) / 三角形索引
pub fn face_normal(
  vertices : Array[(Double, Double, Double)],
  face : (Int32, Int32, Int32),
) -> (Double, Double, Double) {
  let (i, j, k) = face
  let (x1, y1, z1) = vertices[i]
  let (x2, y2, z2) = vertices[j]
  let (x3, y3, z3) = vertices[k]
  let ux = x2 - x1
  let uy = y2 - y1
  let uz = z2 - z1
  let vx = x3 - x1
  let vy = y3 - y1
  let vz = z3 - z1
  let nx = uy * vz - uz * vy
  let ny = uz * vx - ux * vz
  let nz = ux * vy - uy * vx
  let len = (nx * nx + ny * ny + nz * nz).sqrt()
  if len.abs() < 0.0000000001 {
    return (0.0, 0.0, 0.0)
  }
  (nx / len, ny / len, nz / len)
}

///|
/// |
/// Compute vertex normal by averaging adjacent face normals.
/// 通过平均相邻面法线计算顶点法线。
///
/// # Arguments / 参数
/// - `vertices`: vertex array / 顶点数组
/// - `faces`: face array / 面数组
/// - `vidx`: vertex index / 顶点索引
pub fn vertex_normal(
  vertices : Array[(Double, Double, Double)],
  faces : Array[(Int32, Int32, Int32)],
  vidx : Int32,
) -> (Double, Double, Double) {
  let mut nx = 0.0
  let mut ny = 0.0
  let mut nz = 0.0
  for face in faces {
    let (i, j, k) = face
    if i == vidx || j == vidx || k == vidx {
      let (fx, fy, fz) = face_normal(vertices, face)
      nx += fx
      ny += fy
      nz += fz
    }
  }
  let len = (nx * nx + ny * ny + nz * nz).sqrt()
  if len.abs() < 0.0000000001 {
    return (0.0, 0.0, 0.0)
  }
  (nx / len, ny / len, nz / len)
}

///|
/// |
/// Compute triangle area.
/// 计算三角形面积。
pub fn triangle_area(
  vertices : Array[(Double, Double, Double)],
  face : (Int32, Int32, Int32),
) -> Double {
  let (i, j, k) = face
  let (x1, y1, z1) = vertices[i]
  let (x2, y2, z2) = vertices[j]
  let (x3, y3, z3) = vertices[k]
  let ux = x2 - x1
  let uy = y2 - y1
  let uz = z2 - z1
  let vx = x3 - x1
  let vy = y3 - y1
  let vz = z3 - z1
  let cx = uy * vz - uz * vy
  let cy = uz * vx - ux * vz
  let cz = ux * vy - uy * vx
  0.5 * (cx * cx + cy * cy + cz * cz).sqrt()
}

///|
/// |
/// Compute total mesh surface area.
/// 计算网格总表面积。
pub fn mesh_area(
  vertices : Array[(Double, Double, Double)],
  faces : Array[(Int32, Int32, Int32)],
) -> Double {
  let mut total = 0.0
  for face in faces {
    total += triangle_area(vertices, face)
  }
  total
}

///|
/// |
/// Subdivide a triangle mesh using midpoint subdivision.
/// 使用中点细分三角网格。
///
/// Returns (new_vertices, new_faces).
/// 返回 (新顶点, 新面)。
pub fn midpoint_subdivide(
  vertices : Array[(Double, Double, Double)],
  faces : Array[(Int32, Int32, Int32)],
) -> (Array[(Double, Double, Double)], Array[(Int32, Int32, Int32)]) {
  let new_verts : Array[(Double, Double, Double)] = []
  for v in vertices {
    new_verts.push(v)
  }
  let new_faces : Array[(Int32, Int32, Int32)] = []
  for face in faces {
    let (i, j, k) = face
    let (xi, yi, zi) = vertices[i]
    let (xj, yj, zj) = vertices[j]
    let (xk, yk, zk) = vertices[k]
    let mij = new_verts.length()
    new_verts.push(((xi + xj) / 2.0, (yi + yj) / 2.0, (zi + zj) / 2.0))
    let mjk = new_verts.length()
    new_verts.push(((xj + xk) / 2.0, (yj + yk) / 2.0, (zj + zk) / 2.0))
    let mki = new_verts.length()
    new_verts.push(((xk + xi) / 2.0, (yk + yi) / 2.0, (zk + zi) / 2.0))
    new_faces.push((i, mij, mki))
    new_faces.push((mij, j, mjk))
    new_faces.push((mki, mjk, k))
    new_faces.push((mij, mjk, mki))
  }
  (new_verts, new_faces)
}

///|
/// |
/// Compute mesh bounding box.
/// 计算网格包围盒。
///
/// Returns (min_x, min_y, min_z, max_x, max_y, max_z).
/// 返回 (min_x, min_y, min_z, max_x, max_y, max_z)。
pub fn mesh_bounding_box(
  vertices : Array[(Double, Double, Double)],
) -> (Double, Double, Double, Double, Double, Double) {
  let (x0, y0, z0) = vertices[0]
  let mut min_x = x0
  let mut min_y = y0
  let mut min_z = z0
  let mut max_x = x0
  let mut max_y = y0
  let mut max_z = z0
  for v in vertices {
    let (x, y, z) = v
    if x < min_x {
      min_x = x
    }
    if y < min_y {
      min_y = y
    }
    if z < min_z {
      min_z = z
    }
    if x > max_x {
      max_x = x
    }
    if y > max_y {
      max_y = y
    }
    if z > max_z {
      max_z = z
    }
  }
  (min_x, min_y, min_z, max_x, max_y, max_z)
}

///|
/// |
/// Validate mesh: check face indices are in range.
/// 验证网格: 检查面索引在范围内。
pub fn validate_mesh(
  vertices : Array[(Double, Double, Double)],
  faces : Array[(Int32, Int32, Int32)],
) -> Bool {
  let n = vertices.length()
  for face in faces {
    let (i, j, k) = face
    if i < 0 || i >= n || j < 0 || j >= n || k < 0 || k >= n {
      return false
    }
    if i == j || j == k || i == k {
      return false
    }
  }
  true
}
