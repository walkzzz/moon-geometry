///| Geometric Probability | 几何概率
///| Buffon's needle, geometric random variables, Bertrand paradox
///| Buffon 投针、几何随机变量、Bertrand 悖论

///| Compute Buffon's needle crossing probability. / 计算 Buffon 投针相交概率。
pub fn buffon_needle_probability(needle_length : Double, line_spacing : Double) -> Double {
  2.0 * needle_length / (@math.PI * line_spacing)
}

///| Return Bertrand's chord probability for a given construction mode. / 返回给定构造模式下 Bertrand 弦概率。
pub fn bertrand_probability(mode : Int) -> Double {
  if mode == 1 {
    1.0 / 3.0
  } else if mode == 2 {
    1.0 / 4.0
  } else {
    1.0 / 2.0
  }
}

///| Return the diameter as the random chord length. / 返回直径作为随机弦长。
pub fn random_chord_length(radius : Double) -> Double {
  2.0 * radius
}

///| Compute the hit probability as a target-to-total area ratio. / 以目标与总面积比计算命中概率。
pub fn geometric_probability_hit(area_target : Double, area_total : Double) -> Double {
  area_target / area_total
}

///| Return the expected distance between two random points in the unit square. / 返回单位正方形内两随机点的期望距离。
pub fn expected_distance_unit_square() -> Double {
  (2.0 + 2.0 * 1.4142135623730951) / 15.0
}

///| Compute the probability of covering after n independent trials. / 计算 n 次独立试验后的覆盖概率。
pub fn coverage_probability(n : Int, area_ratio : Double) -> Double {
  1.0 - @math.pow(1.0 - area_ratio, n.to_double())
}
