///| Fractal Generation | 分形生成

///| L-systems, IFS, Mandelbrot/Julia set iteration

///| L-系统、迭代函数系统、Mandelbrot/Julia 集迭代

///|
/// Return Mandelbrot escape iteration count for parameter c. / 返回参数 c 的 Mandelbrot 逃逸迭代次数。
pub fn mandelbrot_escape(cx : Double, cy : Double, max_iter : Int32) -> Int32 {
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

///|
/// Return maximum absolute scale as IFS contractive factor. / 返回最大绝对缩放因子作为 IFS 压缩因子。
pub fn ifs_contractive_factor(scales : Array[Double]) -> Double {
  let mut max_s = 0.0
  for s in scales {
    let a = s.abs()
    if a > max_s {
      max_s = a
    }
  }
  max_s
}

///|
/// Estimate fractal box-counting dimension from count samples. / 由计数样本估计分形盒计数维数。
pub fn fractal_dimension_box(counts : Array[(Double, Int32)]) -> Double {
  if counts.length() < 2 {
    return 0.0
  }
  let p1 = counts[0]
  let p2 = counts[counts.length() - 1]
  let log_n1 = @math.ln(p1.1.to_double())
  let log_n2 = @math.ln(p2.1.to_double())
  let log_e1 = @math.ln(1.0 / p1.0)
  let log_e2 = @math.ln(1.0 / p2.0)
  (log_n2 - log_n1) / (log_e2 - log_e1)
}

///|
/// Compute Koch curve length at given iteration from base length. / 由基础长度计算给定迭代次数的 Koch 曲线长度。
pub fn koch_curve_length(iteration : Int32, base_length : Double) -> Double {
  base_length * @math.pow(4.0 / 3.0, iteration.to_double())
}
