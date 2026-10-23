///|
/// # Moment Invariants
/// # 矩不变量
///
/// Hu moments (7 invariants) and Zernike moments for shape description.
/// Hu 矩（7 个不变量）和 Zernike 矩用于形状描述。
///
/// ## Complexity: O(n * (p+q)) for moments
/// ## 复杂度: 矩为 O(n * (p+q))

///|
/// Raw (geometric) moment M_pq = sum x^p * y^q.
/// 原始（几何）矩 M_pq = sum x^p * y^q。
pub fn raw_moment(
  points : Array[@core.Point2D],
  p : Int32,
  q : Int32,
) -> Double {
  let mut m = 0.0
  for pt in points {
    m += powi(pt.x(), p) * powi(pt.y(), q)
  }
  m
}

///|
/// Centroid of a point set. / 点集质心。
pub fn centroid(points : Array[@core.Point2D]) -> (@core.Point2D, Double) {
  let m00 = raw_moment(points, 0, 0)
  if m00.abs() < 0.000000000001 {
    return (@core.Point2D::new(0.0, 0.0), 0.0)
  }
  let m10 = raw_moment(points, 1, 0)
  let m01 = raw_moment(points, 0, 1)
  (@core.Point2D::new(m10 / m00, m01 / m00), m00)
}

///|
/// Central moment mu_pq = sum (x-x_bar)^p * (y-y_bar)^q.
/// 中心矩 mu_pq = sum (x-x_bar)^p * (y-y_bar)^q。
pub fn central_moment(
  points : Array[@core.Point2D],
  p : Int32,
  q : Int32,
) -> Double {
  let (c, m00) = centroid(points)
  if m00.abs() < 0.000000000001 {
    return 0.0
  }
  let mut m = 0.0
  for pt in points {
    m += powi(pt.x() - c.x(), p) * powi(pt.y() - c.y(), q)
  }
  m
}

///|
/// Integer power of a double. / Double 的整数幂。
fn powi(base : Double, exp : Int32) -> Double {
  let mut result = 1.0
  for _ in 0..<exp {
    result *= base
  }
  result
}

///|
/// Normalized central moment eta_pq = mu_pq / mu00^(1+(p+q)/2).
/// 归一化中心矩 eta_pq = mu_pq / mu00^(1+(p+q)/2)。
pub fn normalized_moment(
  points : Array[@core.Point2D],
  p : Int32,
  q : Int32,
) -> Double {
  let mu_pq = central_moment(points, p, q)
  let mu00 = central_moment(points, 0, 0)
  if mu00.abs() < 0.000000000001 {
    return 0.0
  }
  let gamma = 1.0 + (p + q).to_double() / 2.0
  mu_pq / @math.pow(mu00.abs(), gamma)
}

///|
/// Hu's seven moment invariants (translation, rotation, scale invariant).
/// Hu 七个矩不变量（平移、旋转、缩放不变）。
///
/// Returns array of 7 values. / 返回 7 个值的数组。
pub fn hu_moments(points : Array[@core.Point2D]) -> Array[Double] {
  let n20 = normalized_moment(points, 2, 0)
  let n02 = normalized_moment(points, 0, 2)
  let n11 = normalized_moment(points, 1, 1)
  let n30 = normalized_moment(points, 3, 0)
  let n03 = normalized_moment(points, 0, 3)
  let n12 = normalized_moment(points, 1, 2)
  let n21 = normalized_moment(points, 2, 1)
  let h1 = n20 + n02
  let h2 = (n20 - n02) * (n20 - n02) + 4.0 * n11 * n11
  let h3 = (n30 - 3.0 * n12) * (n30 - 3.0 * n12) +
    (3.0 * n21 - n03) * (3.0 * n21 - n03)
  let h4 = (n30 + n12) * (n30 + n12) + (n21 + n03) * (n21 + n03)
  let h5 = (n30 - 3.0 * n12) *
    (n30 + n12) *
    ((n30 + n12) * (n30 + n12) - 3.0 * (n21 + n03) * (n21 + n03)) +
    (3.0 * n21 - n03) *
    (n21 + n03) *
    (3.0 * (n30 + n12) * (n30 + n12) - (n21 + n03) * (n21 + n03))
  let h6 = (n20 - n02) * ((n30 + n12) * (n30 + n12) - (n21 + n03) * (n21 + n03)) +
    4.0 * n11 * (n30 + n12) * (n21 + n03)
  let h7 = (3.0 * n21 - n03) *
    (n30 + n12) *
    ((n30 + n12) * (n30 + n12) - 3.0 * (n21 + n03) * (n21 + n03)) -
    (n30 - 3.0 * n12) *
    (n21 + n03) *
    (3.0 * (n30 + n12) * (n30 + n12) - (n21 + n03) * (n21 + n03))
  [h1, h2, h3, h4, h5, h6, h7]
}

///|
/// Zernike radial polynomial R_n^m(r).
/// Zernike 径向多项式 R_n^m(r)。
fn zernike_radial(n : Int32, m : Int32, r : Double) -> Double {
  let mut result = 0.0
  let s_max = (n - m) / 2
  for s in 0..<=s_max {
    let sign = if s % 2 == 0 { 1.0 } else { -1.0 }
    let num = factorial(n - s)
    let den = factorial(s) *
      factorial((n + m) / 2 - s) *
      factorial((n - m) / 2 - s)
    result += sign * num / den * powi(r, n - 2 * s)
  }
  result
}

///|
/// Factorial. / 阶乘。
fn factorial(n : Int32) -> Double {
  let mut result = 1.0
  for i in 1..<=n {
    result *= i.to_double()
  }
  result
}

///|
/// Zernike moment V_n^m (returns real and imaginary parts).
/// Zernike 矩 V_n^m（返回实部和虚部）。
///
/// Points are mapped to the unit disk centered at centroid.
/// 点被映射到以质心为中心的单位圆盘。
pub fn zernike_moment(
  points : Array[@core.Point2D],
  n : Int32,
  m : Int32,
) -> (Double, Double) {
  let (c, _) = centroid(points)
  let mut r_max = 0.0
  for pt in points {
    let d = pt.dist(c)
    if d > r_max {
      r_max = d
    }
  }
  if r_max < 0.000000000001 {
    return (0.0, 0.0)
  }
  let count = points.length().to_double()
  let mut re = 0.0
  let mut im = 0.0
  for pt in points {
    let dx = (pt.x() - c.x()) / r_max
    let dy = (pt.y() - c.y()) / r_max
    let r = (dx * dx + dy * dy).sqrt()
    let theta = @math.atan2(dy, dx)
    let radial = zernike_radial(n, m, r)
    re += radial * @math.cos(m.to_double() * theta)
    im += radial * @math.sin(m.to_double() * theta)
  }
  (re / count, im / count)
}

///|
/// Magnitude of a Zernike moment (rotation invariant).
/// Zernike 矩的模长（旋转不变）。
pub fn zernike_magnitude(
  points : Array[@core.Point2D],
  n : Int32,
  m : Int32,
) -> Double {
  let (re, im) = zernike_moment(points, n, m)
  (re * re + im * im).sqrt()
}
