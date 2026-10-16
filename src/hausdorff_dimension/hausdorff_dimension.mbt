///|
/// # Hausdorff Dimension
/// # Hausdorff 维数
///
/// Hausdorff dimension of self-similar sets: D = log(N) / log(1/r).
/// 自相似集的 Hausdorff 维数：D = log(N) / log(1/r)。

///|
/// Hausdorff dimension of a self-similar set with N copies each scaled by r.
/// N 个比例为 r 的自相似副本的 Hausdorff 维数。
pub fn self_similar_dimension(n : Int, r : Double) -> Double {
  if n <= 0 || r <= 0.0 || r >= 1.0 {
    return 0.0
  }
  @math.ln(n.to_double()) / @math.ln(1.0 / r)
}

///|
/// Hausdorff dimension with unequal scaling ratios (Moran's equation).
/// Solve sum(r_i^D) = 1 via bisection. / 不等比例的 Hausdorff 维数（Moran 方程）。
pub fn moran_dimension(ratios : Array[Double]) -> Double {
  let eps = 0.0000000001
  if ratios.length() == 0 {
    return 0.0
  }
  let mut any_valid = false
  for r in ratios {
    if r > 0.0 && r < 1.0 {
      any_valid = true
    }
  }
  if !any_valid {
    return 0.0
  }
  let mut lo = 0.0
  let mut hi = 100.0
  for _ in 0..<200 {
    let mid = (lo + hi) / 2.0
    let s = moran_sum(ratios, mid)
    if s > 1.0 {
      lo = mid
    } else {
      hi = mid
    }
    if (hi - lo).abs() < eps {
      return mid
    }
  }
  (lo + hi) / 2.0
}

fn moran_sum(ratios : Array[Double], d : Double) -> Double {
  let mut sum = 0.0
  for r in ratios {
    if r > 0.0 && r < 1.0 {
      sum += @math.pow(r, d)
    }
  }
  sum
}

///|
/// Similarity dimension for the Cantor set (N=2, r=1/3). / Cantor 集的相似维数。
pub fn cantor_set_dimension() -> Double {
  self_similar_dimension(2, 1.0 / 3.0)
}

///|
/// Similarity dimension for the Sierpinski triangle (N=3, r=1/2). / Sierpinski 三角的相似维数。
pub fn sierpinski_triangle_dimension() -> Double {
  self_similar_dimension(3, 1.0 / 2.0)
}

///|
/// Similarity dimension for the Sierpinski carpet (N=8, r=1/3). / Sierpinski 地毯的相似维数。
pub fn sierpinski_carpet_dimension() -> Double {
  self_similar_dimension(8, 1.0 / 3.0)
}

///|
/// Similarity dimension for the Koch curve (N=4, r=1/3). / Koch 曲线的相似维数。
pub fn koch_curve_dimension() -> Double {
  self_similar_dimension(4, 1.0 / 3.0)
}

///|
/// Similarity dimension for the Menger sponge (N=20, r=1/3). / Menger 海绵的相似维数。
pub fn menger_sponge_dimension() -> Double {
  self_similar_dimension(20, 1.0 / 3.0)
}

///|
/// Verify the Moran equation: sum(r_i^D) should equal 1.
/// 验证 Moran 方程：sum(r_i^D) 应等于 1。
pub fn verify_moran(ratios : Array[Double], d : Double) -> Double {
  moran_sum(ratios, d) - 1.0
}

///|
/// Hausdorff dimension of a self-affine set with separate x/y scaling (approximate).
/// For an IFS with N maps each scaling x by rx and y by ry, the dimension is
/// approximately log(N) / log(1/r_max) when ratios differ.
/// 自仿射集的近似 Hausdorff 维数。
pub fn self_affine_dimension(n : Int, rx : Double, ry : Double) -> Double {
  if n <= 0 || rx <= 0.0 || ry <= 0.0 {
    return 0.0
  }
  let r_max = if rx > ry { rx } else { ry }
  let r_min = if rx < ry { rx } else { ry }
  if r_max >= 1.0 {
    return 0.0
  }
  let d_box = @math.ln(n.to_double()) / @math.ln(1.0 / r_max)
  let d_lower = @math.ln(n.to_double()) / @math.ln(1.0 / r_min)
  if d_box >= 2.0 {
    return 2.0
  }
  if d_box <= d_lower {
    return d_box
  }
  (d_box + d_lower) / 2.0
}

///|
/// Estimate the Hausdorff dimension from a point cloud using box counting.
/// 从点云用盒计数估计 Hausdorff 维数。
pub fn estimate_from_points(
  points : Array[@core.Point2D],
  eps_min : Double,
  eps_max : Double,
  n_scales : Int,
) -> Double {
  let scales = @fractal_dimension.geometric_scales(eps_min, eps_max, n_scales)
  @fractal_dimension.box_counting_dimension(points, scales)
}