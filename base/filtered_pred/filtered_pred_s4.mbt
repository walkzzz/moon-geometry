///| Sign of det if above bound, else 0. / 行列式超过误差界时返回符号，否则返回 0。
pub fn filter_result(det : Double, bound : Double) -> Int {
  if det.abs() > bound {
    if det > 0.0 { 1 } else { -1 }
  } else {
    0
  }
}
