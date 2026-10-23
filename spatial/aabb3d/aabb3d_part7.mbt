///|
/// Ray-AABB intersection (slab method). Returns t_min, t_max or None. / 射线-AABB 相交（slab 法），返回 t_min, t_max 或 None。
pub fn AABB3D::ray_intersect(
  b : AABB3D,
  origin : @core.Point3D,
  dir : @core.Point3D,
) -> (Double, Double)? {
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
