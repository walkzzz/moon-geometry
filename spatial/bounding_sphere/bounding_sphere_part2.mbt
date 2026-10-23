///|
/// Sphere from 3 points (circumsphere of triangle). / 三点的球（三角形外接球）。
fn sphere_from_3(
  p0 : @core.Point3D,
  p1 : @core.Point3D,
  p2 : @core.Point3D,
) -> BoundingSphere {
  let ax = p1.x - p0.x
  let ay = p1.y - p0.y
  let az = p1.z - p0.z
  let bx = p2.x - p0.x
  let by = p2.y - p0.y
  let bz = p2.z - p0.z
  let d = ax * (ay * bz - az * by) -
    ay * (ax * bz - az * bx) +
    az * (ax * by - ay * bx)
  if d.abs() < 0.0000000001 {
    return sphere_from_2(p0, p1)
  }
  let asq = ax * ax + ay * ay + az * az
  let bsq = bx * bx + by * by + bz * bz
  let cx = (asq * (by * bz - bz * by) - bsq * (ay * bz - az * by)) / (2.0 * d)
  let cy = (asq * (bx * bz - bz * bx) - bsq * (ax * bz - az * bx)) / (2.0 * d)
  let cz = (asq * (bx * by - by * bx) - bsq * (ax * by - ay * bx)) / (2.0 * d)
  let center = @core.Point3D::new(p0.x + cx, p0.y + cy, p0.z + cz)
  let radius = center.dist(p0)
  { center, radius, }
}

///|
/// Sphere from 4 points (circumsphere of tetrahedron). / 四点的球（四面体外接球）。
fn sphere_from_4(
  p0 : @core.Point3D,
  p1 : @core.Point3D,
  p2 : @core.Point3D,
  p3 : @core.Point3D,
) -> BoundingSphere {
  let dx1 = p1.x - p0.x
  let dy1 = p1.y - p0.y
  let dz1 = p1.z - p0.z
  let dx2 = p2.x - p0.x
  let dy2 = p2.y - p0.y
  let dz2 = p2.z - p0.z
  let dx3 = p3.x - p0.x
  let dy3 = p3.y - p0.y
  let dz3 = p3.z - p0.z
  let det = dx1 * (dy2 * dz3 - dz2 * dy3) -
    dy1 * (dx2 * dz3 - dz2 * dx3) +
    dz1 * (dx2 * dy3 - dy2 * dx3)
  if det.abs() < 0.0000000001 {
    return sphere_from_3(p0, p1, p2)
  }
  let sq1 = dx1 * dx1 + dy1 * dy1 + dz1 * dz1
  let sq2 = dx2 * dx2 + dy2 * dy2 + dz2 * dz2
  let sq3 = dx3 * dx3 + dy3 * dy3 + dz3 * dz3
  let a11 = dy2 * dz3 - dz2 * dy3
  let a12 = -(dy1 * dz3 - dz1 * dy3)
  let a13 = dy1 * dz2 - dz1 * dy2
  let a21 = -(dx2 * dz3 - dz2 * dx3)
  let a22 = dx1 * dz3 - dz1 * dx3
  let a23 = -(dx1 * dz2 - dz1 * dx2)
  let a31 = dx2 * dy3 - dy2 * dx3
  let a32 = -(dx1 * dy3 - dy1 * dx3)
  let a33 = dx1 * dy2 - dy1 * dx2
  let cx = (sq1 * a11 + sq2 * a12 + sq3 * a13) / (2.0 * det)
  let cy = (sq1 * a21 + sq2 * a22 + sq3 * a23) / (2.0 * det)
  let cz = (sq1 * a31 + sq2 * a32 + sq3 * a33) / (2.0 * det)
  let center = @core.Point3D::new(p0.x + cx, p0.y + cy, p0.z + cz)
  let radius = center.dist(p0)
  { center, radius, }
}

///|
/// Check if point is inside sphere (with tolerance). / 检查点是否在球内（带容差）。
fn in_sphere(s : BoundingSphere, p : @core.Point3D) -> Bool {
  s.center.dist_sq(p) <= s.radius * s.radius + 0.0000001
}
