///|
/// Extrude a 2D polygon along the Z axis to create a 3D mesh. / 将2D多边形沿Z轴拉伸创建3D网格。
pub fn extrude_polygon(
  points : Array[@core.Point2D],
  height : Double,
) -> (Array[@core.Point3D], Array[(Int32, Int32, Int32)]) {
  let n = points.length()
  let verts : Array[@core.Point3D] = []
  let faces : Array[(Int32, Int32, Int32)] = []
  if n < 3 || height == 0.0 {
    return (verts, faces)
  }
  for p in points {
    verts.push(@core.Point3D::new(p.x, p.y, 0.0))
  }
  for p in points {
    verts.push(@core.Point3D::new(p.x, p.y, height))
  }
  for i in 1..<(n - 1) {
    faces.push((0, i + 1, i))
  }
  for i in 1..<(n - 1) {
    faces.push((n, n + i, n + i + 1))
  }
  for i in 0..<n {
    let next = (i + 1) % n
    faces.push((i, next, n + next))
    faces.push((i, n + next, n + i))
  }
  (verts, faces)
}

///|
/// Extrude a 2D profile along a 3D direction for a given distance. / 将2D轮廓沿3D方向拉伸指定距离。
pub fn extrude_profile(
  points : Array[@core.Point2D],
  dir : @core.Point3D,
  dist : Double,
) -> (Array[@core.Point3D], Array[(Int32, Int32, Int32)]) {
  let n = points.length()
  let verts : Array[@core.Point3D] = []
  let faces : Array[(Int32, Int32, Int32)] = []
  if n < 3 || dist == 0.0 {
    return (verts, faces)
  }
  let len = dir.dist(@core.Point3D::new(0.0, 0.0, 0.0))
  if len == 0.0 {
    return (verts, faces)
  }
  let ndir = @core.Point3D::new(
    dir.x / len * dist,
    dir.y / len * dist,
    dir.z / len * dist,
  )
  for p in points {
    verts.push(@core.Point3D::new(p.x, p.y, 0.0))
  }
  for p in points {
    verts.push(@core.Point3D::new(p.x + ndir.x, p.y + ndir.y, ndir.z))
  }
  for i in 1..<(n - 1) {
    faces.push((0, i + 1, i))
  }
  for i in 1..<(n - 1) {
    faces.push((n, n + i, n + i + 1))
  }
  for i in 0..<n {
    let next = (i + 1) % n
    faces.push((i, next, n + next))
    faces.push((i, n + next, n + i))
  }
  (verts, faces)
}
