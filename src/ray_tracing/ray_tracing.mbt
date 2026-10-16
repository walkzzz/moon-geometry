///|
/// 3D ray: origin + direction. / 三维射线：起点 + 方向。
pub struct Ray3 {
  origin : @core.Point3D
  dir : @core.Point3D
}

///|
/// Construct a 3D ray. / 构造三维射线。
pub fn Ray3::new(origin : @core.Point3D, dir : @core.Point3D) -> Ray3 {
  { origin, dir }
}

///|
/// Evaluate ray at parameter t. / 计算射线上参数 t 处的点。
pub fn ray_eval(r : Ray3, t : Double) -> @core.Point3D {
  @core.Point3D::new(
    r.origin.x + r.dir.x * t,
    r.origin.y + r.dir.y * t,
    r.origin.z + r.dir.z * t,
  )
}

///|
/// Ray-triangle intersection (Moller-Trumbore). Returns t >= 0 or None.
/// 射线与三角形相交（Moller-Trumbore）。返回 t >= 0 或 None。
pub fn ray_triangle_intersect(
  r : Ray3,
  v0 : @core.Point3D,
  v1 : @core.Point3D,
  v2 : @core.Point3D,
) -> Double? {
  let eps = 0.0000001
  let edge1 = v1.sub(v0)
  let edge2 = v2.sub(v0)
  let h = r.dir.cross(edge2)
  let a = edge1.dot(h)
  if a > -eps && a < eps {
    return None
  }
  let f = 1.0 / a
  let s = r.origin.sub(v0)
  let u = f * s.dot(h)
  if u < 0.0 || u > 1.0 {
    return None
  }
  let q = s.cross(edge1)
  let v = f * r.dir.dot(q)
  if v < 0.0 || u + v > 1.0 {
    return None
  }
  let t = f * edge2.dot(q)
  if t > eps {
    Some(t)
  } else {
    None
  }
}

///|
/// Ray-sphere intersection. Returns nearest t >= 0 or None.
/// 射线与球相交。返回最近 t >= 0 或 None。
pub fn ray_sphere_intersect(
  r : Ray3,
  center : @core.Point3D,
  radius : Double,
) -> Double? {
  let eps = 0.0000001
  let oc = r.origin.sub(center)
  let a = r.dir.dot(r.dir)
  let b = 2.0 * oc.dot(r.dir)
  let c = oc.dot(oc) - radius * radius
  let disc = b * b - 4.0 * a * c
  if disc < 0.0 {
    return None
  }
  let sq = disc.sqrt()
  let t1 = (-b - sq) / (2.0 * a)
  let t2 = (-b + sq) / (2.0 * a)
  if t1 > eps {
    Some(t1)
  } else if t2 > eps {
    Some(t2)
  } else {
    None
  }
}

///|
/// Ray-plane intersection. Returns t >= 0 or None.
/// 射线与平面相交。返回 t >= 0 或 None。
pub fn ray_plane_intersect(
  r : Ray3,
  point : @core.Point3D,
  normal : @core.Point3D,
) -> Double? {
  let eps = 0.0000001
  let denom = r.dir.dot(normal)
  if denom > -eps && denom < eps {
    return None
  }
  let diff = point.sub(r.origin)
  let t = diff.dot(normal) / denom
  if t >= 0.0 {
    Some(t)
  } else {
    None
  }
}

///|
/// Check if a point is in shadow relative to a light source.
/// 检查点相对于光源是否在阴影中。
pub fn point_in_shadow(
  point : @core.Point3D,
  light : @core.Point3D,
  triangles : Array[(@core.Point3D, @core.Point3D, @core.Point3D)],
) -> Bool {
  let eps = 0.0001
  let to_light = light.sub(point)
  let dist = to_light.x * to_light.x + to_light.y * to_light.y + to_light.z * to_light.z
  let dist_sqrt = dist.sqrt()
  if dist_sqrt < eps {
    return false
  }
  let dir = @core.Point3D::new(
    to_light.x / dist_sqrt,
    to_light.y / dist_sqrt,
    to_light.z / dist_sqrt,
  )
  let ray = Ray3::new(point, dir)
  for tri in triangles {
    match ray_triangle_intersect(ray, tri.0, tri.1, tri.2) {
      Some(t) =>
        if t > eps && t < dist_sqrt - eps {
          return true
        }
      None => ()
    }
  }
  false
}

///|
/// Nearest intersection among a set of triangles. Returns (t, index) or None.
/// 在三角形集中找最近相交。返回 (t, 索引) 或 None。
pub fn ray_nearest_triangle(
  r : Ray3,
  triangles : Array[(@core.Point3D, @core.Point3D, @core.Point3D)],
) -> (Double, Int)? {
  let mut best_t = -1.0
  let mut best_i = -1
  for i in 0..<triangles.length() {
    let tri = triangles[i]
    match ray_triangle_intersect(r, tri.0, tri.1, tri.2) {
      Some(t) =>
        if best_i < 0 || t < best_t {
          best_t = t
          best_i = i
        }
      None => ()
    }
  }
  if best_i >= 0 {
    Some((best_t, best_i))
  } else {
    None
  }
}