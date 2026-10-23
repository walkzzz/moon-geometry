///|
/// Compute volume using divergence theorem. / 使用散度定理计算体积。
pub impl @core.Measurable3D for Polyhedron with volume(self) {
  let mut vol = 0.0
  for face in self.faces {
    let n = face.length()
    if n < 3 {
      continue
    }
    let v0 = self.vertices[face[0]]
    let mut face_vol = 0.0
    for i in 1..<(n - 1) {
      let v1 = self.vertices[face[i]]
      let v2 = self.vertices[face[i + 1]]
      face_vol += v0.dot(v1.cross(v2))
    }
    vol += face_vol
  }
  vol / 6.0
}
