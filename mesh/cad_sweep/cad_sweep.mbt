///|
/// Sweep a 2D profile along a 3D path to create a mesh. / 将2D轮廓沿3D路径扫描创建网格。
pub fn sweep_profile(
  profile : Array[@core.Point2D],
  path : Array[@core.Point3D],
) -> (Array[@core.Point3D], Array[(Int32, Int32, Int32)]) {
  let verts : Array[@core.Point3D] = []
  let faces : Array[(Int32, Int32, Int32)] = []
  let m = profile.length()
  let n = path.length()
  if m < 2 || n < 2 {
    return (verts, faces)
  }
  for path_pt in path {
    for p in profile {
      verts.push(
        @core.Point3D::new(path_pt.x + p.x, path_pt.y + p.y, path_pt.z),
      )
    }
  }
  for layer in 0..<(n - 1) {
    for i in 0..<m {
      let next = (i + 1) % m
      let a = layer * m + i
      let b = layer * m + next
      let c = (layer + 1) * m + next
      let d = (layer + 1) * m + i
      faces.push((a, b, c))
      faces.push((a, c, d))
    }
  }
  (verts, faces)
}

///|
/// Revolve a 2D profile around an axis to create a surface of revolution. / 将2D轮廓绕轴旋转创建回转面。
pub fn revolve_profile(
  profile : Array[@core.Point2D],
  axis : @core.Point3D,
  angle : Double,
) -> (Array[@core.Point3D], Array[(Int32, Int32, Int32)]) {
  let verts : Array[@core.Point3D] = []
  let faces : Array[(Int32, Int32, Int32)] = []
  let m = profile.length()
  if m < 2 || angle == 0.0 {
    return (verts, faces)
  }
  let segments = 16
  let dtheta = angle / segments.to_double()
  let len = axis.dist(@core.Point3D::new(0.0, 0.0, 0.0))
  if len == 0.0 {
    return (verts, faces)
  }
  let naxis = @core.Point3D::new(axis.x / len, axis.y / len, axis.z / len)
  for s in 0..<(segments + 1) {
    let theta = dtheta * s.to_double()
    for p in profile {
      let pt = @core.Point3D::new(p.x, p.y, 0.0)
      let rotated = rotate_around_axis(pt, naxis, theta)
      verts.push(rotated)
    }
  }
  for s in 0..<segments {
    for i in 0..<m {
      let next = (i + 1) % m
      let a = s * m + i
      let b = s * m + next
      let c = (s + 1) * m + next
      let d = (s + 1) * m + i
      faces.push((a, b, c))
      faces.push((a, c, d))
    }
  }
  (verts, faces)
}

///|
/// Rotate point pt around normalized axis by theta using Rodrigues formula. / 使用 Rodrigues 公式将点 pt 绕归一化轴旋转 theta 角。
fn rotate_around_axis(
  pt : @core.Point3D,
  axis : @core.Point3D,
  theta : Double,
) -> @core.Point3D {
  let cos_t = @math.cos(theta)
  let sin_t = @math.sin(theta)
  let kxv = axis.cross(pt)
  let kdv = axis.dot(pt)
  @core.Point3D::new(
    pt.x * cos_t + kxv.x * sin_t + axis.x * kdv * (1.0 - cos_t),
    pt.y * cos_t + kxv.y * sin_t + axis.y * kdv * (1.0 - cos_t),
    pt.z * cos_t + kxv.z * sin_t + axis.z * kdv * (1.0 - cos_t),
  )
}
