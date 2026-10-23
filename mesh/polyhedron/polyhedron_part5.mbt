///|
/// Compute surface area. / 计算表面积。
pub impl @core.Measurable3D for Polyhedron with surface_area(self) {
  let mut area = 0.0
  for face in self.faces {
    let n = face.length()
    if n < 3 {
      continue
    }
    let v0 = self.vertices[face[0]]
    for i in 1..<(n - 1) {
      let v1 = self.vertices[face[i]]
      let v2 = self.vertices[face[i + 1]]
      let cross = v1.sub(v0).cross(v2.sub(v0))
      area += 0.5 * (cross.x * cross.x + cross.y * cross.y + cross.z * cross.z).sqrt()
    }
  }
  area
}
