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

///|
fn welzl(
  pts : Array[@core.Point3D],
  n : Int32,
  end : Int32,
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
