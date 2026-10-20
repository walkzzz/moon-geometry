///|
/// # RRT / RRT* / Bidirectional RRT
/// # RRT / RRT* / 双向 RRT
///
/// Rapidly-exploring Random Trees for motion planning in 2D.
/// 二维运动规划的快速探索随机树。
///
/// ## Complexity: O(n * k) where n = iterations, k = nearest neighbor cost
/// ## 复杂度: O(n * k)，n = 迭代次数，k = 最近邻代价

///|
/// RRT node storing a point and parent index. / RRT 节点，存储点和父索引。
pub struct RRTNode {
  point : @core.Point2D
  parent : Int
}

///|
/// Construct an RRT node. / 构造 RRT 节点。
pub fn RRTNode::new(point : @core.Point2D, parent : Int) -> RRTNode {
  { point, parent }
}

///|
/// RRT planner configuration. / RRT 规划器配置。
pub struct RRTConfig {
  step_size : Double
  max_iterations : Int
  goal_bias : Double
  goal_radius : Double
  seed : UInt
  x_min : Double
  x_max : Double
  y_min : Double
  y_max : Double
}

///|
/// Construct RRT configuration. / 构造 RRT 配置。
pub fn RRTConfig::new(
  step_size : Double,
  max_iterations : Int,
  goal_bias : Double,
  goal_radius : Double,
  seed : UInt,
  x_min : Double,
  x_max : Double,
  y_min : Double,
  y_max : Double,
) -> RRTConfig {
  { step_size, max_iterations, goal_bias, goal_radius, seed, x_min, x_max, y_min, y_max }
}

///|
/// RRT planning result. / RRT 规划结果。
pub struct RRTResult {
  path : Array[@core.Point2D]
  success : Bool
  iterations : Int
}

///|
/// Construct RRT result. / 构造 RRT 结果。
pub fn RRTResult::new(
  path : Array[@core.Point2D],
  success : Bool,
  iterations : Int,
) -> RRTResult {
  { path, success, iterations }
}

fn rng_next(state : UInt) -> UInt {
  state * 1103515245U + 12345U
}

fn rng_double(state : UInt) -> (Double, UInt) {
  let s = rng_next(state)
  ((s % 1000000U).to_double() / 1000000.0, s)
}

fn point_dist(a : @core.Point2D, b : @core.Point2D) -> Double {
  a.dist(b)
}

fn nearest_node(
  nodes : Array[RRTNode],
  target : @core.Point2D,
) -> Int {
  let mut best = 0
  let mut best_d = point_dist(nodes[0].point, target)
  for i in 1..<nodes.length() {
    let d = point_dist(nodes[i].point, target)
    if d < best_d {
      best_d = d
      best = i
    }
  }
  best
}

fn steer(
  from : @core.Point2D,
  to : @core.Point2D,
  step : Double,
) -> @core.Point2D {
  let d = point_dist(from, to)
  if d <= step {
    return to
  }
  let t = step / d
  @core.Point2D::new(from.x() + (to.x() - from.x()) * t, from.y() + (to.y() - from.y()) * t)
}

fn segment_hits_obstacle(
  a : @core.Point2D,
  b : @core.Point2D,
  obstacles : Array[Array[@core.Point2D]],
) -> Bool {
  for k in 0..<obstacles.length() {
    let obs = obstacles[k]
    let m = obs.length()
    for e in 0..<m {
      if seg_cross(a, b, obs[e], obs[(e + 1) % m]) {
        return true
      }
    }
  }
  false
}

fn seg_cross(
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

///|
/// Compute the total length of an RRT path. / 计算 RRT 路径总长度。
pub fn rrt_path_length(path : Array[@core.Point2D]) -> Double {
  let mut sum = 0.0
  for i in 1..<path.length() {
    sum += point_dist(path[i - 1], path[i])
  }
  sum
}

///|
/// Count nodes in an RRT tree. / 统计 RRT 树中节点数。
pub fn rrt_node_count(nodes : Array[RRTNode]) -> Int {
  nodes.length()
}