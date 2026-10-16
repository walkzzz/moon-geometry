/// |
/// # Numerical Differentiation
/// # 数值微分
///
/// Numerical differentiation using finite differences.
/// 使用有限差分的数值微分。
///
/// ## Complexity: O(1) per evaluation
/// ## 复杂度: 每次求值 O(1)

/// |
/// First derivative using forward difference.
/// 使用前向差分求一阶导数。
pub fn forward_diff(f : (Double) -> Double, x : Double, h : Double) -> Double {
  (f(x + h) - f(x)) / h
}

/// |
/// First derivative using central difference.
/// 使用中心差分求一阶导数。
pub fn central_diff(f : (Double) -> Double, x : Double, h : Double) -> Double {
  (f(x + h) - f(x - h)) / (2.0 * h)
}

/// |
/// Second derivative using central difference.
/// 使用中心差分求二阶导数。
pub fn second_diff(f : (Double) -> Double, x : Double, h : Double) -> Double {
  (f(x + h) - 2.0 * f(x) + f(x - h)) / (h * h)
}

/// |
/// Gradient of a 2D function.
/// 二元函数的梯度。
pub fn gradient(
  f : (Double, Double) -> Double,
  x : Double,
  y : Double,
  h : Double,
) -> (Double, Double) {
  let dfx = (f(x + h, y) - f(x - h, y)) / (2.0 * h)
  let dfy = (f(x, y + h) - f(x, y - h)) / (2.0 * h)
  (dfx, dfy)
}

/// |
/// Laplacian of a 2D function.
/// 二元函数的拉普拉斯算子。
pub fn laplacian(
  f : (Double, Double) -> Double,
  x : Double,
  y : Double,
  h : Double,
) -> Double {
  let fxx = (f(x + h, y) - 2.0 * f(x, y) + f(x - h, y)) / (h * h)
  let fyy = (f(x, y + h) - 2.0 * f(x, y) + f(x, y - h)) / (h * h)
  fxx + fyy
}