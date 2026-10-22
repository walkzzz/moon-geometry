test "bucket_pr_build" {
  let points = [
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(5.0, 4.0),
    @core.Point2D::new(9.0, 6.0),
    @core.Point2D::new(4.0, 7.0),
    @core.Point2D::new(8.0, 1.0),
  ]
  let nodes = build_bucket_pr(points, 2)
  assert_eq(bucket_pr_count(nodes), 5)
}

test "bucket_pr_nearest" {
  let points = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(0.0, 10.0),
    @core.Point2D::new(10.0, 10.0),
  ]
  let nodes = build_bucket_pr(points, 1)
  let query = @core.Point2D::new(1.0, 1.0)
  match bucket_pr_nearest(nodes, points, query) {
    Some((idx, _)) => assert_eq(idx, 0)
    None => assert_true(false)
  }
}

test "bucket_pr_count" {
  let points = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(3.0, 3.0),
  ]
  let nodes = build_bucket_pr(points, 2)
  assert_eq(bucket_pr_count(nodes), 3)
}

test "bucket_pr_empty" {
  let points : Array[@core.Point2D] = []
  let nodes = build_bucket_pr(points, 2)
  assert_eq(nodes.length(), 0)
}

test "bucket_pr_single" {
  let points = [@core.Point2D::new(3.0, 4.0)]
  let nodes = build_bucket_pr(points, 2)
  let query = @core.Point2D::new(0.0, 0.0)
  match bucket_pr_nearest(nodes, points, query) {
    Some((idx, _)) => assert_eq(idx, 0)
    None => assert_true(false)
  }
}