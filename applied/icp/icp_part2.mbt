///|
/// 3x3 identity matrix. / 3x3 单位矩阵。
fn mat3_identity() -> Array[Double] {
  [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0]
}


///|
/// 3x3 matrix multiply. / 3x3 矩阵乘法。
fn mat3_mul(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let r : Array[Double] = Array::make(9, 0.0)
  for i in 0..<3 {
    for j in 0..<3 {
      let mut s = 0.0
      for k in 0..<3 {
        s += a[i * 3 + k] * b[k * 3 + j]
      }
      r[i * 3 + j] = s
    }
  }
  r
}


///|
/// 3x3 transpose. / 3x3 转置。
fn mat3_transpose(a : Array[Double]) -> Array[Double] {
  [
    a[0], a[3], a[6],
    a[1], a[4], a[7],
    a[2], a[5], a[8],
  ]
}


///|
/// 3x3 matrix times 3D vector. / 3x3 矩阵乘三维向量。
fn mat3_vec(a : Array[Double], v : @core.Point3D) -> @core.Point3D {
  @core.Point3D::new(
    a[0] * v.x + a[1] * v.y + a[2] * v.z,
    a[3] * v.x + a[4] * v.y + a[5] * v.z,
    a[6] * v.x + a[7] * v.y + a[8] * v.z,
  )
}
