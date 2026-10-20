///|
/// # Semidefinite Programming
/// # 半定规划
///
/// SDP relaxation and primal-dual interior point method.
/// SDP松弛与原始-对偶内点法。

///|
pub struct SdpConfig {
  max_iter : Int
  tol : Double
}

///|
pub fn SdpConfig::new(max_iter : Int, tol : Double) -> SdpConfig {
  { max_iter, tol }
}

///|
/// Check positive semidefiniteness via eigenvalues. / 通过特征值检查半正定性。
pub fn is_psd(eigenvalues : Array[Double]) -> Bool {
  for i in 0..<eigenvalues.length() {
    if eigenvalues[i] < -0.000000000001 {
      return false
    }
  }
  true
}

///|
/// Trace of a matrix (sum of diagonal). / 矩阵的迹（对角和）。
pub fn matrix_trace(m : Array[Array[Double]]) -> Double {
  let mut trace = 0.0
  for i in 0..<m.length() {
    if i < m[i].length() {
      trace += m[i][i]
    }
  }
  trace
}

///|
/// Frobenius norm of a matrix. / 矩阵Frobenius范数。
pub fn frobenius_norm(m : Array[Array[Double]]) -> Double {
  let mut sum = 0.0
  for i in 0..<m.length() {
    for j in 0..<m[i].length() {
      sum += m[i][j] * m[i][j]
    }
  }
  sum.sqrt()
}
