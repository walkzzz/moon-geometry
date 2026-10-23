///|
/// Weighted point for power diagram. / 幂图的加权站点。
pub struct WeightedPoint {
  point : @core.Point2D
  weight : Double
}

///|
/// Construct a weighted point. / 构造加权点。
pub fn WeightedPoint::new(
  point : @core.Point2D,
  weight : Double,
) -> WeightedPoint {
  { point, weight, }
}

///|
/// Power cell: region where a site has minimum power distance. / 幂单元：某站点幂距离最小的区域。
pub struct PowerCell {
  site_idx : Int32
  vertices : Array[@core.Point2D]
}

///|
/// Power diagram (weighted Voronoi diagram). / 幂图（加权 Voronoi 图）。
pub struct PowerDiagram {
  sites : Array[WeightedPoint]
  cells : Array[PowerCell]
}

///|
/// Construct an empty power diagram. / 构造空的幂图。
pub fn PowerDiagram::new() -> PowerDiagram {
  { sites: [], cells: [], }
}

///|
/// Get the number of cells. / 获取单元数量。
pub fn PowerDiagram::cell_count(pd : PowerDiagram) -> Int32 {
  pd.cells.length()
}

///|
/// Compute the power distance from point x to weighted site (s, w): |x-s|^2 - w. / 计算点 x 到加权站点 (s, w) 的幂距离：|x-s|^2 - w。
pub fn power_distance(x : @core.Point2D, site : WeightedPoint) -> Double {
  x.dist_sq(site.point) - site.weight
}

///|
/// Clip a convex polygon by a power bisector half-plane. / 用幂平分线半平面裁剪凸多边形。
fn clip_by_power(
  poly : Array[@core.Point2D],
  s1 : WeightedPoint,
  s2 : WeightedPoint,
) -> Array[@core.Point2D] {
  let p1 = s1.point
  let p2 = s2.point
  let nx = p2.x() - p1.x()
  let ny = p2.y() - p1.y()
  let c = (
      p2.x() * p2.x() +
      p2.y() * p2.y() -
      (p1.x() * p1.x() + p1.y() * p1.y()) -
      s2.weight +
      s1.weight
    ) /
    2.0
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
      result.push(
        @core.Point2D::new(
          curr.x() + t * (next.x() - curr.x()),
          curr.y() + t * (next.y() - curr.y()),
        ),
      )
    }
  }
  result
}

///|
/// Compute the power diagram of weighted sites within a bounding box. / 计算加权站点在包围盒内的幂图。
pub fn power_diagram(
  sites : Array[WeightedPoint],
  bounds : (@core.Point2D, @core.Point2D),
) -> PowerDiagram {
  let n = sites.length()
  if n == 0 {
    return { sites: [], cells: [], }
  }
  let (bl, tr) = bounds
  let cells : Array[PowerCell] = []
  for i in 0..<n {
    let mut cell : Array[@core.Point2D] = [
      bl,
      @core.Point2D::new(tr.x(), bl.y()),
      tr,
      @core.Point2D::new(bl.x(), tr.y()),
    ]
    for j in 0..<n {
      if i == j {
        continue
      }
      cell = clip_by_power(cell, sites[i], sites[j])
    }
    cells.push({ site_idx: i, vertices: cell, })
  }
  { sites: sites.copy(), cells, }
}

///|
/// Get a specific power cell by site index. / 按站点索引获取幂单元。
pub fn power_cell(pd : PowerDiagram, site_idx : Int32) -> PowerCell {
  for c in pd.cells {
    if c.site_idx == site_idx {
      return c
    }
  }
  { site_idx, vertices: [], }
}

///|
/// Compute the area of a power cell. / 计算幂单元面积。
pub fn power_cell_area(pd : PowerDiagram, site_idx : Int32) -> Double {
  let cell = power_cell(pd, site_idx)
  polygon_area(cell.vertices)
}

///|
fn polygon_area(poly : Array[@core.Point2D]) -> Double {
  let n = poly.length()
  if n < 3 {
    return 0.0
  }
  let mut area = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    area += poly[i].x() * poly[j].y() - poly[j].x() * poly[i].y()
  }
  (area * 0.5).abs()
}

///|
/// Compute the regular triangulation (weighted Delaunay) of weighted sites. / 计算加权站点的正则三角剖分（加权 Delaunay）。
pub fn regular_triangulation(
  sites : Array[WeightedPoint],
) -> Array[(Int32, Int32, Int32)] {
  let n = sites.length()
  if n < 3 {
    return []
  }
  let tris : Array[(Int32, Int32, Int32)] = []
  for i in 0..<(n - 2) {
    for j in (i + 1)..<(n - 1) {
      for k in (j + 1)..<n {
        let is_regular = check_regular(sites, i, j, k)
        if is_regular {
          tris.push((i, j, k))
        }
      }
    }
  }
  tris
}

///|
fn check_regular(
  sites : Array[WeightedPoint],
  i : Int32,
  j : Int32,
  k : Int32,
) -> Bool {
  let p1 = sites[i].point
  let p2 = sites[j].point
  let p3 = sites[k].point
  let area = (p2.x() - p1.x()) * (p3.y() - p1.y()) -
    (p3.x() - p1.x()) * (p2.y() - p1.y())
  if area.abs() < 0.0000000001 {
    return false
  }
  let center = circumcenter2d(p1, p2, p3)
  let rsq = center.dist_sq(p1)
  let power1 = rsq - sites[i].weight
  for idx in 0..<sites.length() {
    if idx == i || idx == j || idx == k {
      continue
    }
    let pwr = center.dist_sq(sites[idx].point) - sites[idx].weight
    if pwr < power1 - 0.0000001 {
      return false
    }
  }
  true
}

///|
fn circumcenter2d(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> @core.Point2D {
  let ax = a.x()
  let ay = a.y()
  let bx = b.x()
  let by = b.y()
  let cx = c.x()
  let cy = c.y()
  let d = 2.0 * (ax * (by - cy) + bx * (cy - ay) + cx * (ay - by))
  if d.abs() < 0.0000000001 {
    return @core.Point2D::new((ax + bx + cx) / 3.0, (ay + by + cy) / 3.0)
  }
  let ux = (
      (ax * ax + ay * ay) * (by - cy) +
      (bx * bx + by * by) * (cy - ay) +
      (cx * cx + cy * cy) * (ay - by)
    ) /
    d
  let uy = (
      (ax * ax + ay * ay) * (cx - bx) +
      (bx * bx + by * by) * (ax - cx) +
      (cx * cx + cy * cy) * (bx - ax)
    ) /
    d
  @core.Point2D::new(ux, uy)
}
