/// |
/// # Hough Transform
/// # 霍夫变换
///
/// Detect lines and circles in point sets using the Hough transform.
/// 使用霍夫变换检测点集中的直线和圆。
///
/// ## Complexity: O(n * theta_max * rho_max) for line detection
/// ## 复杂度: 直线检测 O(n * theta_max * rho_max)

/// |
/// Detected line in Hough space (theta, rho) representation.
/// 霍夫空间中检测到的直线（theta, rho）表示。
pub struct HoughLine {
  theta : Double
  rho : Double
  votes : Int
}


///| Construct a HoughLine from theta, rho, and votes. / 由 theta、rho 与投票数构造 HoughLine。
pub fn HoughLine::new(
  theta : Double,
  rho : Double,
  votes : Int,
) -> HoughLine {
  { theta, rho, votes }
}

/// |
/// Detected circle from Hough transform.
/// 霍夫变换检测到的圆。
pub struct HoughCircle {
  cx : Double
  cy : Double
  radius : Double
  votes : Int
}
