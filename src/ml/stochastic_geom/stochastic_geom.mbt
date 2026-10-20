///| Stochastic Geometry | 随机几何
///| Poisson point processes, random tessellations, Boolean models
///| Poisson 点过程、随机镶嵌、Boolean 模型

pub fn poisson_point_count(intensity : Double, area : Double) -> Double {
  intensity * area
}

pub fn poisson_probability(k : Int, intensity : Double, area : Double) -> Double {
  let lambda = intensity * area
  let lambda_k = @math.pow(lambda, k.to_double())
  let exp_neg = @math.exp(-lambda)
  let k_fact = (fn(n : Int) -> Double {
    let mut r = 1.0
    for i in 1..=n {
      r *= i.to_double()
    }
    r
  })(k)
  lambda_k * exp_neg / k_fact
}

pub fn boolean_model_coverage(intensity : Double, grain_area : Double) -> Double {
  1.0 - @math.exp(-intensity * grain_area)
}

pub fn voronoi_cell_expected_area(intensity : Double) -> Double {
  1.0 / intensity
}

pub fn random_tessellation_edge_density(intensity : Double) -> Double {
  2.0 * intensity.sqrt()
}
