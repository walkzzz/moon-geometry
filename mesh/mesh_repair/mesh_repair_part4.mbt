///|
/// Fill simple holes (single triangle fan). / 填充简单孔洞（单三角扇）。
pub fn fill_holes(
  _vertices : Array[@core.Point3D],
  faces : Array[(Int32, Int32, Int32)],
) -> (Array[(Int32, Int32, Int32)], Int32) {
  let boundary = find_boundary_edges(faces)
  if boundary.length() < 3 {
    return (faces, 0)
  }
  let new_faces : Array[(Int32, Int32, Int32)] = []
  for f in faces {
    new_faces.push(f)
  }
  let v0 = boundary[0].0
  let mut filled = 0
  for i in 1..<boundary.length() {
    let v1 = boundary[i].0
    let v2 = boundary[i].1
    if v0 != v1 && v1 != v2 && v0 != v2 {
      new_faces.push((v0, v1, v2))
      filled += 1
    }
  }
  (new_faces, filled)
}
