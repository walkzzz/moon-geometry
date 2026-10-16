/// |
/// # Advanced Voronoi Diagram Operations
/// # 高级 Voronoi 图操作
///
/// Advanced operations on Voronoi diagrams: clipping, merging, farthest-point.
/// Voronoi 图的高级操作：裁剪、合并、最远点。
///
/// ## Complexity: O(n log n) for construction
/// ## 复杂度: 构建 O(n log n)

/// |
/// Compute approximate Voronoi cell for a site.
/// 计算某个站点的近似 Voronoi 单元。
///
/// # Arguments / 参数
/// - `sites`: all Voronoi sites / 所有 Voronoi 站点
/// - `site_idx`: index of the target site / 目标站点索引
/// - `bounds`: bounding rectangle / 包围矩形
pub fn voronoi_cell(
  sites : Array[@core.Point2D],
  site_idx : Int,
  bounds : (@core.Point2D, @core.Point2D),
) -> Array[@core.Point2D] {
  if site_idx < 0 || site_idx >= sites.length() {
    return []
  }
  let site = sites[site_idx]
  let (bl, tr) = bounds
  let mut cell : Array[@core.Point2D] = [bl, @core.Point2D::new(tr.x(), bl.y()), tr, @core.Point2D::new(bl.x(), tr.y())]
  for i in 0..<sites.length() {
    if i == site_idx {
      continue
    }
    cell = clip_by_bisector(cell, site, sites[i])
  }
  cell
}

/// |
/// Compute farthest-point Voronoi cell for a site.
/// 计算某个站点的最远点 Voronoi 单元。
pub fn farthest_voronoi_cell(
  sites : Array[@core.Point2D],
  site_idx : Int,
  bounds : (@core.Point2D, @core.Point2D),
) -> Array[@core.Point2D] {
  if site_idx < 0 || site_idx >= sites.length() {
    return []
  }
  let site = sites[site_idx]
  let (bl, tr) = bounds
  let mut cell : Array[@core.Point2D] = [bl, @core.Point2D::new(tr.x(), bl.y()), tr, @core.Point2D::new(bl.x(), tr.y())]
  for i in 0..<sites.length() {
    if i == site_idx {
      continue
    }
    cell = clip_by_bisector_far(cell, site, sites[i])
  }
  cell
}

/// |
/// Compute Voronoi cell area.
/// 计算 Voronoi 单元面积。
pub fn voronoi_cell_area(
  sites : Array[@core.Point2D],
  site_idx : Int,
  bounds : (@core.Point2D, @core.Point2D),
) -> Double {
  let cell = voronoi_cell(sites, site_idx, bounds)
  polygon_area(cell)
}

/// |
/// Count Voronoi cells (equals number of sites).
/// 计算 Voronoi 单元数（等于站点数）。
pub fn voronoi_cell_count(sites : Array[@core.Point2D]) -> Int {
  sites.length()
}

fn clip_by_bisector(
  cell : Array[@core.Point2D],
  p : @core.Point2D,
  q : @core.Point2D,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  let n = cell.length()
  if n == 0 {
    return result
  }
  for i in 0..<n {
    let a = cell[i]
    let b = cell[(i + 1) % n]
    let da = dist_sq(a, p) - dist_sq(a, q)
    let db = dist_sq(b, p) - dist_sq(b, q)
    if da <= 0.0 {
      result.push(a)
    }
    if (da < 0.0 && db > 0.0) || (da > 0.0 && db < 0.0) {
      let t = da / (da - db)
      result.push(@core.Point2D::new(a.x() + t * (b.x() - a.x()), a.y() + t * (b.y() - a.y())))
    }
  }
  result
}

fn clip_by_bisector_far(
  cell : Array[@core.Point2D],
  p : @core.Point2D,
  q : @core.Point2D,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  let n = cell.length()
  if n == 0 {
    return result
  }
  for i in 0..<n {
    let a = cell[i]
    let b = cell[(i + 1) % n]
    let da = dist_sq(a, p) - dist_sq(a, q)
    let db = dist_sq(b, p) - dist_sq(b, q)
    if da >= 0.0 {
      result.push(a)
    }
    if (da > 0.0 && db < 0.0) || (da < 0.0 && db > 0.0) {
      let t = da / (da - db)
      result.push(@core.Point2D::new(a.x() + t * (b.x() - a.x()), a.y() + t * (b.y() - a.y())))
    }
  }
  result
}

fn dist_sq(a : @core.Point2D, b : @core.Point2D) -> Double {
  (a.x() - b.x()) * (a.x() - b.x()) + (a.y() - b.y()) * (a.y() - b.y())
}

fn polygon_area(pts : Array[@core.Point2D]) -> Double {
  let n = pts.length()
  if n < 3 {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    let a = pts[i]
    let b = pts[(i + 1) % n]
    sum += a.x() * b.y() - b.x() * a.y()
  }
  (sum / 2.0).abs()
}