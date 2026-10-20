///| Geometric Probability | 几何概率
///| Buffon's needle, geometric random variables, Bertrand paradox
///| Buffon 投针、几何随机变量、Bertrand 悖论

pub fn buffon_needle_probability(needle_length : Double, line_spacing : Double) -> Double {
  2.0 * needle_length / (@math.PI * line_spacing)
}

pub fn bertrand_probability(method : Int) -> Double {
  if method == 1 {
    1.0 / 3.0
  } else if method == 2 {
    1.0 / 4.0
  } else {
    1.0 / 2.0
  }
}

pub fn random_chord_length(radius : Double) -> Double {
  2.0 * radius
}

pub fn geometric_probability_hit(area_target : Double, area_total : Double) -> Double {
  area_target / area_total
}

pub fn expected_distance_unit_square() -> Double {
  (2.0 + 2.0 * 1.4142135623730951) / 15.0
}

pub fn coverage_probability(n : Int, area_ratio : Double) -> Double {
  1.0 - @math.pow(1.0 - area_ratio, n.to_double())
}
