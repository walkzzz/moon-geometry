/// |
/// # Gradient Descent
/// # 梯度下降
///
/// Gradient descent variants: vanilla GD, momentum, Nesterov accelerated gradient, Adam.
/// 梯度下降变体：基本梯度下降、动量法、Nesterov 加速梯度、Adam。
///
/// ## Complexity: O(iter * n) where n is dimension
/// ## 复杂度: O(iter * n)，n 为维度

/// |
/// Vanilla gradient descent: x = x - lr * grad(x).
/// 基本梯度下降。
pub fn gradient_descent(
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  max_iter : Int,
) -> Array[Double] {
  let n = x0.length()
  let x : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    x[i] = x0[i]
  }
  for _ in 0..<max_iter {
    let g = grad(x)
    let mut norm_sq = 0.0
    for i in 0..<n {
      norm_sq += g[i] * g[i]
    }
    if norm_sq < 0.0000000000000001 {
      break
    }
    for i in 0..<n {
      x[i] -= lr * g[i]
    }
  }
  x
}

/// |
/// Momentum gradient descent: v = momentum * v + lr * grad; x = x - v.
/// 动量梯度下降。
pub fn momentum_gd(
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  momentum : Double,
  max_iter : Int,
) -> Array[Double] {
  let n = x0.length()
  let x : Array[Double] = Array::make(n, 0.0)
  let v : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    x[i] = x0[i]
  }
  for _ in 0..<max_iter {
    let g = grad(x)
    for i in 0..<n {
      v[i] = momentum * v[i] + lr * g[i]
      x[i] -= v[i]
    }
  }
  x
}

/// |
/// Nesterov accelerated gradient.
/// Nesterov 加速梯度。
pub fn nesterov_gd(
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  momentum : Double,
  max_iter : Int,
) -> Array[Double] {
  let n = x0.length()
  let x : Array[Double] = Array::make(n, 0.0)
  let v : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    x[i] = x0[i]
  }
  for _ in 0..<max_iter {
    let look_ahead : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      look_ahead[i] = x[i] - momentum * v[i]
    }
    let g = grad(look_ahead)
    for i in 0..<n {
      v[i] = momentum * v[i] + lr * g[i]
      x[i] -= v[i]
    }
  }
  x
}

/// |
/// Adam optimizer.
/// Adam 优化器。
pub fn adam(
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  beta1 : Double,
  beta2 : Double,
  eps : Double,
  max_iter : Int,
) -> Array[Double] {
  let n = x0.length()
  let x : Array[Double] = Array::make(n, 0.0)
  let m : Array[Double] = Array::make(n, 0.0)
  let vv : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    x[i] = x0[i]
  }
  let mut bc1 = 1.0
  let mut bc2 = 1.0
  for _ in 1..<(max_iter + 1) {
    let g = grad(x)
    bc1 *= beta1
    bc2 *= beta2
    for i in 0..<n {
      m[i] = beta1 * m[i] + (1.0 - beta1) * g[i]
      vv[i] = beta2 * vv[i] + (1.0 - beta2) * g[i] * g[i]
      let m_hat = m[i] / (1.0 - bc1)
      let v_hat = vv[i] / (1.0 - bc2)
      x[i] -= lr * m_hat / (v_hat.sqrt() + eps)
    }
  }
  x
}

/// |
/// 2D gradient descent convenience wrapper. Returns the optimized point.
/// 二维梯度下降便捷封装，返回优化后的点。
pub fn gd_2d(
  grad : (Double, Double) -> (Double, Double),
  x0 : Double,
  y0 : Double,
  lr : Double,
  max_iter : Int,
) -> @core.Point2D {
  let g_wrap = fn(x : Array[Double]) -> Array[Double] {
    let (gx, gy) = grad(x[0], x[1])
    [gx, gy]
  }
  let result = gradient_descent(g_wrap, [x0, y0], lr, max_iter)
  @core.Point2D::new(result[0], result[1])
}

/// |
/// RMSprop optimizer.
/// RMSprop 优化器。
pub fn rmsprop(
  grad : (Array[Double]) -> Array[Double],
  x0 : Array[Double],
  lr : Double,
  decay : Double,
  eps : Double,
  max_iter : Int,
) -> Array[Double] {
  let n = x0.length()
  let x : Array[Double] = Array::make(n, 0.0)
  let sq : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    x[i] = x0[i]
  }
  for _ in 0..<max_iter {
    let g = grad(x)
    for i in 0..<n {
      sq[i] = decay * sq[i] + (1.0 - decay) * g[i] * g[i]
      x[i] -= lr * g[i] / (sq[i].sqrt() + eps)
    }
  }
  x
}