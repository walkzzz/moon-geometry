///|
/// Jacobi eigendecomposition of 3x3 symmetric matrix.
/// 3x3 对称矩阵的 Jacobi 特征分解。
///
/// Returns (eigenvalues[3], eigenvectors[9] column-major, each column is an eigenvector).
/// 返回 (特征值[3], 特征向量[9] 列主序，每列为一个特征向量)。
fn jacobi_eigen(a : Array[Double]) -> (Array[Double], Array[Double]) {
  let m : Array[Double] = []
  for v in a {
    m.push(v)
  }
  let v : Array[Double] = mat3_identity()
  for _ in 0..<100 {
    let mut max_val = 0.0
    let mut p = 0
    let mut q = 1
    for i in 0..<3 {
      for j in (i + 1)..<3 {
        if m[i * 3 + j].abs() > max_val {
          max_val = m[i * 3 + j].abs()
          p = i
          q = j
        }
      }
    }
    if max_val < 0.000000000001 {
      break
    }
    let app = m[p * 3 + p]
    let aqq = m[q * 3 + q]
    let apq = m[p * 3 + q]
    let theta = 0.5 * @math.atan2(2.0 * apq, app - aqq)
    let c = @math.cos(theta)
    let s = @math.sin(theta)
    let new_app = c * c * app + 2.0 * s * c * apq + s * s * aqq
    let new_aqq = s * s * app - 2.0 * s * c * apq + c * c * aqq
    m[p * 3 + p] = new_app
    m[q * 3 + q] = new_aqq
    m[p * 3 + q] = 0.0
    m[q * 3 + p] = 0.0
    for k in 0..<3 {
      if k != p && k != q {
        let akp = m[k * 3 + p]
        let akq = m[k * 3 + q]
        m[k * 3 + p] = c * akp + s * akq
        m[p * 3 + k] = m[k * 3 + p]
        m[k * 3 + q] = -s * akp + c * akq
        m[q * 3 + k] = m[k * 3 + q]
      }
    }
    for k in 0..<3 {
      let vkp = v[k * 3 + p]
      let vkq = v[k * 3 + q]
      v[k * 3 + p] = c * vkp + s * vkq
      v[k * 3 + q] = -s * vkp + c * vkq
    }
  }
  ([m[0], m[4], m[8]], v)
}
