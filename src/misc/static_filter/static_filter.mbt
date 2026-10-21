///| Static Filtering | 静态过滤
///| Precomputed error bounds for fast predicate filtering
///| 预计算误差界用于快速谓词过滤

///| Compute the epsilon error bound for n operations. / 计算 n 次运算的 epsilon 误差界。
pub fn epsilon_bound(n : Int) -> Double {
  @math.pow(2.0, -52.0) * n.to_double()
}

///| Return the maximum absolute coordinate value. / 返回坐标绝对值的最大值。
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

///| Compute the orientation-2d determinant error bound. / 计算 orient2d 行列式的误差界。
pub fn orient2d_bound(max_coord : Double) -> Double {
  let delta = 3.0 * @math.pow(2.0, -52.0)
  delta * max_coord * max_coord
}

///| Compute the incircle determinant error bound. / 计算 incircle 行列式的误差界。
pub fn incircle_bound(max_coord : Double) -> Double {
  let delta = 13.0 * @math.pow(2.0, -52.0)
  delta * max_coord * max_coord * max_coord * max_coord
}

///| Check whether the determinant passes the filter bound. / 判断行列式是否通过过滤界。
pub fn filter_pass(det : Double, bound : Double) -> Bool {
  det.abs() > bound
}
