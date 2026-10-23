///|
/// Compute OBB from points using PCA. / 使用 PCA 从点集计算 OBB。
pub fn obb_from_points(points : Array[@core.Point3D]) -> OBB {
  let n = points.length()
  if n == 0 {
    return {
      center: @core.Point3D::new(0.0, 0.0, 0.0),
      axes: [
        @core.Point3D::new(1.0, 0.0, 0.0),
        @core.Point3D::new(0.0, 1.0, 0.0),
        @core.Point3D::new(0.0, 0.0, 1.0),
      ],
      half_extents: [0.0, 0.0, 0.0],
    }
  }
  let mut cx = 0.0
  let mut cy = 0.0
  let mut cz = 0.0
  for p in points {
    cx += p.x
    cy += p.y
    cz += p.z
  }
  cx = cx / n.to_double()
  cy = cy / n.to_double()
  cz = cz / n.to_double()
  let mut c00 = 0.0
  let mut c01 = 0.0
  let mut c02 = 0.0
  let mut c11 = 0.0
  let mut c12 = 0.0
  let mut c22 = 0.0
  for p in points {
    let dx = p.x - cx
    let dy = p.y - cy
    let dz = p.z - cz
    c00 += dx * dx
    c01 += dx * dy
    c02 += dx * dz
    c11 += dy * dy
    c12 += dy * dz
    c22 += dz * dz
  }
  c00 = c00 / n.to_double()
  c01 = c01 / n.to_double()
  c02 = c02 / n.to_double()
  c11 = c11 / n.to_double()
  c12 = c12 / n.to_double()
  c22 = c22 / n.to_double()
  let (_eigenvalues, eigenvectors) = jacobi_eigen_3x3(c00, c01, c02, c11, c12, c22)
  let axes = eigenvectors
  let mut min0 : Option[Double] = None
  let mut max0 : Option[Double] = None
  let mut min1 : Option[Double] = None
  let mut max1 : Option[Double] = None
  let mut min2 : Option[Double] = None
  let mut max2 : Option[Double] = None
  for p in points {
    let dx = p.x - cx
    let dy = p.y - cy
    let dz = p.z - cz
    let p0 = dx * axes[0].x + dy * axes[0].y + dz * axes[0].z
    let p1 = dx * axes[1].x + dy * axes[1].y + dz * axes[1].z
    let p2 = dx * axes[2].x + dy * axes[2].y + dz * axes[2].z
    match min0 {
      Some(v) => if p0 < v { min0 = Some(p0) }
      None => min0 = Some(p0)
    }
    match max0 {
      Some(v) => if p0 > v { max0 = Some(p0) }
      None => max0 = Some(p0)
    }
    match min1 {
      Some(v) => if p1 < v { min1 = Some(p1) }
      None => min1 = Some(p1)
    }
    match max1 {
      Some(v) => if p1 > v { max1 = Some(p1) }
      None => max1 = Some(p1)
    }
    match min2 {
      Some(v) => if p2 < v { min2 = Some(p2) }
      None => min2 = Some(p2)
    }
    match max2 {
      Some(v) => if p2 > v { max2 = Some(p2) }
      None => max2 = Some(p2)
    }
  }
  let he0 = match (min0, max0) {
    (Some(a), Some(b)) => (b - a) / 2.0
    _ => 0.0
  }
  let he1 = match (min1, max1) {
    (Some(a), Some(b)) => (b - a) / 2.0
    _ => 0.0
  }
  let he2 = match (min2, max2) {
    (Some(a), Some(b)) => (b - a) / 2.0
    _ => 0.0
  }
  let c0 = match (min0, max0) {
    (Some(a), Some(b)) => (a + b) / 2.0
    _ => 0.0
  }
  let c1 = match (min1, max1) {
    (Some(a), Some(b)) => (a + b) / 2.0
    _ => 0.0
  }
  let c2 = match (min2, max2) {
    (Some(a), Some(b)) => (a + b) / 2.0
    _ => 0.0
  }
  let center = @core.Point3D::new(
    cx + c0 * axes[0].x + c1 * axes[1].x + c2 * axes[2].x,
    cy + c0 * axes[0].y + c1 * axes[1].y + c2 * axes[2].y,
    cz + c0 * axes[0].z + c1 * axes[1].z + c2 * axes[2].z,
  )
  { center, axes, half_extents: [he0, he1, he2] }
}
