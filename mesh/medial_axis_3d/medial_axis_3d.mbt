///|
/// # 3D Medial Axis (Voronoi Dual Method)
/// # 三维中轴（Voronoi 对偶方法）
///
/// Approximate medial axis via maximal empty spheres (Voronoi dual).
/// 通过最大空球（Voronoi 对偶）近似中轴。
///
/// ## Complexity: O(n^4) for triple-based search
/// ## 复杂度: 三元搜索为 O(n^4)

///|
/// Medial ball: center and radius of a maximal empty sphere.
/// 中轴球：最大空球的球心和半径。
pub struct MedialBall3D {
  center : @core.Point3D
  radius : Double
}

///|
/// Construct a medial ball. / 构造中轴球。
pub fn MedialBall3D::new(
  center : @core.Point3D,
  radius : Double,
) -> MedialBall3D {
  { center, radius, }
}

///|
/// Center accessor. / 球心访问器。
pub fn MedialBall3D::center(self : MedialBall3D) -> @core.Point3D {
  self.center
}

///|
/// Radius accessor. / 半径访问器。
pub fn MedialBall3D::radius(self : MedialBall3D) -> Double {
  self.radius
}

///|
/// Circumcenter and circumradius of 3 points (in their plane).
/// 三点的外心和外半径（在其平面内）。
fn circumcircle(
  p0 : @core.Point3D,
  p1 : @core.Point3D,
  p2 : @core.Point3D,
) -> MedialBall3D? {
  let a = p1.sub(p0)
  let b = p2.sub(p0)
  let aa = a.dot(a)
  let bb = b.dot(b)
  let ab = a.dot(b)
  let d = aa * bb - ab * ab
  if d.abs() < 0.000000000001 {
    return None
  }
  let s = bb * (aa - ab) / (2.0 * d)
  let t = aa * (bb - ab) / (2.0 * d)
  let center = p0.add(a.mul(s)).add(b.mul(t))
  let radius = center.dist(p0)
  Some(MedialBall3D::new(center, radius))
}

///|
/// Check if a ball is empty (no point strictly inside).
/// 检查球是否为空（无点严格在内部）。
fn is_empty_ball(
  ball : MedialBall3D,
  points : Array[@core.Point3D],
  eps : Double,
) -> Bool {
  for p in points {
    let d = ball.center.dist(p)
    if d < ball.radius - eps {
      return false
    }
  }
  true
}

///|
/// Medial axis from point pairs (midpoints of pairs with empty balls).
/// 由点对生成的中轴（空球对的中点）。
pub fn medial_axis_from_pairs(
  points : Array[@core.Point3D],
) -> Array[MedialBall3D] {
  let result : Array[MedialBall3D] = []
  let n = points.length()
  let eps = 0.0000001
  for i in 0..<n {
    for j in (i + 1)..<n {
      let mid = points[i].add(points[j]).mul(0.5)
      let r = points[i].dist(points[j]) / 2.0
      let ball = MedialBall3D::new(mid, r)
      if is_empty_ball(ball, points, eps) {
        result.push(ball)
      }
    }
  }
  result
}

///|
/// Medial axis from point triples (circumcenters with empty balls).
/// 由点三元组生成的中轴（空球外心）。
pub fn medial_axis_from_triples(
  points : Array[@core.Point3D],
) -> Array[MedialBall3D] {
  let result : Array[MedialBall3D] = []
  let n = points.length()
  let eps = 0.0000001
  for i in 0..<n {
    for j in (i + 1)..<n {
      for k in (j + 1)..<n {
        match circumcircle(points[i], points[j], points[k]) {
          Some(ball) =>
            if is_empty_ball(ball, points, eps) {
              result.push(ball)
            }
          None => continue
        }
      }
    }
  }
  result
}

///|
/// Full 3D medial axis: combine pair and triple medial balls.
/// 完整三维中轴：合并点对和点三元组中轴球。
pub fn medial_axis_3d(points : Array[@core.Point3D]) -> Array[MedialBall3D] {
  let result : Array[MedialBall3D] = []
  for ball in medial_axis_from_pairs(points) {
    result.push(ball)
  }
  for ball in medial_axis_from_triples(points) {
    result.push(ball)
  }
  result
}

///|
/// Filter medial balls by radius range. / 按半径范围过滤中轴球。
pub fn medial_axis_filter(
  balls : Array[MedialBall3D],
  r_min : Double,
  r_max : Double,
) -> Array[MedialBall3D] {
  let result : Array[MedialBall3D] = []
  for ball in balls {
    if ball.radius >= r_min && ball.radius <= r_max {
      result.push(ball)
    }
  }
  result
}

///|
/// Sort medial balls by radius descending (most significant first).
/// 按半径降序排列中轴球（最重要的在前）。
pub fn medial_axis_sort(balls : Array[MedialBall3D]) -> Array[MedialBall3D] {
  let result : Array[MedialBall3D] = []
  for b in balls {
    result.push(b)
  }
  result.sort_by(fn(b1, b2) {
    if b2.radius > b1.radius {
      1
    } else if b2.radius < b1.radius {
      -1
    } else {
      0
    }
  })
  result
}
