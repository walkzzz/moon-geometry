///|
/// Volume between TIN surface and z=0 datum. / TIN 表面与 z=0 基准面之间的体积。
pub fn TIN::volume(t : TIN) -> Double {
  let mut vol = 0.0
  for tri in t.triangles {
    let a = t.points[tri.a]
    let b = t.points[tri.b]
    let c = t.points[tri.c]
    let area = ((b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y)) / 2.0
    vol += area * (a.z + b.z + c.z) / 3.0
  }
  vol
}
