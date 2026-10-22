///|
/// Centroidal Voronoi tessellation result. / 质心 Voronoi 镶嵌结果。
pub struct CVTResult {
  sites : Array[@core.Point2D]
  cells : Array[Array[@core.Point2D]]
  iterations : Int
  energy : Double
}

///|
/// Construct an empty CVT result. / 构造空的 CVT 结果。
pub fn CVTResult::new() -> CVTResult {
  { sites: [], cells: [], iterations: 0, energy: 0.0 }
}

///|
/// Compute the centroid of a polygon. / 计算多边形的质心。
pub fn compute_centroid(poly : Array[@core.Point2D]) -> @core.Point2D {
  let n = poly.length()
  if n < 3 {
    if n == 0 {
      return @core.Point2D::new(0.0, 0.0)
    }
    let mut cx = 0.0
    let mut cy = 0.0
    for p in poly {
      cx += p.x()
      cy += p.y()
    }
    return @core.Point2D::new(cx / n.to_double(), cy / n.to_double())
  }
  let mut area = 0.0
  let mut cx = 0.0
  let mut cy = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    let cross = poly[i].x() * poly[j].y() - poly[j].x() * poly[i].y()
    area += cross
    cx += (poly[i].x() + poly[j].x()) * cross
    cy += (poly[i].y() + poly[j].y()) * cross
  }
  area *= 0.5
  if area.abs() < 0.0000000001 {
    let mut mx = 0.0
    let mut my = 0.0
    for p in poly {
      mx += p.x()
      my += p.y()
    }
    return @core.Point2D::new(mx / n.to_double(), my / n.to_double())
  }
  @core.Point2D::new(cx / (6.0 * area), cy / (6.0 * area))
}



///|
/// Clip polygon by bisector half-plane (keep side closer to s1). / 用平分线半平面裁剪多边形（保留靠近 s1 的一侧）。
fn clip_by_bisector(
  poly : Array[@core.Point2D],
  s1 : @core.Point2D,
  s2 : @core.Point2D,
) -> Array[@core.Point2D] {
  let nx = s2.x() - s1.x()
  let ny = s2.y() - s1.y()
  let c = ((s2.x() * s2.x() + s2.y() * s2.y()) -
    (s1.x() * s1.x() + s1.y() * s1.y())) / 2.0
  let result : Array[@core.Point2D] = []
  let m = poly.length()
  if m == 0 {
    return result
  }
  for i in 0..<m {
    let curr = poly[i]
    let next = poly[(i + 1) % m]
    let dc = curr.x() * nx + curr.y() * ny - c
    let dn = next.x() * nx + next.y() * ny - c
    let curr_inside = dc <= 0.0
    let next_inside = dn <= 0.0
    if curr_inside {
      result.push(curr)
    }
    if curr_inside != next_inside {
      let t = dc / (dc - dn)
      result.push(@core.Point2D::new(
        curr.x() + t * (next.x() - curr.x()),
        curr.y() + t * (next.y() - curr.y()),
      ))
    }
  }
  result
}

///|
/// Compute Voronoi cell for a site within bounds. / 计算站点在包围盒内的 Voronoi 单元。
fn voronoi_cell(
  sites : Array[@core.Point2D],
  idx : Int,
  bounds : (@core.Point2D, @core.Point2D),
) -> Array[@core.Point2D] {
  let (bl, tr) = bounds
  let mut cell : Array[@core.Point2D] = [
    bl,
    @core.Point2D::new(tr.x(), bl.y()),
    tr,
    @core.Point2D::new(bl.x(), tr.y()),
  ]
  for i in 0..<sites.length() {
    if i == idx {
      continue
    }
    cell = clip_by_bisector(cell, sites[idx], sites[i])
  }
  cell
}

///|
/// Compute Lloyd's energy (quantization error). / 计算 Lloyd 能量（量化误差）。
pub fn lloyd_energy(
  sites : Array[@core.Point2D],
  bounds : (@core.Point2D, @core.Point2D),
) -> Double {
  let mut energy = 0.0
  for i in 0..<sites.length() {
    let cell = voronoi_cell(sites, i, bounds)
    let n = cell.length()
    if n < 3 {
      continue
    }
    let site = sites[i]
    for ci in 0..<n {
      let cj = (ci + 1) % n
      let p0 = cell[ci]
      let p1 = cell[cj]
      let mx = (p0.x() + p1.x() + site.x()) / 3.0
      let my = (p0.y() + p1.y() + site.y()) / 3.0
      let tri_area = ((p1.x() - p0.x()) * (site.y() - p0.y()) -
        (site.x() - p0.x()) * (p1.y() - p0.y())).abs() * 0.5
      let dx = mx - site.x()
      let dy = my - site.y()
      energy += (dx * dx + dy * dy) * tri_area
    }
  }
  energy
}

///|
/// Perform one Lloyd iteration: move each site to its cell centroid. / 执行一次 Lloyd 迭代：将每个站点移至其单元质心。
pub fn lloyd_iteration(
  sites : Array[@core.Point2D],
  bounds : (@core.Point2D, @core.Point2D),
  max_iter : Int,
) -> Array[@core.Point2D] {
  let result = sites.copy()
  let mut iter = 0
  while iter < max_iter {
    let mut max_move = 0.0
    for i in 0..<result.length() {
      let cell = voronoi_cell(result, i, bounds)
      if cell.length() < 3 {
        continue
      }
      let centroid = compute_centroid(cell)
      let move_dist = result[i].dist(centroid)
      if move_dist > max_move {
        max_move = move_dist
      }
      result[i] = centroid
    }
    if max_move < 0.0000001 {
      break
    }
    iter += 1
  }
  result
}

///|
/// Compute centroidal Voronoi tessellation via Lloyd iteration. / 通过 Lloyd 迭代计算质心 Voronoi 镶嵌。
pub fn centroidal_voronoi(
  sites : Array[@core.Point2D],
  bounds : (@core.Point2D, @core.Point2D),
  max_iter : Int,
) -> CVTResult {
  let final_sites = lloyd_iteration(sites, bounds, max_iter)
  let cells : Array[Array[@core.Point2D]] = []
  let mut actual_iter = 0
  let work_sites = sites.copy()
  while actual_iter < max_iter {
    let mut max_move = 0.0
    for i in 0..<work_sites.length() {
      let cell = voronoi_cell(work_sites, i, bounds)
      if cell.length() < 3 {
        continue
      }
      let centroid = compute_centroid(cell)
      let move_dist = work_sites[i].dist(centroid)
      if move_dist > max_move {
        max_move = move_dist
      }
      work_sites[i] = centroid
    }
    actual_iter += 1
    if max_move < 0.0000001 {
      break
    }
  }
  for i in 0..<final_sites.length() {
    cells.push(voronoi_cell(final_sites, i, bounds))
  }
  let energy = lloyd_energy(final_sites, bounds)
  { sites: final_sites, cells, iterations: actual_iter, energy }
}