///|
/// Build a PRM roadmap by sampling nodes and connecting neighbors. / 通过采样节点并连接邻居构建 PRM 路线图。
pub fn prm_build(
  config : PRMConfig,
  obstacles : Array[Array[@core.Point2D]],
) -> PRMRoadmap {
  let nodes : Array[@core.Point2D] = []
  let mut state = config.seed
  let mut attempts = 0
  let max_attempts = config.num_samples * 10
  while nodes.length() < config.num_samples && attempts < max_attempts {
    attempts += 1
    let (rx, s1) = rng_double(state)
    state = s1
    let (ry, s2) = rng_double(state)
    state = s2
    let p = @core.Point2D::new(
      config.x_min + rx * (config.x_max - config.x_min),
      config.y_min + ry * (config.y_max - config.y_min),
    )
    if !point_in_obstacle(p, obstacles) {
      nodes.push(p)
    }
  }
  let n = nodes.length()
  let edges : Array[Array[(Int32, Double)]] = []
  for _ in 0..<n {
    edges.push([])
  }
  for i in 0..<n {
    for j in (i + 1)..<n {
      let d = point_dist(nodes[i], nodes[j])
      if d <= config.connection_radius &&
        !segment_hits_obstacle(nodes[i], nodes[j], obstacles) {
        edges[i].push((j, d))
        edges[j].push((i, d))
      }
    }
  }
  PRMRoadmap::new(nodes, edges)
}

///|
fn point_in_obstacle(
  p : @core.Point2D,
  obstacles : Array[Array[@core.Point2D]],
) -> Bool {
  for k in 0..<obstacles.length() {
    if point_in_polygon(p, obstacles[k]) {
      return true
    }
  }
  false
}

///|
fn point_in_polygon(p : @core.Point2D, poly : Array[@core.Point2D]) -> Bool {
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
