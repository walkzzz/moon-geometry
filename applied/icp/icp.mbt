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
  iterations : Int
}


///|
/// Construct ICP result. / 构造 ICP 结果。
pub fn IcpResult::new(
  rotation : Array[Double],
  translation : @core.Point3D,
  error : Double,
  iterations : Int,
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
pub fn IcpResult::iterations(self : IcpResult) -> Int {
  self.iterations
}
