///|
/// # Collision Detection
/// # 碰撞检测
///
/// Broad phase (AABB sweep and prune) and narrow phase (segment, polygon, circle).
/// 宽相（AABB 扫掠修剪）和窄相（线段、多边形、圆）碰撞检测。
///
/// ## Complexity: O(n log n) broad phase + O(1) narrow phase per pair
/// ## 复杂度: 宽相 O(n log n) + 每对窄相 O(1)

///|
/// AABB (axis-aligned bounding box) in 2D. / 二维轴对齐包围盒。
pub struct AABB {
  min_x : Double
  min_y : Double
  max_x : Double
  max_y : Double
}

///|
/// Construct an AABB. / 构造 AABB。
pub fn AABB::new(
  min_x : Double,
  min_y : Double,
  max_x : Double,
  max_y : Double,
) -> AABB {
  { min_x, min_y, max_x, max_y, }
}

///|
/// Construct an AABB from a center and half-extents. / 从中心和半边长构造 AABB。
pub fn AABB::from_center(
  cx : Double,
  cy : Double,
  hx : Double,
  hy : Double,
) -> AABB {
  { min_x: cx - hx, min_y: cy - hy, max_x: cx + hx, max_y: cy + hy, }
}

///|
/// Check if two AABBs overlap. / 检查两个 AABB 是否重叠。
pub fn aabb_overlap(a : AABB, b : AABB) -> Bool {
  a.min_x <= b.max_x &&
  a.max_x >= b.min_x &&
  a.min_y <= b.max_y &&
  a.max_y >= b.min_y
}

///|
/// Check if a point is inside an AABB. / 检查点是否在 AABB 内。
pub fn aabb_contains(box : AABB, x : Double, y : Double) -> Bool {
  x >= box.min_x && x <= box.max_x && y >= box.min_y && y <= box.max_y
}

///|
/// Compute the AABB of a polygon. / 计算多边形的 AABB。
pub fn aabb_from_polygon(poly : Array[@core.Point2D]) -> AABB {
  let mut min_x = poly[0].x()
  let mut min_y = poly[0].y()
  let mut max_x = poly[0].x()
  let mut max_y = poly[0].y()
  for i in 1..<poly.length() {
    let px = poly[i].x()
    let py = poly[i].y()
    if px < min_x {
      min_x = px
    }
    if py < min_y {
      min_y = py
    }
    if px > max_x {
      max_x = px
    }
    if py > max_y {
      max_y = py
    }
  }
  AABB::new(min_x, min_y, max_x, max_y)
}

///|
/// Collision pair result. / 碰撞对结果。
pub struct CollisionPair {
  id_a : Int32
  id_b : Int32
}

///|
/// Construct a collision pair. / 构造碰撞对。
pub fn CollisionPair::new(id_a : Int32, id_b : Int32) -> CollisionPair {
  { id_a, id_b, }
}

///|
/// Broad phase collision detection using AABB sweep and prune. / 宽相碰撞检测（AABB 扫掠修剪）。
///
/// Returns list of potentially colliding pairs. / 返回潜在碰撞对列表。
pub fn broad_phase_aabb(boxes : Array[AABB]) -> Array[CollisionPair] {
  let n = boxes.length()
  let indices : Array[Int32] = []
  for i in 0..<n {
    indices.push(i)
  }
  indices.sort_by(fn(a, b) {
    if boxes[a].min_x < boxes[b].min_x {
      -1
    } else if boxes[a].min_x > boxes[b].min_x {
      1
    } else {
      0
    }
  })
  let pairs : Array[CollisionPair] = []
  for i in 0..<n {
    let a = indices[i]
    for j in (i + 1)..<n {
      let b = indices[j]
      if boxes[a].max_x < boxes[b].min_x {
        break
      }
      if aabb_overlap(boxes[a], boxes[b]) {
        pairs.push(CollisionPair::new(a, b))
      }
    }
  }
  pairs
}

///|
/// Narrow phase: segment-segment intersection. / 窄相：线段-线段相交。
pub fn segment_segment_collide(
  a1 : @core.Point2D,
  a2 : @core.Point2D,
  b1 : @core.Point2D,
  b2 : @core.Point2D,
) -> Bool {
  let d1 = @core.turn(b1, b2, a1)
  let d2 = @core.turn(b1, b2, a2)
  let d3 = @core.turn(a1, a2, b1)
  let d4 = @core.turn(a1, a2, b2)
  ((d1 > 0.0 && d2 < 0.0) || (d1 < 0.0 && d2 > 0.0)) &&
  ((d3 > 0.0 && d4 < 0.0) || (d3 < 0.0 && d4 > 0.0))
}

///|
/// Narrow phase: point in polygon test. / 窄相：点在多边形内测试。
pub fn point_in_polygon(p : @core.Point2D, poly : Array[@core.Point2D]) -> Bool {
  let n = poly.length()
  let mut inside = false
  let mut j = n - 1
  for i in 0..<n {
    let yi = poly[i].y()
    let yj = poly[j].y()
    let xi = poly[i].x()
    let xj = poly[j].x()
    if (yi > p.y()) != (yj > p.y()) {
      let x_intersect = xi + (p.y() - yi) / (yj - yi) * (xj - xi)
      if p.x() < x_intersect {
        inside = !inside
      }
    }
    j = i
  }
  inside
}

///|
/// Narrow phase: circle-circle collision. / 窄相：圆-圆碰撞。
pub fn circle_circle_collide(
  c1 : @core.Point2D,
  r1 : Double,
  c2 : @core.Point2D,
  r2 : Double,
) -> Bool {
  let dist_sq = c1.dist_sq(c2)
  let r_sum = r1 + r2
  dist_sq <= r_sum * r_sum
}

///|
/// Narrow phase: segment-polygon collision. / 窄相：线段-多边形碰撞。
pub fn segment_polygon_collide(
  a : @core.Point2D,
  b : @core.Point2D,
  poly : Array[@core.Point2D],
) -> Bool {
  if point_in_polygon(a, poly) || point_in_polygon(b, poly) {
    return true
  }
  let n = poly.length()
  for i in 0..<n {
    if segment_segment_collide(a, b, poly[i], poly[(i + 1) % n]) {
      return true
    }
  }
  false
}

///|
/// Narrow phase: polygon-polygon collision (edge test). / 窄相：多边形-多边形碰撞（边测试）。
pub fn polygon_polygon_collide(
  poly1 : Array[@core.Point2D],
  poly2 : Array[@core.Point2D],
) -> Bool {
  for i in 0..<poly1.length() {
    if point_in_polygon(poly1[i], poly2) {
      return true
    }
  }
  for i in 0..<poly2.length() {
    if point_in_polygon(poly2[i], poly1) {
      return true
    }
  }
  let n1 = poly1.length()
  let n2 = poly2.length()
  for i in 0..<n1 {
    for j in 0..<n2 {
      if segment_segment_collide(
          poly1[i],
          poly1[(i + 1) % n1],
          poly2[j],
          poly2[(j + 1) % n2],
        ) {
        return true
      }
    }
  }
  false
}

///|
/// Narrow phase: circle-polygon collision. / 窄相：圆-多边形碰撞。
pub fn circle_polygon_collide(
  center : @core.Point2D,
  radius : Double,
  poly : Array[@core.Point2D],
) -> Bool {
  if point_in_polygon(center, poly) {
    return true
  }
  let n = poly.length()
  for i in 0..<n {
    let p1 = poly[i]
    let p2 = poly[(i + 1) % n]
    if point_segment_dist_sq(center, p1, p2) <= radius * radius {
      return true
    }
  }
  false
}

///|
fn point_segment_dist_sq(
  p : @core.Point2D,
  a : @core.Point2D,
  b : @core.Point2D,
) -> Double {
  let dx = b.x() - a.x()
  let dy = b.y() - a.y()
  let len_sq = dx * dx + dy * dy
  if len_sq < 0.000000000001 {
    return p.dist_sq(a)
  }
  let t = ((p.x() - a.x()) * dx + (p.y() - a.y()) * dy) / len_sq
  let tc = if t < 0.0 { 0.0 } else if t > 1.0 { 1.0 } else { t }
  let proj_x = a.x() + tc * dx
  let proj_y = a.y() + tc * dy
  (p.x() - proj_x) * (p.x() - proj_x) + (p.y() - proj_y) * (p.y() - proj_y)
}

///|
/// Narrow phase: AABB-polygon collision. / 窄相：AABB-多边形碰撞。
pub fn aabb_polygon_collide(box : AABB, poly : Array[@core.Point2D]) -> Bool {
  let corners = [
    @core.Point2D::new(box.min_x, box.min_y),
    @core.Point2D::new(box.max_x, box.min_y),
    @core.Point2D::new(box.max_x, box.max_y),
    @core.Point2D::new(box.min_x, box.max_y),
  ]
  polygon_polygon_collide(corners, poly)
}

///|
/// Compute AABB intersection (returns None if no overlap). / 计算 AABB 交集（无重叠返回 None）。
pub fn aabb_intersection(a : AABB, b : AABB) -> AABB? {
  if !aabb_overlap(a, b) {
    return None
  }
  let min_x = if a.min_x > b.min_x { a.min_x } else { b.min_x }
  let min_y = if a.min_y > b.min_y { a.min_y } else { b.min_y }
  let max_x = if a.max_x < b.max_x { a.max_x } else { b.max_x }
  let max_y = if a.max_y < b.max_y { a.max_y } else { b.max_y }
  Some(AABB::new(min_x, min_y, max_x, max_y))
}

///|
/// Compute AABB union. / 计算 AABB 并集。
pub fn aabb_union(a : AABB, b : AABB) -> AABB {
  let min_x = if a.min_x < b.min_x { a.min_x } else { b.min_x }
  let min_y = if a.min_y < b.min_y { a.min_y } else { b.min_y }
  let max_x = if a.max_x > b.max_x { a.max_x } else { b.max_x }
  let max_y = if a.max_y > b.max_y { a.max_y } else { b.max_y }
  AABB::new(min_x, min_y, max_x, max_y)
}

///|
/// Compute AABB area. / 计算 AABB 面积。
pub fn aabb_area(box : AABB) -> Double {
  (box.max_x - box.min_x) * (box.max_y - box.min_y)
}
