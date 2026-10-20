///|
/// # Trust Region Method
/// # 信赖域方法
///
/// Trust region optimization with dogleg and Steihaug-CG.
/// 信赖域优化，含狗腿法和Steihaug-CG。

///|
pub struct TrustRegionConfig {
  max_radius : Double
  eta : Double
  max_iter : Int
}

///|
pub fn TrustRegionConfig::new(max_radius : Double, eta : Double, max_iter : Int) -> TrustRegionConfig {
  { max_radius, eta, max_iter }
}

///|
/// Trust region ratio: actual reduction / predicted reduction. / 信赖域比值：实际下降/预测下降。
pub fn trust_region_ratio(actual : Double, predicted : Double) -> Double {
  if predicted.abs() < 0.000000000001 {
    return 0.0
  }
  actual / predicted
}

///|
/// Update trust region radius. / 更新信赖域半径。
pub fn update_radius(radius : Double, ratio : Double, max_radius : Double) -> Double {
  if ratio < 0.25 {
    radius * 0.25
  } else if ratio > 0.75 {
    if radius * 2.0 < max_radius { radius * 2.0 } else { max_radius }
  } else {
    radius
  }
}

///|
pub fn trust_region_converged(gradient_norm : Double, threshold : Double) -> Bool {
  gradient_norm < threshold
}
