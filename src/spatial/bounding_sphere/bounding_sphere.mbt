///|
/// Bounding sphere (center + radius). / 包围球（中心 + 半径）。
pub struct BoundingSphere {
  center : @core.Point3D
  radius : Double
}

///|
/// Construct a bounding sphere. / 构造包围球。
pub fn BoundingSphere::new(center : @core.Point3D, radius : Double) -> BoundingSphere {
  { center, radius }
}

///|
/// Trivial sphere from 0 points. / 零点的平凡球。
fn sphere_from_0() -> BoundingSphere {
  { center: @core.Point3D::new(0.0, 0.0, 0.0), radius: 0.0 }
}

///|
/// Sphere from 1 point. / 一点的球。
fn sphere_from_1(p0 : @core.Point3D) -> BoundingSphere {
  { center: p0, radius: 0.0 }
}

///|
/// Sphere from 2 points (diameter = segment). / 两点的球（直径为线段）。
fn sphere_from_2(p0 : @core.Point3D, p1 : @core.Point3D) -> BoundingSphere {
  let c = @core.Point3D::new(
    (p0.x + p1.x) / 2.0,
    (p0.y + p1.y) / 2.0,
    (p0.z + p1.z) / 2.0,
  )
  let r = p0.dist(p1) / 2.0
  { center: c, radius: r }
}

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
  let d = ax * (ay * bz - az * by) - ay * (ax * bz - az * bx) + az * (ax * by - ay * bx)
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
  { center, radius }
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
  let det = dx1 * (dy2 * dz3 - dz2 * dy3) - dy1 * (dx2 * dz3 - dz2 * dx3) + dz1 * (dx2 * dy3 - dy2 * dx3)
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
  { center, radius }
}

///|
/// Check if point is inside sphere (with tolerance). / 检查点是否在球内（带容差）。
fn in_sphere(s : BoundingSphere, p : @core.Point3D) -> Bool {
  s.center.dist_sq(p) <= s.radius * s.radius + 0.0000001
}

///|
/// Welzl's minimum bounding sphere algorithm. / Welzl 最小包围球算法。
pub fn min_bounding_sphere(points : Array[@core.Point3D]) -> BoundingSphere {
  let n = points.length()
  if n == 0 {
    return sphere_from_0()
  }
  if n == 1 {
    return sphere_from_1(points[0])
  }
  let pts = Array::make(n, @core.Point3D::new(0.0, 0.0, 0.0))
  for i in 0..<n {
    pts[i] = points[i]
  }
  welzl(pts, n, 0, [])
}

fn welzl(
  pts : Array[@core.Point3D],
  n : Int,
  end : Int,
  boundary : Array[@core.Point3D],
) -> BoundingSphere {
  if end == n || boundary.length() == 4 {
    match boundary.length() {
      0 => sphere_from_0()
      1 => sphere_from_1(boundary[0])
      2 => sphere_from_2(boundary[0], boundary[1])
      3 => sphere_from_3(boundary[0], boundary[1], boundary[2])
      _ => sphere_from_4(boundary[0], boundary[1], boundary[2], boundary[3])
    }
  } else {
    let p = pts[end]
    let s = welzl(pts, n, end + 1, boundary)
    if in_sphere(s, p) {
      s
    } else {
      boundary.push(p)
      let result = welzl(pts, n, end + 1, boundary)
      ignore(boundary.remove(boundary.length() - 1))
      result
    }
  }
}

///|
/// Volume of the sphere. / 球体积。
pub fn BoundingSphere::volume(s : BoundingSphere) -> Double {
  4.0 / 3.0 * 3.14159265358979323846 * s.radius * s.radius * s.radius
}

///|
/// Surface area of the sphere. / 球表面积。
pub fn BoundingSphere::surface_area(s : BoundingSphere) -> Double {
  4.0 * 3.14159265358979323846 * s.radius * s.radius
}