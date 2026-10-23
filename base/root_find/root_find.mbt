/// |
/// # Root Finding
/// # 求根
///
/// Root finding using bisection, Newton's method, and secant method.
/// 使用二分法、牛顿法和割线法求根。
///
/// ## Complexity: O(log(1/eps)) for bisection, O(log log(1/eps)) for Newton
/// ## 复杂度: 二分法 O(log(1/eps))，牛顿法 O(log log(1/eps))

///|
/// |
/// Find root using bisection method.
/// 使用二分法求根。
///
/// # Arguments / 参数
/// - `f`: function / 函数
/// - `lo`: lower bound / 下界
/// - `hi`: upper bound / 上界
/// - `max_iter`: maximum iterations / 最大迭代数
pub fn bisection(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  max_iter : Int32,
) -> Double {
  let mut a = lo
  let mut b = hi
  let fa = f(a)
  for _ in 0..<max_iter {
    let mid = (a + b) / 2.0
    let fm = f(mid)
    if fm.abs() < 0.0000000001 {
      return mid
    }
    if fa * fm < 0.0 {
      b = mid
    } else {
      a = mid
    }
  }
  (a + b) / 2.0
}

///|
/// |
/// Find root using Newton's method.
/// 使用牛顿法求根。
///
/// # Arguments / 参数
/// - `f`: function / 函数
/// - `fp`: derivative / 导数
/// - `x0`: initial guess / 初始猜测
/// - `max_iter`: maximum iterations / 最大迭代数
pub fn newton(
  f : (Double) -> Double,
  fp : (Double) -> Double,
  x0 : Double,
  max_iter : Int32,
) -> Double {
  let mut x = x0
  for _ in 0..<max_iter {
    let fx = f(x)
    if fx.abs() < 0.0000000001 {
      return x
    }
    let fpx = fp(x)
    if fpx.abs() < 0.0000000001 {
      return x
    }
    x = x - fx / fpx
  }
  x
}

///|
/// |
/// Find root using secant method.
/// 使用割线法求根。
///
/// # Arguments / 参数
/// - `f`: function / 函数
/// - `x0`: first guess / 第一个猜测
/// - `x1`: second guess / 第二个猜测
/// - `max_iter`: maximum iterations / 最大迭代数
pub fn secant(
  f : (Double) -> Double,
  x0 : Double,
  x1 : Double,
  max_iter : Int32,
) -> Double {
  let mut a = x0
  let mut b = x1
  let mut fa = f(a)
  for _ in 0..<max_iter {
    let fb = f(b)
    if fb.abs() < 0.0000000001 {
      return b
    }
    if (fb - fa).abs() < 0.0000000001 {
      return b
    }
    let c = b - fb * (b - a) / (fb - fa)
    a = b
    fa = fb
    b = c
  }
  b
}

///|
/// |
/// Find all roots in an interval by scanning.
/// 通过扫描查找区间内所有根。
pub fn find_all_roots(
  f : (Double) -> Double,
  lo : Double,
  hi : Double,
  n_samples : Int32,
) -> Array[Double] {
  let roots : Array[Double] = []
  let step = (hi - lo) / n_samples.to_double()
  let mut x = lo
  let mut fx = f(x)
  while x < hi {
    let x2 = x + step
    let fx2 = f(x2)
    if fx * fx2 <= 0.0 && fx.abs() > 0.0000000001 {
      roots.push(bisection(f, x, x2, 50))
    }
    x = x2
    fx = fx2
  }
  roots
}
