///|
/// Plan a path using RRT* (asymptotically optimal). / 使用 RRT* 规划路径（渐近最优）。
pub fn rrt_star_plan(
  config : RRTConfig,
  start : @core.Point2D,
  goal : @core.Point2D,
  obstacles : Array[Array[@core.Point2D]],
) -> RRTResult {
  let nodes : Array[RRTNode] = [RRTNode::new(start, -1)]
  let costs : Array[Double] = [0.0]
  let mut state = config.seed
  let rewire_radius = config.step_size * 2.0
  for iter in 0..<config.max_iterations {
    let (r1, s1) = rng_double(state)
    state = s1
    let sample = if r1 < config.goal_bias {
      goal
    } else {
      let (rx, s2) = rng_double(state)
      state = s2
      let (ry, s3) = rng_double(state)
      state = s3
      @core.Point2D::new(
        config.x_min + rx * (config.x_max - config.x_min),
        config.y_min + ry * (config.y_max - config.y_min),
      )
    }
    let near_idx = nearest_node(nodes, sample)
    let new_pt = steer(nodes[near_idx].point, sample, config.step_size)
    if segment_hits_obstacle(nodes[near_idx].point, new_pt, obstacles) {
      continue
    }
    let mut best_parent = near_idx
    let mut best_cost = costs[near_idx] + point_dist(nodes[near_idx].point, new_pt)
    for i in 0..<nodes.length() {
      if i == near_idx {
        continue
      }
      let d = point_dist(nodes[i].point, new_pt)
      if d <= rewire_radius {
        let c = costs[i] + d
        if c < best_cost && !segment_hits_obstacle(nodes[i].point, new_pt, obstacles) {
          best_cost = c
          best_parent = i
        }
      }
    }
    let new_idx = nodes.length()
    nodes.push(RRTNode::new(new_pt, best_parent))
    costs.push(best_cost)
    for i in 0..<new_idx {
      if i == best_parent {
        continue
      }
      let d = point_dist(nodes[i].point, new_pt)
      if d <= rewire_radius {
        let c = best_cost + d
        if c < costs[i] && !segment_hits_obstacle(nodes[i].point, new_pt, obstacles) {
          nodes[i] = RRTNode::new(nodes[i].point, new_idx)
          costs[i] = c
        }
      }
    }
    if point_dist(new_pt, goal) <= config.goal_radius {
      let path = reconstruct_path(nodes, nodes.length() - 1)
      path_push_goal(path, goal, obstacles)
      return RRTResult::new(path, true, iter + 1)
    }
  }
  RRTResult::new([], false, config.max_iterations)
}
