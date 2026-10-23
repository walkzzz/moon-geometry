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
