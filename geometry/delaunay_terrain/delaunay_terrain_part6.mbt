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
    total += 0.5 *
      (cross.x * cross.x + cross.y * cross.y + cross.z * cross.z).sqrt()
  }
  total
}

///|
/// Number of constraint edges. / 约束边数。
pub fn Terrain::constraint_count(t : Terrain) -> Int32 {
  t.constraints.length()
}
