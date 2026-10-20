///| Discrete Differential Geometry | 离散微分几何
///| Discrete connections, holonomy, parallel transport on meshes
///| 离散联络、和乐、网格上的平行移动

pub fn discrete_connection(edges : Array[Double]) -> Double {
  let mut total = 0.0
  for e in edges {
    total += e
  }
  total
}

pub fn holonomy(angles : Array[Double]) -> Double {
  let mut total = 0.0
  for a in angles {
    total += a
  }
  total % (2.0 * @math.PI)
}

pub fn parallel_transport(vx : Double, vy : Double, angle : Double) -> (Double, Double) {
  let c = @math.cos(angle)
  let s = @math.sin(angle)
  (vx * c - vy * s, vx * s + vy * c)
}

pub fn discrete_curvature2d(angles : Array[Double]) -> Double {
  let mut sum = 0.0
  for a in angles {
    sum += a
  }
  2.0 * @math.PI - sum
}

pub fn gauss_map_normals(angles : Array[Double]) -> Array[Double] {
  let result = Array::make(angles.length(), 0.0)
  let mut cumul = 0.0
  for i in 0..<angles.length() {
    cumul += angles[i]
    result[i] = cumul
  }
  result
}
