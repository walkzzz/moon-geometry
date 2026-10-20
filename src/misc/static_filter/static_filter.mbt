///| Static Filtering | 静态过滤
///| Precomputed error bounds for fast predicate filtering
///| 预计算误差界用于快速谓词过滤

pub fn epsilon_bound(n : Int) -> Double {
  @math.pow(2.0, -52.0) * n.to_double()
}

pub fn coord_max_bound(coords : Array[Double]) -> Double {
  let mut m = 0.0
  for c in coords {
    let a = c.abs()
    if a > m {
      m = a
    }
  }
  m
}

pub fn orient2d_bound(max_coord : Double) -> Double {
  let delta = 3.0 * @math.pow(2.0, -52.0)
  delta * max_coord * max_coord
}

pub fn incircle_bound(max_coord : Double) -> Double {
  let delta = 13.0 * @math.pow(2.0, -52.0)
  delta * max_coord * max_coord * max_coord * max_coord
}

pub fn filter_pass(det : Double, bound : Double) -> Bool {
  det.abs() > bound
}
