/// |
/// # Numerical Integration
/// # 数值积分
///
/// Numerical integration using trapezoid, Simpson, and Monte Carlo methods.
/// 使用梯形、Simpson 和蒙特卡洛方法的数值积分。
///
/// ## Complexity: O(n) for n subdivisions
/// ## 复杂度: O(n)，n = 细分数

/// |
/// Trapezoid rule integration.
/// 梯形法积分。
pub fn trapezoid(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  n : Int,
) -> Double {
  let h = (hi - lo) / n.to_double()
  let mut sum = (f(lo) + f(hi)) / 2.0
  for i in 1..<n {
    sum += f(lo + i.to_double() * h)
  }
  sum * h
}

/// |
/// Simpson's rule integration.
/// Simpson 法积分。
pub fn simpson(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  n : Int,
) -> Double {
  let nn = if n % 2 == 0 { n } else { n + 1 }
  let h = (hi - lo) / nn.to_double()
  let mut sum = f(lo) + f(hi)
  for i in 1..<nn {
    let w = if i % 2 == 0 { 2.0 } else { 4.0 }
    sum += w * f(lo + i.to_double() * h)
  }
  sum * h / 3.0
}

/// |
/// Monte Carlo integration.
/// 蒙特卡洛积分。
pub fn monte_carlo(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  n_samples : Int,
  seed : Int,
) -> Double {
  let mut rng = seed
  let mut sum = 0.0
  for _ in 0..<n_samples {
    rng = (rng * 1103515245 + 12345) % 2147483647
    if rng < 0 {
      rng = -rng
    }
    let u = rng.to_double() / 2147483647.0
    let x = lo + u * (hi - lo)
    sum += f(x)
  }
  sum * (hi - lo) / n_samples.to_double()
}

/// |
/// Adaptive Simpson integration.
/// 自适应 Simpson 积分。
pub fn adaptive_simpson(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  eps : Double,
) -> Double {
  adaptive_impl(f, lo, hi, eps, 20)
}

fn adaptive_impl(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  eps : Double,
  depth : Int,
) -> Double {
  let mid = (lo + hi) / 2.0
  let s_whole = simpson(f, lo, hi, 2)
  let s_left = simpson(f, lo, mid, 2)
  let s_right = simpson(f, mid, hi, 2)
  if depth <= 0 || (s_left + s_right - s_whole).abs() < 15.0 * eps {
    s_left + s_right + (s_left + s_right - s_whole) / 15.0
  } else {
    adaptive_impl(f, lo, mid, eps / 2.0, depth - 1) +
      adaptive_impl(f, mid, hi, eps / 2.0, depth - 1)
  }
}