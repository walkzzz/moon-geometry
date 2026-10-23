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
