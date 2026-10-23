///|
/// Metric tree node for nearest neighbor search in metric spaces. / 度量树节点，用于度量空间最近邻搜索。
pub struct MetricNode {
  point : @core.Point2D
  radius : Double
  left : MetricNode?
  right : MetricNode?
}
