///|
/// Plan a path using basic RRT. / 使用基本 RRT 规划路径。
///
/// # Arguments / 参数
/// - `config`: planner configuration / 规划器配置
/// - `start`: start point / 起始点
/// - `goal`: goal point / 目标点
/// - `obstacles`: polygonal obstacles / 多边形障碍物
///
/// Returns the planning result. / 返回规划结果。
pub fn rrt_plan(
  config : RRTConfig,
  start : @core.Point2D,
  goal : @core.Point2D,
  obstacles : Array[Array[@core.Point2D]],
) -> RRTResult {
  let nodes : Array[RRTNode] = [RRTNode::new(start, -1)]
  let mut state = config.seed
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
    nodes.push(RRTNode::new(new_pt, near_idx))
    if point_dist(new_pt, goal) <= config.goal_radius {
      let path = reconstruct_path(nodes, nodes.length() - 1)
      path_push_goal(path, goal, obstacles)
      return RRTResult::new(path, true, iter + 1)
    }
  }
  RRTResult::new([], false, config.max_iterations)
}

fn reconstruct_path(nodes : Array[RRTNode], idx : Int) -> Array[@core.Point2D] {
  let path : Array[@core.Point2D] = []
  let mut cur = idx
  while cur != -1 {
    path.insert(0, nodes[cur].point)
    cur = nodes[cur].parent
  }
  path
}

fn path_push_goal(
  path : Array[@core.Point2D],
  goal : @core.Point2D,
  obstacles : Array[Array[@core.Point2D]],
) -> Unit {
  if path.length() == 0 {
    path.push(goal)
    return
  }
  let last = path[path.length() - 1]
  if !segment_hits_obstacle(last, goal, obstacles) {
    path.push(goal)
  }
}
