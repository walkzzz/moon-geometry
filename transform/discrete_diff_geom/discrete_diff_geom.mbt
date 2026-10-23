///| Discrete Differential Geometry | 离散微分几何

///| Discrete connections, holonomy, parallel transport on meshes

///| 离散联络、和乐、网格上的平行移动

///|
/// Sum edge contributions of a discrete connection. / 求和离散联络的边贡献。
pub fn discrete_connection(edges : Array[Double]) -> Double {
  let mut total = 0.0
  for e in edges {
    total += e
  }
  total
}

///|
/// Compute holonomy modulo 2π from turning angles. / 由转角计算模 2π 的和乐。
pub fn holonomy(angles : Array[Double]) -> Double {
  let mut total = 0.0
  for a in angles {
    total += a
  }
  total % (2.0 * @math.PI)
}

///|
/// Parallel transport a 2D vector by a rotation angle. / 按旋转角平行移动二维向量。
pub fn parallel_transport(
  vx : Double,
  vy : Double,
  angle : Double,
) -> (Double, Double) {
  let c = @math.cos(angle)
  let s = @math.sin(angle)
  (vx * c - vy * s, vx * s + vy * c)
}

///|
/// Compute discrete Gaussian curvature of a 2D polygon. / 计算二维多边形的离散高斯曲率。
pub fn discrete_curvature2d(angles : Array[Double]) -> Double {
  let mut sum = 0.0
  for a in angles {
    sum += a
  }
  2.0 * @math.PI - sum
}

///|
/// Cumulative normal angles via Gauss map. / 通过 Gauss 映射累积法向量角。
pub fn gauss_map_normals(angles : Array[Double]) -> Array[Double] {
  let result = Array::make(angles.length(), 0.0)
  let mut cumul = 0.0
  for i in 0..<angles.length() {
    cumul += angles[i]
    result[i] = cumul
  }
  result
}
