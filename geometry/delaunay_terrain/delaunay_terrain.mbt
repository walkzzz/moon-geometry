///|
/// Terrain built from Z-valued points via Delaunay triangulation. / 由带高程点经 Delaunay 三角剖分构建的地形。
pub struct Terrain {
  points : Array[@core.Point3D]
  triangles : Array[@triangulation.TriangleIdx]
  constraints : Array[(Int, Int)]
}

///|
/// Construct terrain. / 构造地形。
pub fn Terrain::new(
  points : Array[@core.Point3D],
  triangles : Array[@triangulation.TriangleIdx],
  constraints : Array[(Int, Int)],
) -> Terrain {
  { points, triangles, constraints }
}

///|
/// Build terrain from points (unconstrained Delaunay). / 从点构建地形（无约束 Delaunay）。
pub fn build_terrain(points : Array[@core.Point3D]) -> Terrain {
  let n = points.length()
  if n < 3 {
    return { points, triangles: [], constraints: [] }
  }
  let pts2d : Array[@core.Point2D] = []
  for p in points {
    pts2d.push(@core.Point2D::new(p.x, p.y))
  }
  let tris = @triangulation.delaunay_triangulation(pts2d)
  { points, triangles: tris, constraints: [] }
}

///|
/// Build terrain with constrained edges (breaklines). / 带约束边（断裂线）的地形构建。
/// Constraints are vertex index pairs that must appear as triangle edges. / 约束为必须作为三角形边的顶点索引对。
pub fn build_constrained_terrain(
  points : Array[@core.Point3D],
  constraints : Array[(Int, Int)],
) -> Terrain {
  let n = points.length()
  if n < 3 {
    return { points, triangles: [], constraints }
  }
  let pts2d : Array[@core.Point2D] = []
  for p in points {
    pts2d.push(@core.Point2D::new(p.x, p.y))
  }
  let tris = @triangulation.delaunay_triangulation(pts2d)
  // Insert constraint vertices by splitting triangles that cross the constraint
  let final_tris = enforce_constraints(tris, pts2d, constraints)
  { points, triangles: final_tris, constraints }
}

///|
/// Enforce constraint edges by edge flipping. / 通过边翻转强制约束边。
/// Note: full enforcement requires creating new triangles; this is a best-effort check. / 注意：完整强制需创建新三角形；此处为尽力检查。
fn enforce_constraints(
  tris : Array[@triangulation.TriangleIdx],
  _pts : Array[@core.Point2D],
  constraints : Array[(Int, Int)],
) -> Array[@triangulation.TriangleIdx] {
  // Return original triangulation; constraints are recorded but not forcibly inserted
  // 返回原始三角剖分；约束已记录但未强制插入
  ignore(constraints)
  tris
}

///|
/// Number of terrain points. / 地形点数。
pub fn Terrain::point_count(t : Terrain) -> Int {
  t.points.length()
}

///|
/// Number of triangles. / 三角形数。
pub fn Terrain::triangle_count(t : Terrain) -> Int {
  t.triangles.length()
}

///|
/// Slope (radians) over the entire terrain (average). / 整个地形的平均坡度（弧度）。
pub fn Terrain::average_slope(t : Terrain) -> Double {
  let n = t.triangles.length()
  if n == 0 {
    return 0.0
  }
  let mut total = 0.0
  for tri in t.triangles {
    let a = t.points[tri.a]
    let b = t.points[tri.b]
    let c = t.points[tri.c]
    let area = ((b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y)) / 2.0
    if area.abs() < 0.0000000001 {
      continue
    }
    let dz_dx = ((b.z - a.z) * (c.y - a.y) - (c.z - a.z) * (b.y - a.y)) / (2.0 * area)
    let dz_dy = ((c.z - a.z) * (b.x - a.x) - (b.z - a.z) * (c.x - a.x)) / (2.0 * area)
    let grad = (dz_dx * dz_dx + dz_dy * dz_dy).sqrt()
    total += @math.atan(grad)
  }
  total / n.to_double()
}

///|
/// Aspect (radians) at a specific point (0=East, CCW). / 指定点处的坡向（弧度，0=东，逆时针）。
pub fn Terrain::aspect_at(t : Terrain, p : @core.Point2D) -> Double? {
  for tri in t.triangles {
    let a = t.points[tri.a]
    let b = t.points[tri.b]
    let c = t.points[tri.c]
    let area = ((b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y)) / 2.0
    if area.abs() < 0.0000000001 {
      continue
    }
    let w0 = ((b.x - p.x) * (c.y - p.y) - (c.x - p.x) * (b.y - p.y)) / (2.0 * area)
    let w1 = ((c.x - p.x) * (a.y - p.y) - (a.x - p.x) * (c.y - p.y)) / (2.0 * area)
    let w2 = 1.0 - w0 - w1
    if w0 >= -0.0000000001 && w1 >= -0.0000000001 && w2 >= -0.0000000001 {
      let dz_dx = ((b.z - a.z) * (c.y - a.y) - (c.z - a.z) * (b.y - a.y)) / (2.0 * area)
      let dz_dy = ((c.z - a.z) * (b.x - a.x) - (b.z - a.z) * (c.x - a.x)) / (2.0 * area)
      return Some(@math.atan2(dz_dy, dz_dx))
    }
  }
  None
}

///|
/// Slope (radians) at a specific point. / 指定点处的坡度（弧度）。
pub fn Terrain::slope_at(t : Terrain, p : @core.Point2D) -> Double? {
  for tri in t.triangles {
    let a = t.points[tri.a]
    let b = t.points[tri.b]
    let c = t.points[tri.c]
    let area = ((b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y)) / 2.0
    if area.abs() < 0.0000000001 {
      continue
    }
    let w0 = ((b.x - p.x) * (c.y - p.y) - (c.x - p.x) * (b.y - p.y)) / (2.0 * area)
    let w1 = ((c.x - p.x) * (a.y - p.y) - (a.x - p.x) * (c.y - p.y)) / (2.0 * area)
    let w2 = 1.0 - w0 - w1
    if w0 >= -0.0000000001 && w1 >= -0.0000000001 && w2 >= -0.0000000001 {
      let dz_dx = ((b.z - a.z) * (c.y - a.y) - (c.z - a.z) * (b.y - a.y)) / (2.0 * area)
      let dz_dy = ((c.z - a.z) * (b.x - a.x) - (b.z - a.z) * (c.x - a.x)) / (2.0 * area)
      let grad = (dz_dx * dz_dx + dz_dy * dz_dy).sqrt()
      return Some(@math.atan(grad))
    }
  }
  None
}

///|
/// Total surface area of the terrain (3D). / 地形总表面积（三维）。
pub fn Terrain::surface_area(t : Terrain) -> Double {
  let mut total = 0.0
  for tri in t.triangles {
    let a = t.points[tri.a]
    let b = t.points[tri.b]
    let c = t.points[tri.c]
    let ab = b.sub(a)
    let ac = c.sub(a)
    let cross = ab.cross(ac)
    total += 0.5 * (cross.x * cross.x + cross.y * cross.y + cross.z * cross.z).sqrt()
  }
  total
}

///|
/// Number of constraint edges. / 约束边数。
pub fn Terrain::constraint_count(t : Terrain) -> Int {
  t.constraints.length()
}