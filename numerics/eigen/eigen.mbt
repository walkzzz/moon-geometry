/// |
/// # Eigenvalue Computation
/// # 特征值计算
///
/// Eigenvalue computation using power iteration and Jacobi method.
/// 使用幂迭代和 Jacobi 方法的特征值计算。
///
/// ## Complexity: O(n² × iter) for power iteration
/// ## 复杂度: 幂迭代 O(n² × iter)

///|
/// |
/// Power iteration to find largest eigenvalue.
/// 幂迭代查找最大特征值。
///
/// # Arguments / 参数
/// - `matrix`: n × n matrix / n × n 矩阵
/// - `n`: matrix size / 矩阵大小
/// - `max_iter`: maximum iterations / 最大迭代数
pub fn power_iteration(
  matrix : Array[Array[Double]],
  n : Int32,
  max_iter : Int32,
) -> Double {
  let v : Array[Double] = []
  for _ in 0..<n {
    v.push(1.0)
  }
  let norm0 = vec_norm(v, n)
  for i in 0..<n {
    v[i] /= norm0
  }
  let mut eigenvalue = 0.0
  for _ in 0..<max_iter {
    let av = mat_vec_mul(matrix, v, n)
    eigenvalue = dot(v, av, n)
    let norm = vec_norm(av, n)
    if norm < 0.0000000001 {
      break
    }
    for i in 0..<n {
      v[i] = av[i] / norm
    }
  }
  eigenvalue
}

///|
/// |
/// Find all eigenvalues using Jacobi rotation (for symmetric matrices).
/// 使用 Jacobi 旋转查找所有特征值（对称矩阵）。
pub fn jacobi_eigenvalues(
  matrix : Array[Array[Double]],
  n : Int32,
  max_iter : Int32,
) -> Array[Double] {
  let a : Array[Array[Double]] = []
  for i in 0..<n {
    let row : Array[Double] = []
    for j in 0..<n {
      row.push(matrix[i][j])
    }
    a.push(row)
  }
  for _ in 0..<max_iter {
    let mut p = 0
    let mut q = 1
    let mut max_val = 0.0
    for i in 0..<n {
      for j in (i + 1)..<n {
        if a[i][j].abs() > max_val {
          max_val = a[i][j].abs()
          p = i
          q = j
        }
      }
    }
    if max_val < 0.0000000001 {
      break
    }
    let theta = 0.5 * @math.atan2(2.0 * a[p][q], a[p][p] - a[q][q])
    let c = @math.cos(theta)
    let s = @math.sin(theta)
    let app = a[p][p]
    let aqq = a[q][q]
    let apq = a[p][q]
    a[p][p] = app * c * c + aqq * s * s + 2.0 * apq * c * s
    a[q][q] = app * s * s + aqq * c * c - 2.0 * apq * c * s
    a[p][q] = 0.0
    a[q][p] = 0.0
    for i in 0..<n {
      if i != p && i != q {
        let aip = a[i][p]
        let aiq = a[i][q]
        a[i][p] = aip * c + aiq * s
        a[p][i] = a[i][p]
        a[i][q] = -aip * s + aiq * c
        a[q][i] = a[i][q]
      }
    }
  }
  let eigenvalues : Array[Double] = []
  for i in 0..<n {
    eigenvalues.push(a[i][i])
  }
  eigenvalues
}

///|
/// |
/// Compute trace of a matrix.
/// 计算矩阵的迹。
pub fn matrix_trace(matrix : Array[Array[Double]], n : Int32) -> Double {
  let mut sum = 0.0
  for i in 0..<n {
    sum += matrix[i][i]
  }
  sum
}

///|
fn mat_vec_mul(
  matrix : Array[Array[Double]],
  v : Array[Double],
  n : Int32,
) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<n {
    let mut sum = 0.0
    for j in 0..<n {
      sum += matrix[i][j] * v[j]
    }
    result.push(sum)
  }
  result
}

///|
fn dot(a : Array[Double], b : Array[Double], n : Int32) -> Double {
  let mut sum = 0.0
  for i in 0..<n {
    sum += a[i] * b[i]
  }
  sum
}

///|
fn vec_norm(v : Array[Double], n : Int32) -> Double {
  let mut sum = 0.0
  for i in 0..<n {
    sum += v[i] * v[i]
  }
  sum.sqrt()
}
