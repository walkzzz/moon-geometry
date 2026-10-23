///|
/// 3D convex hull face (triangle indices). / 三维凸包面。
pub struct HullFace {
  v0 : Int32
  v1 : Int32
  v2 : Int32
} derive(Debug)

///|
pub extend HullFace with @moonbitlang/core/debug.Debug::{to_repr}

///|
/// Compute 3D convex hull (incremental). Returns triangle faces. / 三维凸包。
pub fn convex_hull_3d(points : Array[@core.Point3D]) -> Array[HullFace] {
  let n = points.length()
  if n < 4 {
    return []
  }
  let faces : Array[HullFace] = []
  let visible : Array[Bool] = []
  for i in 0..<n {
    ignore(i)
    visible.push(false)
  }
  for i in 0..<n {
    for j in (i + 1)..<n {
      for k in (j + 1)..<n {
        let normal = face_normal(points[i], points[j], points[k])
        let mut all_below = true
        let mut all_above = true
        for l in 0..<n {
          if l != i && l != j && l != k {
            let d = normal.x * (points[l].x - points[i].x) +
              normal.y * (points[l].y - points[i].y) +
              normal.z * (points[l].z - points[i].z)
            if d > 0.000000000001 {
              all_below = false
            }
            if d < -0.000000000001 {
              all_above = false
            }
          }
        }
        if all_below || all_above {
          faces.push({ v0: i, v1: j, v2: k, })
        }
      }
    }
  }
  faces
}

///|
fn face_normal(
  a : @core.Point3D,
  b : @core.Point3D,
  c : @core.Point3D,
) -> @core.Point3D {
  let ux = b.x - a.x
  let uy = b.y - a.y
  let uz = b.z - a.z
  let vx = c.x - a.x
  let vy = c.y - a.y
  let vz = c.z - a.z
  @core.Point3D::new(uy * vz - uz * vy, uz * vx - ux * vz, ux * vy - uy * vx)
}

///|
/// Count faces of 3D convex hull. / 三维凸包面数。
pub fn hull_face_count(faces : Array[HullFace]) -> Int32 {
  faces.length()
}

///|
/// Volume of 3D convex hull (tetrahedral decomposition from origin). / 三维凸包体积。
pub fn hull_volume(
  points : Array[@core.Point3D],
  faces : Array[HullFace],
) -> Double {
  let mut vol = 0.0
  for i in 0..<faces.length() {
    let f = faces[i]
    let a = points[f.v0]
    let b = points[f.v1]
    let c = points[f.v2]
    let det = a.x * (b.y * c.z - b.z * c.y) -
      a.y * (b.x * c.z - b.z * c.x) +
      a.z * (b.x * c.y - b.y * c.x)
    vol += det.abs()
  }
  vol / 6.0
}
