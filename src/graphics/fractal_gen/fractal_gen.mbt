///| Fractal Generation | 分形生成
///| L-systems, IFS, Mandelbrot/Julia set iteration
///| L-系统、迭代函数系统、Mandelbrot/Julia 集迭代

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

pub fn julia_escape(zx : Double, zy : Double, cx : Double, cy : Double, max_iter : Int) -> Int {
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

pub fn fractal_dimension_box(counts : Array[(Double, Int)]) -> Double {
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

pub fn koch_curve_length(iteration : Int, base_length : Double) -> Double {
  base_length * @math.pow(4.0 / 3.0, iteration.to_double())
}
