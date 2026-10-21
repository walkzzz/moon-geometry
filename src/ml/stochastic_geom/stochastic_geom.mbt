///| Stochastic Geometry | 随机几何
///| Poisson point processes, random tessellations, Boolean models
///| Poisson 点过程、随机镶嵌、Boolean 模型

///| Compute expected Poisson point count as intensity times area. / 计算 Poisson 点过程期望计数（强度乘面积）。
pub fn poisson_point_count(intensity : Double, area : Double) -> Double {
  intensity * area
}

///| Compute Poisson probability of k points in given area. / 计算给定面积内 k 个点的 Poisson 概率。
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

///| Compute Boolean model coverage probability from intensity and grain area. / 由强度与粒面积计算 Boolean 模型覆盖概率。
pub fn boolean_model_coverage(intensity : Double, grain_area : Double) -> Double {
  1.0 - @math.exp(-intensity * grain_area)
}

///| Compute expected Voronoi cell area for given intensity. / 计算给定强度下 Voronoi 单元期望面积。
pub fn voronoi_cell_expected_area(intensity : Double) -> Double {
  1.0 / intensity
}

///| Compute expected edge density of a random tessellation. / 计算随机镶嵌的期望边密度。
pub fn random_tessellation_edge_density(intensity : Double) -> Double {
  2.0 * intensity.sqrt()
}
