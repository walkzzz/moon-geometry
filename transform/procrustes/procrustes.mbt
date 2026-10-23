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
