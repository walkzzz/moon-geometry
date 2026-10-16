///|
/// # Procrustes Analysis
/// # Procrustes 分析
///
/// Least-squares rigid alignment (rotation + translation + scale) of point sets.
/// 点集的最小二乘刚体对齐（旋转 + 平移 + 缩放）。
///
/// ## Complexity: O(n)
/// ## 复杂度: O(n)

///|
/// Result of Procrustes alignment. / Procrustes 对齐结果。
pub struct ProcrustesResult {
  rotation : Double
  tx : Double
  ty : Double
  scale : Double
  error : Double
}

///|
/// Construct Procrustes result. / 构造 Procrustes 结果。
pub fn ProcrustesResult::new(
  rotation : Double,
  tx : Double,
  ty : Double,
  scale : Double,
  error : Double,
) -> ProcrustesResult {
  { rotation, tx, ty, scale, error, }
}

///|
/// Rotation angle accessor. / 旋转角度访问器。
pub fn ProcrustesResult::rotation(self : ProcrustesResult) -> Double {
  self.rotation
}

///|
/// X translation accessor. / X 平移访问器。
pub fn ProcrustesResult::tx(self : ProcrustesResult) -> Double {
  self.tx
}

///|
/// Y translation accessor. / Y 平移访问器。
pub fn ProcrustesResult::ty(self : ProcrustesResult) -> Double {
  self.ty
}

///|
/// Scale accessor. / 缩放访问器。
pub fn ProcrustesResult::scale(self : ProcrustesResult) -> Double {
  self.scale
}

///|
/// Error accessor. / 误差访问器。
pub fn ProcrustesResult::error(self : ProcrustesResult) -> Double {
  self.error
}

///|
/// Centroid of a point set. / 点集质心。
fn centroid(points : Array[@core.Point2D]) -> @core.Point2D {
  let n = points.length()
  if n == 0 {
    return @core.Point2D::new(0.0, 0.0)
  }
  let mut sx = 0.0
  let mut sy = 0.0
  for p in points {
    sx += p.x()
    sy += p.y()
  }
  @core.Point2D::new(sx / n.to_double(), sy / n.to_double())
}

///|
/// Procrustes alignment: find rotation, translation, scale minimizing
/// sum ||tgt_i - (s * R * src_i + t)||^2.
/// Procrustes 对齐：求使 sum ||tgt_i - (s*R*src_i + t)||^2 最小的旋转、平移、缩放。
pub fn procrustes(
  src : Array[@core.Point2D],
  tgt : Array[@core.Point2D],
) -> ProcrustesResult {
  let n = src.length()
  if n == 0 || n != tgt.length() {
    return ProcrustesResult::new(0.0, 0.0, 0.0, 1.0, 0.0)
  }
  let src_c = centroid(src)
  let tgt_c = centroid(tgt)
  let mut num = 0.0
  let mut den = 0.0
  let mut src_norm_sq = 0.0
  let mut tgt_norm_sq = 0.0
  for i in 0..<n {
    let dx = src[i].x() - src_c.x()
    let dy = src[i].y() - src_c.y()
    let ex = tgt[i].x() - tgt_c.x()
    let ey = tgt[i].y() - tgt_c.y()
    num += dx * ey - dy * ex
    den += dx * ex + dy * ey
    src_norm_sq += dx * dx + dy * dy
    tgt_norm_sq += ex * ex + ey * ey
  }
  let rotation = if den.abs() < 0.000000000001 && num.abs() < 0.000000000001 {
    0.0
  } else {
    @math.atan2(num, den)
  }
  let scale = if src_norm_sq < 0.000000000001 {
    1.0
  } else {
    (tgt_norm_sq / src_norm_sq).sqrt()
  }
  let c = @math.cos(rotation)
  let s = @math.sin(rotation)
  let tx = tgt_c.x() - scale * (c * src_c.x() - s * src_c.y())
  let ty = tgt_c.y() - scale * (s * src_c.x() + c * src_c.y())
  let mut err_sq = 0.0
  for i in 0..<n {
    let px = scale * (c * src[i].x() - s * src[i].y()) + tx
    let py = scale * (s * src[i].x() + c * src[i].y()) + ty
    let dx = tgt[i].x() - px
    let dy = tgt[i].y() - py
    err_sq += dx * dx + dy * dy
  }
  let error = (err_sq / n.to_double()).sqrt()
  ProcrustesResult::new(rotation, tx, ty, scale, error)
}

///|
/// Apply Procrustes transformation to a point set.
/// 对点集应用 Procrustes 变换。
pub fn procrustes_apply(
  src : Array[@core.Point2D],
  result : ProcrustesResult,
) -> Array[@core.Point2D] {
  let c = @math.cos(result.rotation)
  let s = @math.sin(result.rotation)
  let sc = result.scale
  let result_arr : Array[@core.Point2D] = []
  for p in src {
    let px = sc * (c * p.x() - s * p.y()) + result.tx
    let py = sc * (s * p.x() + c * p.y()) + result.ty
    result_arr.push(@core.Point2D::new(px, py))
  }
  result_arr
}

///|
/// Procrustes distance (error) between two point sets.
/// 两个点集间的 Procrustes 距离（误差）。
pub fn procrustes_error(
  src : Array[@core.Point2D],
  tgt : Array[@core.Point2D],
) -> Double {
  procrustes(src, tgt).error
}

///|
/// Generalized Procrustes analysis: align multiple shapes to a common reference.
/// 广义 Procrustes 分析：将多个形状对齐到公共参考。
///
/// Returns aligned shapes (each centered and rotated to reference).
/// 返回对齐后的形状（每个已居中并旋转到参考）。
pub fn procrustes_analyze(
  shapes : Array[Array[@core.Point2D]],
  max_iter : Int,
) -> Array[Array[@core.Point2D]] {
  let n_shapes = shapes.length()
  if n_shapes == 0 {
    return []
  }
  let aligned : Array[Array[@core.Point2D]] = []
  for shape in shapes {
    let c = centroid(shape)
    let centered : Array[@core.Point2D] = []
    for p in shape {
      centered.push(p.sub(c))
    }
    aligned.push(centered)
  }
  for _ in 0..<max_iter {
    let n = aligned[0].length()
    let ref_shape : Array[@core.Point2D] = Array::make(n, @core.Point2D::new(0.0, 0.0))
    for shape in aligned {
      for i in 0..<n {
        ref_shape[i] = @core.Point2D::new(
          ref_shape[i].x() + shape[i].x(),
          ref_shape[i].y() + shape[i].y(),
        )
      }
    }
    let nd = n_shapes.to_double()
    for i in 0..<n {
      ref_shape[i] = @core.Point2D::new(ref_shape[i].x() / nd, ref_shape[i].y() / nd)
    }
    for k in 0..<n_shapes {
      let result = procrustes(aligned[k], ref_shape)
      aligned[k] = procrustes_apply(aligned[k], result)
    }
  }
  aligned
}