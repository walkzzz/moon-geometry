///|
/// Return Julia set escape iteration count for initial z and parameter c. / 返回初始 z 与参数 c 的 Julia 集逃逸迭代次数。
pub fn julia_escape(
  zx : Double,
  zy : Double,
  cx : Double,
  cy : Double,
  max_iter : Int32,
) -> Int32 {
  let mut x = zx
  let mut y = zy
  let mut iter = 0
  while iter < max_iter {
    let x2 = x * x
    let y2 = y * y
    if x2 + y2 > 4.0 {
      break
    }
    let xnew = x2 - y2 + cx
    y = 2.0 * x * y + cy
    x = xnew
    iter += 1
  }
  iter
}
