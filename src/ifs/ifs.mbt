///|
/// # Iterated Function Systems
/// # 迭代函数系统
///
/// IFS of affine contraction mappings; attractor approximated via the chaos game.
/// 仿射压缩映射的迭代函数系统，通过混沌游戏逼近吸引子。

///|
/// Affine map: x' = a*x + b*y + e, y' = c*x + d*y + f.
/// 仿射映射：x' = a*x + b*y + e, y' = c*x + d*y + f。
pub struct AffineMap {
  a : Double
  b : Double
  e : Double
  c : Double
  d : Double
  f : Double
}

///|
/// Construct an affine map. / 构造仿射映射。
pub fn AffineMap::new(
  a : Double,
  b : Double,
  e : Double,
  c : Double,
  d : Double,
  f : Double,
) -> AffineMap {
  { a, b, e, c, d, f }
}

///|
/// Apply the affine map to a point. / 将仿射映射作用于点。
pub fn AffineMap::apply(m : AffineMap, p : @core.Point2D) -> @core.Point2D {
  @core.Point2D::new(
    m.a * p.x() + m.b * p.y() + m.e,
    m.c * p.x() + m.d * p.y() + m.f,
  )
}

///|
/// Spectral norm (contraction factor estimate) of the linear part.
/// 线性部分的谱范数（压缩因子估计）。
pub fn AffineMap::contraction_factor(m : AffineMap) -> Double {
  let s1 = m.a * m.a + m.c * m.c
  let s2 = m.b * m.b + m.d * m.d
  let s3 = m.a * m.b + m.c * m.d
  let trace = s1 + s2
  let det = s1 * s2 - s3 * s3
  let disc = trace * trace - 4.0 * det
  if disc < 0.0 {
    return (trace / 2.0).abs().sqrt()
  }
  let sq = disc.sqrt()
  let lam1 = (trace + sq) / 2.0
  let lam2 = (trace - sq) / 2.0
  if lam1.abs() > lam2.abs() {
    lam1.abs().sqrt()
  } else {
    lam2.abs().sqrt()
  }
}

///|
/// Check if the map is a contraction. / 检查映射是否为压缩映射。
pub fn AffineMap::is_contraction(m : AffineMap) -> Bool {
  AffineMap::contraction_factor(m) < 1.0
}

///|
/// Fixed point of the affine map. / 仿射映射的不动点。
pub fn AffineMap::fixed_point(m : AffineMap) -> @core.Point2D? {
  let eps = 0.0000000001
  let det = m.a * m.d - m.b * m.c
  if det.abs() < eps {
    return None
  }
  let x = (m.d * m.e - m.b * m.f) / det
  let y = (m.a * m.f - m.c * m.e) / det
  Some(@core.Point2D::new(x, y))
}

///|
/// IFS: a collection of affine contraction maps. / 迭代函数系统：仿射压缩映射集合。
pub struct IFS {
  maps : Array[AffineMap]
}

///|
/// Construct an IFS. / 构造迭代函数系统。
pub fn IFS::new(maps : Array[AffineMap]) -> IFS {
  { maps, }
}

///|
/// Number of maps. / 映射数量。
pub fn IFS::size(ifs : IFS) -> Int {
  ifs.maps.length()
}

///|
/// Maximum contraction factor across all maps. / 所有映射的最大压缩因子。
pub fn IFS::max_contraction(ifs : IFS) -> Double {
  let mut max_c = 0.0
  for m in ifs.maps {
    let c = AffineMap::contraction_factor(m)
    if c > max_c {
      max_c = c
    }
  }
  max_c
}

///|
/// Check if all maps are contractions. / 检查所有映射是否为压缩映射。
pub fn IFS::is_contractive(ifs : IFS) -> Bool {
  IFS::max_contraction(ifs) < 1.0
}

///|
/// Chaos game: iteratively pick a random map and apply it to generate attractor points.
/// 混沌游戏：迭代随机选取映射并应用，生成吸引子点集。
///
/// # Arguments / 参数
/// - `ifs`: the iterated function system / 迭代函数系统
/// - `seed`: starting point / 起点
/// - `n_iter`: number of iterations / 迭代次数
/// - `skip`: number of initial points to discard / 丢弃的初始点数
/// - `rng`: random number generator returning [0, n_maps) / 返回 [0, n_maps) 的随机数生成器
pub fn chaos_game(
  ifs : IFS,
  seed : @core.Point2D,
  n_iter : Int,
  skip : Int,
  rng : (Int) -> Int,
) -> Array[@core.Point2D] {
  let n_maps = ifs.maps.length()
  if n_maps == 0 {
    return []
  }
  let points : Array[@core.Point2D] = []
  let mut p = seed
  let total = n_iter + skip
  for i in 0..<total {
    let idx = rng(n_maps)
    let safe_idx = if idx >= 0 && idx < n_maps { idx } else { 0 }
    p = AffineMap::apply(ifs.maps[safe_idx], p)
    if i >= skip {
      points.push(p)
    }
  }
  points
}

///|
/// Deterministic iteration: apply all maps to a point set (one IFS step).
/// 确定性迭代：对所有点应用所有映射（一步 IFS 迭代）。
pub fn ifs_iterate(ifs : IFS, points : Array[@core.Point2D]) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for p in points {
    for m in ifs.maps {
      result.push(AffineMap::apply(m, p))
    }
  }
  result
}

///|
/// Run the deterministic IFS for multiple steps from a seed point.
/// 从种子点运行多步确定性 IFS。
pub fn ifs_attractor(
  ifs : IFS,
  seed : @core.Point2D,
  n_steps : Int,
) -> Array[@core.Point2D] {
  let mut points : Array[@core.Point2D] = [seed]
  for _ in 0..<n_steps {
    points = ifs_iterate(ifs, points)
  }
  points
}

///|
/// Bounding box of a point set. / 点集包围盒。
pub fn ifs_bbox(points : Array[@core.Point2D]) -> (Double, Double, Double, Double) {
  if points.length() == 0 {
    return (0.0, 0.0, 0.0, 0.0)
  }
  let mut min_x = points[0].x()
  let mut max_x = points[0].x()
  let mut min_y = points[0].y()
  let mut max_y = points[0].y()
  for p in points {
    let px = p.x()
    let py = p.y()
    if px < min_x {
      min_x = px
    }
    if px > max_x {
      max_x = px
    }
    if py < min_y {
      min_y = py
    }
    if py > max_y {
      max_y = py
    }
  }
  (min_x, min_y, max_x, max_y)
}