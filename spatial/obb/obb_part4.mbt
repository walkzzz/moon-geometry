///|
/// Surface area of the OBB. / OBB 表面积。
pub impl @core.Measurable3D for OBB with surface_area(self) {
  let a = self.half_extents[0]
  let bb = self.half_extents[1]
  let c = self.half_extents[2]
  8.0 * (a * bb + bb * c + a * c)
}

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