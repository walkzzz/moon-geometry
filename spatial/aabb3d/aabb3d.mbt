///|
/// 3D Axis-Aligned Bounding Box. / 三维轴对齐包围盒。
pub struct AABB3D {
  min_x : Double
  min_y : Double
  min_z : Double
  max_x : Double
  max_y : Double
  max_z : Double
}

///|
pub extend AABB3D with @core.Measurable3D::{volume, surface_area}

///|
/// Construct an AABB3D from min and max corners. / 从最小和最大角点构造 AABB3D。
pub fn AABB3D::new(
  min_x : Double,
  min_y : Double,
  min_z : Double,
  max_x : Double,
  max_y : Double,
  max_z : Double,
) -> AABB3D {
  { min_x, min_y, min_z, max_x, max_y, max_z }
}

///|
/// Construct from a set of points. / 从点集构造。
pub fn AABB3D::from_points(points : Array[@core.Point3D]) -> AABB3D {
  if points.length() == 0 {
    return { min_x: 0.0, min_y: 0.0, min_z: 0.0, max_x: 0.0, max_y: 0.0, max_z: 0.0 }
  }
  let mut min_x = points[0].x
  let mut min_y = points[0].y
  let mut min_z = points[0].z
  let mut max_x = points[0].x
  let mut max_y = points[0].y
  let mut max_z = points[0].z
  for p in points {
    if p.x < min_x {
      min_x = p.x
    }
    if p.y < min_y {
      min_y = p.y
    }
    if p.z < min_z {
      min_z = p.z
    }
    if p.x > max_x {
      max_x = p.x
    }
    if p.y > max_y {
      max_y = p.y
    }
    if p.z > max_z {
      max_z = p.z
    }
  }
  { min_x, min_y, min_z, max_x, max_y, max_z }
}

///|
/// Volume of the AABB. / AABB 体积。
pub impl @core.Measurable3D for AABB3D with volume(self) {
  (self.max_x - self.min_x) * (self.max_y - self.min_y) * (self.max_z - self.min_z)
}

///|
/// Surface area of the AABB. / AABB 表面积。
pub impl @core.Measurable3D for AABB3D with surface_area(self) {
  let dx = self.max_x - self.min_x
  let dy = self.max_y - self.min_y
  let dz = self.max_z - self.min_z
  2.0 * (dx * dy + dy * dz + dx * dz)
}

///|
/// Center point of the AABB. / AABB 中心点。
pub fn AABB3D::center(b : AABB3D) -> @core.Point3D {
  @core.Point3D::new(
    (b.min_x + b.max_x) / 2.0,
    (b.min_y + b.max_y) / 2.0,
    (b.min_z + b.max_z) / 2.0,
  )
}

///|
/// Check if two AABBs intersect. / 检查两个 AABB 是否相交。
pub fn AABB3D::intersects(a : AABB3D, b : AABB3D) -> Bool {
  !(
    a.max_x < b.min_x ||
    a.min_x > b.max_x ||
    a.max_y < b.min_y ||
    a.min_y > b.max_y ||
    a.max_z < b.min_z ||
    a.min_z > b.max_z
  )
}

///|
/// Check if a point is inside the AABB. / 检查点是否在 AABB 内。
pub fn AABB3D::contains_point(b : AABB3D, p : @core.Point3D) -> Bool {
  p.x >= b.min_x &&
  p.x <= b.max_x &&
  p.y >= b.min_y &&
  p.y <= b.max_y &&
  p.z >= b.min_z &&
  p.z <= b.max_z
}

///|
/// Merge two AABBs into one. / 合并两个 AABB。
pub fn AABB3D::merge(a : AABB3D, b : AABB3D) -> AABB3D {
  {
    min_x: if a.min_x < b.min_x { a.min_x } else { b.min_x },
    min_y: if a.min_y < b.min_y { a.min_y } else { b.min_y },
    min_z: if a.min_z < b.min_z { a.min_z } else { b.min_z },
    max_x: if a.max_x > b.max_x { a.max_x } else { b.max_x },
    max_y: if a.max_y > b.max_y { a.max_y } else { b.max_y },
    max_z: if a.max_z > b.max_z { a.max_z } else { b.max_z },
  }
}

///|
/// Ray-AABB intersection (slab method). Returns t_min, t_max or None. / 射线-AABB 相交（slab 法），返回 t_min, t_max 或 None。
pub fn AABB3D::ray_intersect(
  b : AABB3D,
  origin : @core.Point3D,
  dir : @core.Point3D,
) -> Option[(Double, Double)] {
  let mut t_min = -1.7976931348623157e+308
  let mut t_max = 1.7976931348623157e+308
  let oarr = [origin.x, origin.y, origin.z]
  let darr = [dir.x, dir.y, dir.z]
  let lo_arr = [b.min_x, b.min_y, b.min_z]
  let hi_arr = [b.max_x, b.max_y, b.max_z]
  for i in 0..<3 {
    if darr[i].abs() < 0.0000000001 {
      if oarr[i] < lo_arr[i] || oarr[i] > hi_arr[i] {
        return None
      }
    } else {
      let inv_d = 1.0 / darr[i]
      let mut t1 = (lo_arr[i] - oarr[i]) * inv_d
      let mut t2 = (hi_arr[i] - oarr[i]) * inv_d
      if t1 > t2 {
        let tmp = t1
        t1 = t2
        t2 = tmp
      }
      if t1 > t_min {
        t_min = t1
      }
      if t2 < t_max {
        t_max = t2
      }
      if t_min > t_max {
        return None
      }
    }
  }
  Some((t_min, t_max))
}