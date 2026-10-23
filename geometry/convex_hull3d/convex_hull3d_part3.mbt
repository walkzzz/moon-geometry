///|
/// Count faces of 3D convex hull. / 三维凸包面数。
pub fn hull_face_count(faces : Array[HullFace]) -> Int {
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
    let det = a.x * (b.y * c.z - b.z * c.y) - a.y * (b.x * c.z - b.z * c.x) + a.z * (b.x * c.y - b.y * c.x)
    vol += det.abs()
  }
  vol / 6.0
}