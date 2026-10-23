///|
/// Uniform grid sampling in a rectangle. / 在矩形中均匀网格采样。
pub fn grid_sample(
  x_lo : Double,
  x_hi : Double,
  y_lo : Double,
  y_hi : Double,
  nx : Int32,
  ny : Int32,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  let dx = (x_hi - x_lo) / nx.to_double()
  let dy = (y_hi - y_lo) / ny.to_double()
  for i in 0..<nx {
    for j in 0..<ny {
      result.push(
        @core.Point2D::new(
          x_lo + (i.to_double() + 0.5) * dx,
          y_lo + (j.to_double() + 0.5) * dy,
        ),
      )
    }
  }
  result
}

///|
/// Poisson-disk-like sampling (simplified grid-based). / 类泊松盘采样（基于网格的简化版）。
pub fn poisson_disk_sample(
  x_lo : Double,
  x_hi : Double,
  y_lo : Double,
  y_hi : Double,
  min_dist : Double,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  let step = min_dist
  let mut x = x_lo + step / 2.0
  let mut row = 0
  while x < x_hi {
    let y_offset = if row % 2 == 0 { 0.0 } else { step / 2.0 }
    let mut y = y_lo + step / 2.0 + y_offset
    while y < y_hi {
      result.push(@core.Point2D::new(x, y))
      y += step
    }
    x += step * 0.8660254037844387
    row += 1
  }
  result
}

///|
/// Sample points along a line segment. / 沿线段采样点。
pub fn segment_sample(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  n : Int32,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for i in 0..<n {
    let t = i.to_double() / (n - 1).to_double()
    result.push(
      @core.Point2D::new(
        p1.x() + t * (p2.x() - p1.x()),
        p1.y() + t * (p2.y() - p1.y()),
      ),
    )
  }
  result
}

///|
/// Uniform sampling on a circle. / 在圆上均匀采样。
pub fn circle_sample(
  center : @core.Point2D,
  radius : Double,
  n : Int32,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for i in 0..<n {
    let angle = 2.0 * 3.141592653589793 * i.to_double() / n.to_double()
    result.push(
      @core.Point2D::new(
        center.x() + radius * @math.cos(angle),
        center.y() + radius * @math.sin(angle),
      ),
    )
  }
  result
}

///|
/// Halton sequence sampling (low-discrepancy). / Halton 序列采样（低差异）。
pub fn halton_sample(
  base_x : Int32,
  base_y : Int32,
  n : Int32,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for i in 1..<=n {
    result.push(@core.Point2D::new(halton(i, base_x), halton(i, base_y)))
  }
  result
}

///|
fn halton(index : Int32, base : Int32) -> Double {
  let mut f = 1.0
  let mut r = 0.0
  let mut i = index
  while i > 0 {
    f = f / base.to_double()
    r = r + f * (i % base).to_double()
    i = i / base
  }
  r
}

///|
/// Uniform sampling inside a circle (rejection-free). / 在圆内均匀采样（无拒绝）。
pub fn circle_interior_sample(
  center : @core.Point2D,
  radius : Double,
  n : Int32,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for i in 0..<n {
    let angle = 2.0 * 3.141592653589793 * i.to_double() / n.to_double()
    let r = radius * (i.to_double() / n.to_double()).sqrt()
    result.push(
      @core.Point2D::new(
        center.x() + r * @math.cos(angle),
        center.y() + r * @math.sin(angle),
      ),
    )
  }
  result
}
