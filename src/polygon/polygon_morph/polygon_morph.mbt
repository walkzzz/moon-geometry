/// |
/// # Polygon Morphing
/// # 多边形变形
///
/// Morph between two polygons with the same number of vertices.
/// 在具有相同顶点数的两个多边形之间变形。
///
/// ## Complexity: O(n)
/// ## 复杂度: O(n)

/// |
/// Linear interpolation morph at parameter t ∈ [0, 1].
/// 参数 t ∈ [0, 1] 的线性插值变形。
///
/// # Arguments / 参数
/// - `pts1`: source polygon / 源多边形
/// - `pts2`: target polygon / 目标多边形
/// - `t`: morph parameter / 变形参数
pub fn morph(
  pts1 : Array[@core.Point2D],
  pts2 : Array[@core.Point2D],
  t : Double,
) -> Array[@core.Point2D] {
  let n = pts1.length()
  let result : Array[@core.Point2D] = []
  if n != pts2.length() || n == 0 {
    return result
  }
  let tc = if t < 0.0 {
    0.0
  } else if t > 1.0 {
    1.0
  } else {
    t
  }
  for i in 0..<n {
    let p1 = pts1[i]
    let p2 = pts2[i]
    let x = p1.x() * (1.0 - tc) + p2.x() * tc
    let y = p1.y() * (1.0 - tc) + p2.y() * tc
    result.push(@core.Point2D::new(x, y))
  }
  result
}

/// |
/// Generate a sequence of morphs from source to target.
/// 生成从源到目标的变形序列。
///
/// # Arguments / 参数
/// - `pts1`: source polygon / 源多边形
/// - `pts2`: target polygon / 目标多边形
/// - `n_steps`: number of intermediate steps / 中间步数
pub fn morph_sequence(
  pts1 : Array[@core.Point2D],
  pts2 : Array[@core.Point2D],
  n_steps : Int,
) -> Array[Array[@core.Point2D]] {
  let result : Array[Array[@core.Point2D]] = []
  if n_steps < 1 || pts1.length() != pts2.length() {
    return result
  }
  for i in 0..=n_steps {
    let t = i.to_double() / n_steps.to_double()
    result.push(morph(pts1, pts2, t))
  }
  result
}

/// |
/// Find the best vertex alignment to minimize morphing distance.
/// 寻找最佳顶点对齐以最小化变形距离。
///
/// Rotates the vertex order of pts2 to find the alignment
/// that minimizes the sum of squared distances.
/// 旋转 pts2 的顶点顺序以找到最小化距离平方和的对齐。
pub fn best_alignment(
  pts1 : Array[@core.Point2D],
  pts2 : Array[@core.Point2D],
) -> Int {
  let n = pts1.length()
  if n != pts2.length() || n == 0 {
    return 0
  }
  let mut best_shift = 0
  let mut best_dist = 1000000.0
  for shift in 0..<n {
    let mut dist = 0.0
    for i in 0..<n {
      let p1 = pts1[i]
      let p2 = pts2[(i + shift) % n]
      let dx = p1.x() - p2.x()
      let dy = p1.y() - p2.y()
      dist += dx * dx + dy * dy
    }
    if dist < best_dist {
      best_dist = dist
      best_shift = shift
    }
  }
  best_shift
}

/// |
/// Morph with optimal vertex alignment.
/// 带最优顶点对齐的变形。
pub fn morph_aligned(
  pts1 : Array[@core.Point2D],
  pts2 : Array[@core.Point2D],
  t : Double,
) -> Array[@core.Point2D] {
  let n = pts2.length()
  let shift = best_alignment(pts1, pts2)
  let shifted : Array[@core.Point2D] = []
  for i in 0..<n {
    shifted.push(pts2[(i + shift) % n])
  }
  morph(pts1, shifted, t)
}