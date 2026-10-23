///|
/// Compute the kernel of a polygon (intersection of interior half-planes). / 计算多边形的核（内部半平面交集）。
pub fn polygon_kernel(poly : Array[@core.Point2D]) -> Array[@core.Point2D] {
  let n = poly.length()
  if n < 3 {
    return []
  }
  let eps = 0.000000000001
  let kernel : Array[@core.Point2D] = []
  for v in poly {
    kernel.push(v)
  }
  for i in 0..<n {
    let j = (i + 1) % n
    let edge_start = poly[i]
    let edge_end = poly[j]
    let clipped : Array[@core.Point2D] = []
    let kn = kernel.length()
    for k in 0..<kn {
      let curr = kernel[k]
      let next = kernel[(k + 1) % kn]
      let dx = edge_end.x() - edge_start.x()
      let dy = edge_end.y() - edge_start.y()
      let curr_side = dx * (curr.y() - edge_start.y()) -
        dy * (curr.x() - edge_start.x())
      let next_side = dx * (next.y() - edge_start.y()) -
        dy * (next.x() - edge_start.x())
      if curr_side >= -eps {
        clipped.push(curr)
      }
      if curr_side * next_side < -eps {
        let t = curr_side / (curr_side - next_side)
        clipped.push(
          @core.Point2D::new(
            curr.x() + t * (next.x() - curr.x()),
            curr.y() + t * (next.y() - curr.y()),
          ),
        )
      }
    }
    kernel.clear()
    for p in clipped {
      kernel.push(p)
    }
    if kernel.length() < 3 {
      return []
    }
  }
  kernel
}

///|
/// Check if a polygon is star-shaped (kernel is non-empty). / 检查多边形是否为星形（核非空）。
pub fn is_star_shaped(poly : Array[@core.Point2D]) -> Bool {
  let kernel = polygon_kernel(poly)
  kernel.length() >= 3
}

///|
/// Compute the area of the kernel. / 计算核的面积。
pub fn polygon_kernel_area(poly : Array[@core.Point2D]) -> Double {
  let kernel = polygon_kernel(poly)
  let n = kernel.length()
  if n < 3 {
    return 0.0
  }
  let mut area = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    area += kernel[i].x() * kernel[j].y() - kernel[j].x() * kernel[i].y()
  }
  area.abs() / 2.0
}

///|
/// Find a point in the kernel (centroid of kernel vertices). / 在核中找一点（核顶点的质心）。
pub fn kernel_point(poly : Array[@core.Point2D]) -> @core.Point2D? {
  let kernel = polygon_kernel(poly)
  if kernel.length() < 3 {
    return None
  }
  let mut sx = 0.0
  let mut sy = 0.0
  for p in kernel {
    sx += p.x()
    sy += p.y()
  }
  let n = kernel.length().to_double()
  Some(@core.Point2D::new(sx / n, sy / n))
}
