test "build_metric_tree" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
  ]
  let tree = build_metric_tree(pts)
  assert_true(tree is Some(_))
  assert_true(metric_tree_count(tree) == 4)
}

test "metric_tree_query" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
  ]
  let tree = build_metric_tree(pts)
  let result = metric_tree_query(tree, @core.Point2D::new(0.5, 0.0), 1.5)
  assert_true(result.length() >= 1)
}

test "metric_tree_count" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  let tree = build_metric_tree(pts)
  assert_true(metric_tree_count(tree) == 1)
}

test "metric_tree_nearest" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
  ]
  let tree = build_metric_tree(pts)
  let nn = metric_tree_nearest(tree, @core.Point2D::new(4.0, 0.0))
  assert_true(nn is Some(_))
}

test "metric_tree_empty" {
  let pts : Array[@core.Point2D] = []
  let tree = build_metric_tree(pts)
  assert_true(metric_tree_count(tree) == 0)
}