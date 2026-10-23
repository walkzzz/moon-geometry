///|
/// # ICP Point Cloud Registration
/// # ICP 点云配准
///
/// Point-to-point and point-to-plane ICP with Kabsch/SVD rotation estimation.
/// 点到点和点到面 ICP，使用 Kabsch/SVD 旋转估计。
///
/// ## Complexity: O(iter * n * m) per registration
/// ## 复杂度: 每次配准 O(iter * n * m)

///|
/// Result of ICP registration. / ICP 配准结果。
pub struct IcpResult {
  rotation : Array[Double]
  translation : @core.Point3D
  error : Double
  iterations : Int32
}

///|
/// Construct ICP result. / 构造 ICP 结果。
pub fn IcpResult::new(
  rotation : Array[Double],
  translation : @core.Point3D,
  error : Double,
  iterations : Int32,
) -> IcpResult {
  { rotation, translation, error, iterations, }
}

///|
/// Rotation matrix accessor (3x3 row-major). / 旋转矩阵访问器（3x3 行主序）。
pub fn IcpResult::rotation(self : IcpResult) -> Array[Double] {
  self.rotation
}

///|
/// Translation accessor. / 平移访问器。
pub fn IcpResult::translation(self : IcpResult) -> @core.Point3D {
  self.translation
}

///|
/// Error accessor. / 误差访问器。
pub fn IcpResult::error(self : IcpResult) -> Double {
  self.error
}

///|
/// Iterations accessor. / 迭代次数访问器。
pub fn IcpResult::iterations(self : IcpResult) -> Int32 {
  self.iterations
}

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
  [a[0], a[3], a[6], a[1], a[4], a[7], a[2], a[5], a[8]]
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

///|
/// Kabsch algorithm: optimal rotation aligning src to tgt (both centered).
/// Kabsch 算法：对齐源到目标的最优旋转（均已居中）。
fn kabsch(
  src : Array[@core.Point3D],
  tgt : Array[@core.Point3D],
) -> Array[Double] {
  let n = src.length()
  if n == 0 {
    return mat3_identity()
  }
  let h : Array[Double] = Array::make(9, 0.0)
  for i in 0..<n {
    let px = src[i].x
    let py = src[i].y
    let pz = src[i].z
    let qx = tgt[i].x
    let qy = tgt[i].y
    let qz = tgt[i].z
    h[0] += px * qx
    h[1] += px * qy
    h[2] += px * qz
    h[3] += py * qx
    h[4] += py * qy
    h[5] += py * qz
    h[6] += pz * qx
    h[7] += pz * qy
    h[8] += pz * qz
  }
  let ht = mat3_transpose(h)
  let hth = mat3_mul(ht, h)
  let (eigenvalues, v) = jacobi_eigen(hth)
  let s_inv : Array[Double] = Array::make(9, 0.0)
  for i in 0..<3 {
    let sv = eigenvalues[i]
    if sv > 0.0000000001 {
      s_inv[i * 3 + i] = 1.0 / sv.sqrt()
    }
  }
  let vs_inv = mat3_mul(v, s_inv)
  let u = mat3_mul(h, vs_inv)
  let ut = mat3_transpose(u)
  let r = mat3_mul(v, ut)
  let det = r[0] * (r[4] * r[8] - r[5] * r[7]) -
    r[1] * (r[3] * r[8] - r[5] * r[6]) +
    r[2] * (r[3] * r[7] - r[4] * r[6])
  if det < 0.0 {
    let mut min_idx = 0
    let mut min_val = eigenvalues[0]
    for i in 1..<3 {
      if eigenvalues[i] < min_val {
        min_val = eigenvalues[i]
        min_idx = i
      }
    }
    for k in 0..<3 {
      v[k * 3 + min_idx] = -v[k * 3 + min_idx]
    }
    let vs_inv2 = mat3_mul(v, s_inv)
    let u2 = mat3_mul(h, vs_inv2)
    let ut2 = mat3_transpose(u2)
    return mat3_mul(v, ut2)
  }
  r
}

///|
/// Centroid of 3D point cloud. / 三维点云质心。
fn centroid3d(points : Array[@core.Point3D]) -> @core.Point3D {
  let n = points.length()
  if n == 0 {
    return @core.Point3D::new(0.0, 0.0, 0.0)
  }
  let mut sx = 0.0
  let mut sy = 0.0
  let mut sz = 0.0
  for p in points {
    sx += p.x
    sy += p.y
    sz += p.z
  }
  let nd = n.to_double()
  @core.Point3D::new(sx / nd, sy / nd, sz / nd)
}

///|
/// Find closest point index in target. / 在目标中找最近点索引。
fn closest_idx(target : Array[@core.Point3D], p : @core.Point3D) -> Int32 {
  let mut best = 0
  let mut best_d = 1.7976931348623157e+308
  for j in 0..<target.length() {
    let d = p.dist_sq(target[j])
    if d < best_d {
      best_d = d
      best = j
    }
  }
  best
}

///|
/// Apply rotation and translation to a point. / 对点应用旋转和平移。
fn transform_point(
  rot : Array[Double],
  trans : @core.Point3D,
  p : @core.Point3D,
) -> @core.Point3D {
  mat3_vec(rot, p).add(trans)
}

///|
/// Point-to-point ICP registration.
/// 点到点 ICP 配准。
///
/// # Arguments / 参数
/// - `source`: source point cloud / 源点云
/// - `target`: target point cloud / 目标点云
/// - `max_iter`: maximum iterations / 最大迭代数
pub fn icp_point_to_point(
  source : Array[@core.Point3D],
  target : Array[@core.Point3D],
  max_iter : Int32,
) -> IcpResult {
  let n = source.length()
  if n == 0 || target.length() == 0 {
    return IcpResult::new(
      mat3_identity(),
      @core.Point3D::new(0.0, 0.0, 0.0),
      0.0,
      0,
    )
  }
  let rot = mat3_identity()
  let trans = @core.Point3D::new(0.0, 0.0, 0.0)
  let aligned : Array[@core.Point3D] = []
  for p in source {
    aligned.push(p)
  }
  let mut cur_rot = rot
  let mut cur_trans = trans
  let mut last_error = 1.7976931348623157e+308
  let mut iter_done = 0
  for iter in 0..<max_iter {
    iter_done = iter + 1
    let match_tgt : Array[@core.Point3D] = []
    let match_idx : Array[Int32] = []
    for p in aligned {
      let j = closest_idx(target, p)
      match_idx.push(j)
      match_tgt.push(target[j])
    }
    let src_c = centroid3d(aligned)
    let tgt_c = centroid3d(match_tgt)
    let src_centered : Array[@core.Point3D] = []
    let tgt_centered : Array[@core.Point3D] = []
    for i in 0..<n {
      src_centered.push(aligned[i].sub(src_c))
      tgt_centered.push(match_tgt[i].sub(tgt_c))
    }
    let r = kabsch(src_centered, tgt_centered)
    let t = tgt_c.sub(mat3_vec(r, src_c))
    cur_rot = mat3_mul(r, cur_rot)
    cur_trans = mat3_vec(r, cur_trans).add(t)
    let mut err_sq = 0.0
    for i in 0..<n {
      aligned[i] = transform_point(r, t, aligned[i])
      let d = aligned[i].dist(match_tgt[i])
      err_sq += d * d
    }
    let err = (err_sq / n.to_double()).sqrt()
    if (last_error - err).abs() < 0.0000001 {
      last_error = err
      break
    }
    last_error = err
  }
  IcpResult::new(cur_rot, cur_trans, last_error, iter_done)
}

///|
/// Solve n x n linear system via Gaussian elimination with partial pivoting.
/// 高斯消元法（部分选主元）解 n x n 线性方程组。
fn solve_linear(a : Array[Array[Double]], b : Array[Double]) -> Array[Double]? {
  let n = a.length()
  if n == 0 {
    return Some([])
  }
  let m : Array[Array[Double]] = []
  for i in 0..<n {
    let row : Array[Double] = []
    for j in 0..<n {
      row.push(a[i][j])
    }
    row.push(b[i])
    m.push(row)
  }
  for col in 0..<n {
    let mut pivot = col
    let mut max_val = m[col][col].abs()
    for i in (col + 1)..<n {
      if m[i][col].abs() > max_val {
        max_val = m[i][col].abs()
        pivot = i
      }
    }
    if max_val < 0.000000000001 {
      return None
    }
    if pivot != col {
      let tmp = m[col]
      m[col] = m[pivot]
      m[pivot] = tmp
    }
    for i in (col + 1)..<n {
      let factor = m[i][col] / m[col][col]
      for j in col..<=n {
        m[i][j] = m[i][j] - factor * m[col][j]
      }
    }
  }
  let x : Array[Double] = Array::make(n, 0.0)
  let mut row = n - 1
  while row >= 0 {
    let mut s = m[row][n]
    for j in (row + 1)..<n {
      s = s - m[row][j] * x[j]
    }
    x[row] = s / m[row][row]
    row -= 1
  }
  Some(x)
}

///|
/// Rodrigues' rotation formula: rotation matrix from axis-angle.
/// Rodrigues 旋转公式：由轴角构造旋转矩阵。
fn rodrigues(w : @core.Point3D) -> Array[Double] {
  let angle = (w.x * w.x + w.y * w.y + w.z * w.z).sqrt()
  if angle < 0.000000000001 {
    return mat3_identity()
  }
  let ax = w.x / angle
  let ay = w.y / angle
  let az = w.z / angle
  let c = @math.cos(angle)
  let s = @math.sin(angle)
  let omc = 1.0 - c
  [
    c + ax * ax * omc,
    ax * ay * omc - az * s,
    ax * az * omc + ay * s,
    ay * ax * omc + az * s,
    c + ay * ay * omc,
    ay * az * omc - ax * s,
    az * ax * omc - ay * s,
    az * ay * omc + ax * s,
    c + az * az * omc,
  ]
}

///|
/// Point-to-plane ICP registration.
/// 点到面 ICP 配准。
///
/// # Arguments / 参数
/// - `source`: source point cloud / 源点云
/// - `target`: target point cloud / 目标点云
/// - `normals`: normals of target points / 目标点法向量
/// - `max_iter`: maximum iterations / 最大迭代数
pub fn icp_point_to_plane(
  source : Array[@core.Point3D],
  target : Array[@core.Point3D],
  normals : Array[@core.Point3D],
  max_iter : Int32,
) -> IcpResult {
  let n = source.length()
  if n == 0 || target.length() == 0 {
    return IcpResult::new(
      mat3_identity(),
      @core.Point3D::new(0.0, 0.0, 0.0),
      0.0,
      0,
    )
  }
  let aligned : Array[@core.Point3D] = []
  for p in source {
    aligned.push(p)
  }
  let mut cur_rot = mat3_identity()
  let mut cur_trans = @core.Point3D::new(0.0, 0.0, 0.0)
  let mut last_error = 1.7976931348623157e+308
  let mut iter_done = 0
  for iter in 0..<max_iter {
    iter_done = iter + 1
    let ata : Array[Array[Double]] = []
    for _ in 0..<6 {
      ata.push(Array::make(6, 0.0))
    }
    let atb : Array[Double] = Array::make(6, 0.0)
    let mut err_sq = 0.0
    for i in 0..<n {
      let j = closest_idx(target, aligned[i])
      let nj = normals[j]
      let d = aligned[i].sub(target[j])
      let cross = aligned[i].cross(nj)
      let row = [cross.x, cross.y, cross.z, nj.x, nj.y, nj.z]
      let rhs = -(nj.x * d.x + nj.y * d.y + nj.z * d.z)
      err_sq += rhs * rhs
      for a_idx in 0..<6 {
        for b_idx in 0..<6 {
          ata[a_idx][b_idx] = ata[a_idx][b_idx] + row[a_idx] * row[b_idx]
        }
        atb[a_idx] = atb[a_idx] + row[a_idx] * rhs
      }
    }
    match solve_linear(ata, atb) {
      Some(x) => {
        let w = @core.Point3D::new(x[0], x[1], x[2])
        let t = @core.Point3D::new(x[3], x[4], x[5])
        let r = rodrigues(w)
        cur_rot = mat3_mul(r, cur_rot)
        cur_trans = mat3_vec(r, cur_trans).add(t)
        for i in 0..<n {
          aligned[i] = transform_point(r, t, aligned[i])
        }
      }
      None => continue
    }
    let err = (err_sq / n.to_double()).sqrt()
    if (last_error - err).abs() < 0.0000001 {
      last_error = err
      break
    }
    last_error = err
  }
  IcpResult::new(cur_rot, cur_trans, last_error, iter_done)
}

///|
/// Apply ICP result transformation to a point cloud.
/// 对点云应用 ICP 结果变换。
pub fn icp_apply(
  points : Array[@core.Point3D],
  result : IcpResult,
) -> Array[@core.Point3D] {
  let out : Array[@core.Point3D] = []
  for p in points {
    out.push(transform_point(result.rotation, result.translation, p))
  }
  out
}

///|
/// RMS error between two point clouds (point-to-point).
/// 两个点云间的 RMS 误差（点到点）。
pub fn icp_rms_error(
  source : Array[@core.Point3D],
  target : Array[@core.Point3D],
) -> Double {
  let n = source.length()
  if n == 0 {
    return 0.0
  }
  let mut sum_sq = 0.0
  for i in 0..<n {
    sum_sq += source[i].dist_sq(target[i])
  }
  (sum_sq / n.to_double()).sqrt()
}
