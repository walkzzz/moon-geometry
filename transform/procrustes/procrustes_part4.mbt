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
