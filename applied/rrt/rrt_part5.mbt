///|
/// Plan a path using bidirectional RRT (RRT-Connect). / 使用双向 RRT 规划路径。
pub fn rrt_connect_plan(
  config : RRTConfig,
  start : @core.Point2D,
  goal : @core.Point2D,
  obstacles : Array[Array[@core.Point2D]],
) -> RRTResult {
  let tree_a : Array[RRTNode] = [RRTNode::new(start, -1)]
  let tree_b : Array[RRTNode] = [RRTNode::new(goal, -1)]
  let mut state = config.seed
  for iter in 0..<config.max_iterations {
    let (rx, s1) = rng_double(state)
    state = s1
    let (ry, s2) = rng_double(state)
    state = s2
    let sample = @core.Point2D::new(
      config.x_min + rx * (config.x_max - config.x_min),
      config.y_min + ry * (config.y_max - config.y_min),
    )
    let result = rrt_connect_extend(tree_a, sample, config.step_size, obstacles)
    if result >= 0 {
      let new_pt = tree_a[result].point
      let result_b = rrt_connect_extend(tree_b, new_pt, config.step_size, obstacles)
      if result_b >= 0 {
        if point_dist(tree_a[result].point, tree_b[result_b].point) <= config.step_size {
          let path_a = reconstruct_path(tree_a, result)
          let path_b = reconstruct_path(tree_b, result_b)
          let reversed_b : Array[@core.Point2D] = []
          for i in 0..<path_b.length() {
            reversed_b.push(path_b[path_b.length() - 1 - i])
          }
          let combined : Array[@core.Point2D] = []
          for i in 0..<path_a.length() {
            combined.push(path_a[i])
          }
          for i in 0..<reversed_b.length() {
            combined.push(reversed_b[i])
          }
          return RRTResult::new(combined, true, iter + 1)
        }
      }
    }
    ignore(tree_a)
    ignore(tree_b)
  }
  RRTResult::new([], false, config.max_iterations)
}

fn rrt_connect_extend(
  tree : Array[RRTNode],
  target : @core.Point2D,
  step : Double,
  obstacles : Array[Array[@core.Point2D]],
) -> Int {
  let near_idx = nearest_node(tree, target)
  let new_pt = steer(tree[near_idx].point, target, step)
  if segment_hits_obstacle(tree[near_idx].point, new_pt, obstacles) {
    return -1
  }
  tree.push(RRTNode::new(new_pt, near_idx))
  tree.length() - 1
}
