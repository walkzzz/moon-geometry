///|
/// # Surface Reconstruction
/// # 曲面重建
///
/// Reconstruct surfaces from 3D point clouds via ball pivoting and alpha shapes.
/// 通过球枢转和 alpha 形从三维点云重建曲面。

///|
/// Simple ball pivoting: for each triple of points with all pairwise distances
/// within 2*radius, add a triangle. Returns (vertices, triangles).
/// 简单球枢转：对所有两两距离不超过 2*radius 的三元组添加三角形。返回 (顶点, 三角形)。
pub fn ball_pivoting(
  points : Array[@core.Point3D],
  radius : Double,
) -> (Array[@core.Point3D], Array[(Int32, Int32, Int32)]) {
  let triangles : Array[(Int32, Int32, Int32)] = []
  let n = points.length()
  let diam = radius * 2.0
  for i in 0..<n {
    if i + 1 >= n {
      break
    }
    for j in (i + 1)..<n {
      let dij = points[i].dist(points[j])
      if dij > diam {
        continue
      }
      if j + 1 >= n {
        break
      }
      for k in (j + 1)..<n {
        let dik = points[i].dist(points[k])
        let djk = points[j].dist(points[k])
        if dik <= diam && djk <= diam {
          triangles.push((i, j, k))
        }
      }
    }
  }
  (points, triangles)
}

///|
/// Simple 3D alpha shape: for each triple of points, compute the circumcircle
/// radius of the triangle; include it if radius <= 1/alpha.
/// Returns (vertices, triangles).
/// 简单三维 alpha 形：对每个三元组计算三角形外接圆半径，若半径 <= 1/alpha 则包含。
/// 返回 (顶点, 三角形)。
pub fn alpha_shape_3d(
  points : Array[@core.Point3D],
  alpha : Double,
) -> (Array[@core.Point3D], Array[(Int32, Int32, Int32)]) {
  let triangles : Array[(Int32, Int32, Int32)] = []
  let n = points.length()
  if alpha <= 0.0 {
    return (points, triangles)
  }
  let r_max = 1.0 / alpha
  for i in 0..<n {
    if i + 1 >= n {
      break
    }
    for j in (i + 1)..<n {
      if j + 1 >= n {
        break
      }
      for k in (j + 1)..<n {
        let r = circumcircle_radius(points[i], points[j], points[k])
        if r <= r_max {
          triangles.push((i, j, k))
        }
      }
    }
  }
  (points, triangles)
}

///|
/// Circumcircle radius of triangle abc. / 三角形 abc 的外接圆半径。
fn circumcircle_radius(
  a : @core.Point3D,
  b : @core.Point3D,
  c : @core.Point3D,
) -> Double {
  let ab = a.dist(b)
  let bc = b.dist(c)
  let ca = c.dist(a)
  let area = triangle_area(a, b, c)
  if area < 0.000000000001 {
    return 1.0 / 0.000000000001
  }
  ab * bc * ca / (4.0 * area)
}

///|
/// Area of triangle abc in 3D. / 三维中三角形 abc 的面积。
fn triangle_area(
  a : @core.Point3D,
  b : @core.Point3D,
  c : @core.Point3D,
) -> Double {
  let ab = b.sub(a)
  let ac = c.sub(a)
  let cr = ab.cross(ac)
  0.5 * (cr.x * cr.x + cr.y * cr.y + cr.z * cr.z).sqrt()
}
