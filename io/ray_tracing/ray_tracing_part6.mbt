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