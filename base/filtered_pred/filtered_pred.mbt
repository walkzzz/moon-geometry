///| Filtered Predicates | 过滤谓词
///| Static and dynamic filters for robust geometric predicates
///| 静态和动态过滤用于鲁棒几何谓词

///| Static error bound from coordinate magnitudes. / 由坐标幅值计算静态误差界。
pub fn static_filter_bound(coords : Array[Double]) -> Double {
  let mut maxv = 0.0
  for c in coords {
    let a = c.abs()
    if a > maxv {
      maxv = a
    }
  }
  maxv * maxv * maxv * 3.33e-16
}

///| Filtered 2D orientation with static error bound. / 带静态误差界的过滤二维定向判定。
pub fn filtered_orientation(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double) -> Int {
  let det = (bx - ax) * (cy - ay) - (cx - ax) * (by - ay)
  let bound = static_filter_bound([ax, ay, bx, by, cx, cy])
  if det.abs() > bound {
    if det > 0.0 { 1 } else { -1 }
  } else {
    0
  }
}

///| Dynamic filter test: |a| > |b| * eps. / 动态过滤测试 |a| > |b| * eps。
pub fn dynamic_filter(a : Double, b : Double, eps : Double) -> Bool {
  a.abs() > b.abs() * eps
}

///| Sign of det if above bound, else 0. / 行列式超过误差界时返回符号，否则返回 0。
pub fn filter_result(det : Double, bound : Double) -> Int {
  if det.abs() > bound {
    if det > 0.0 { 1 } else { -1 }
  } else {
    0
  }
}
