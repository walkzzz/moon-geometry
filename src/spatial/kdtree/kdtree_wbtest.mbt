test "kdtree_build" {
  let points = [
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(5.0, 4.0),
    @core.Point2D::new(9.0, 6.0),
    @core.Point2D::new(4.0, 7.0),
    @core.Point2D::new(8.0, 1.0),
    @core.Point2D::new(7.0, 2.0),
  ]
  let nodes = build_kdtree(points)
  assert_true(nodes.length() > 0)
}

test "kdtree_nearest" {
  let points = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(0.0, 10.0),
    @core.Point2D::new(10.0, 10.0),
  ]
  let nodes = build_kdtree(points)
  let query = @core.Point2D::new(1.0, 1.0)
  match kdtree_nearest(nodes, query) {
    Some((idx, dist)) => {
      assert_eq(idx, 0)
      assert_true(@core.approx_eq(dist, 1.4142135623730951, 0.0001))
    }
    None => assert_true(false)
  }
}

test "kdtree_range_query" {
  let points = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(8.0, 8.0),
    @core.Point2D::new(3.0, 2.0),
  ]
  let nodes = build_kdtree(points)
  let rect = @core.Rectangle::new(0.0, 0.0, 4.0, 4.0)
  let result = kdtree_range_query(nodes, rect)
  assert_eq(result.length(), 3)
}

test "kdtree_empty" {
  let points : Array[@core.Point2D] = []
  let nodes = build_kdtree(points)
  assert_eq(nodes.length(), 0)
  let query = @core.Point2D::new(0.0, 0.0)
  match kdtree_nearest(nodes, query) {
    Some(_) => assert_true(false)
    None => assert_true(true)
  }
}

test "kdtree_single" {
  let points = [@core.Point2D::new(3.0, 4.0)]
  let nodes = build_kdtree(points)
  let query = @core.Point2D::new(0.0, 0.0)
  match kdtree_nearest(nodes, query) {
    Some((idx, _)) => assert_eq(idx, 0)
    None => assert_true(false)
  }
}