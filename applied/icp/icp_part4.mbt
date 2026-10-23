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
