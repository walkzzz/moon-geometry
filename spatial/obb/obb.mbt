///|
/// Oriented Bounding Box in 3D. / 三维定向包围盒。
pub struct OBB {
  center : @core.Point3D
  axes : Array[@core.Point3D]
  half_extents : Array[Double]
}

///|
pub extend OBB with @core.Measurable3D::{volume, surface_area}

///|
/// Construct an OBB. / 构造 OBB。
pub fn OBB::new(
  center : @core.Point3D,
  axes : Array[@core.Point3D],
  half_extents : Array[Double],
) -> OBB {
  { center, axes, half_extents, }
}

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
  let (_eigenvalues, eigenvectors) = jacobi_eigen_3x3(
    c00, c01, c02, c11, c12, c22,
  )
  let axes = eigenvectors
  let mut min0 : Double? = None
  let mut max0 : Double? = None
  let mut min1 : Double? = None
  let mut max1 : Double? = None
  let mut min2 : Double? = None
  let mut max2 : Double? = None
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
  { center, axes, half_extents: [he0, he1, he2], }
}

///|
/// Volume of the OBB. / OBB 体积。
pub impl @core.Measurable3D for OBB with fn volume(self) {
  8.0 * self.half_extents[0] * self.half_extents[1] * self.half_extents[2]
}

///|
/// Surface area of the OBB. / OBB 表面积。
pub impl @core.Measurable3D for OBB with fn surface_area(self) {
  let a = self.half_extents[0]
  let bb = self.half_extents[1]
  let c = self.half_extents[2]
  8.0 * (a * bb + bb * c + a * c)
}

///|
fn jacobi_eigen_3x3(
  m00 : Double,
  m01 : Double,
  m02 : Double,
  m11 : Double,
  m12 : Double,
  m22 : Double,
) -> (Array[Double], Array[@core.Point3D]) {
  let a = Array::make(9, 0.0)
  a[0] = m00
  a[1] = m01
  a[2] = m02
  a[3] = m01
  a[4] = m11
  a[5] = m12
  a[6] = m02
  a[7] = m12
  a[8] = m22
  let v = Array::make(9, 0.0)
  v[0] = 1.0
  v[4] = 1.0
  v[8] = 1.0
  let mut iter = 0
  while iter < 50 {
    let mut off = 0.0
    off += a[1] * a[1]
    off += a[2] * a[2]
    off += a[5] * a[5]
    if off < 0.0000000000000001 {
      break
    }
    let mut p = 0
    let mut max_val = a[1].abs()
    if a[2].abs() > max_val {
      p = 1
      max_val = a[2].abs()
    }
    if a[5].abs() > max_val {
      p = 2
    }
    let (i, j) = match p {
      0 => (0, 1)
      1 => (0, 2)
      _ => (1, 2)
    }
    let app = a[i * 3 + i]
    let aqq = a[j * 3 + j]
    let apq = a[i * 3 + j]
    let phi = 0.5 * @math.atan2(2.0 * apq, app - aqq)
    let c = @math.cos(phi)
    let s = @math.sin(phi)

    a[i * 3 + i] = app * c * c + 2.0 * apq * c * s + aqq * s * s
    a[j * 3 + j] = app * s * s - 2.0 * apq * c * s + aqq * c * c
    a[i * 3 + j] = 0.0
    a[j * 3 + i] = 0.0
    let idxs = [0, 1, 2]
    for k in idxs {
      if k != i && k != j {
        let aik = a[i * 3 + k]
        let ajk = a[j * 3 + k]
        a[i * 3 + k] = aik * c + ajk * s
        a[k * 3 + i] = a[i * 3 + k]
        a[j * 3 + k] = -aik * s + ajk * c
        a[k * 3 + j] = a[j * 3 + k]
      }
    }
    for k in idxs {
      let vik = v[i * 3 + k]
      let vjk = v[j * 3 + k]
      v[i * 3 + k] = vik * c + vjk * s
      v[j * 3 + k] = -vik * s + vjk * c
    }
    iter += 1
  }
  let eigenvalues = [a[0], a[4], a[8]]
  let eigenvectors = [
    @core.Point3D::new(v[0], v[1], v[2]),
    @core.Point3D::new(v[3], v[4], v[5]),
    @core.Point3D::new(v[6], v[7], v[8]),
  ]
  (eigenvalues, eigenvectors)
}
