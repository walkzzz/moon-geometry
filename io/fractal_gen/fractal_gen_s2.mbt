///| Return Mandelbrot escape iteration count for parameter c. / 返回参数 c 的 Mandelbrot 逃逸迭代次数。
pub fn mandelbrot_escape(cx : Double, cy : Double, max_iter : Int) -> Int {
  let mut x = 0.0
  let mut y = 0.0
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
