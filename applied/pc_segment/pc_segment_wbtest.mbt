///|
test "segment_by_height" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.1),
    @core.Point3D::new(1.0, 0.0, 0.2),
    @core.Point3D::new(0.0, 1.0, 2.0),
  ]
  let (g, ng) = segment_by_height(pts, 1.0)
  assert_eq(g.length(), 2)
  assert_eq(ng.length(), 1)
}

///|
test "segment_count" {
  let clusters = [[0, 1], [2, 3, 4], [5]]
  assert_eq(segment_count(clusters), 3)
}

///|
test "segment_by_distance empty" {
  let clusters = segment_by_distance([], 1.0)
  assert_true(clusters.length() == 0)
}

///|
test "segment_by_distance single" {
  let pts = [@core.Point3D::new(0.0, 0.0, 0.0)]
  let clusters = segment_by_distance(pts, 1.0)
  assert_eq(clusters.length(), 1)
}

///|
test "segment_by_distance two_clusters" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(0.5, 0.0, 0.0),
    @core.Point3D::new(10.0, 0.0, 0.0),
    @core.Point3D::new(10.5, 0.0, 0.0),
  ]
  let clusters = segment_by_distance(pts, 1.0)
  assert_eq(clusters.length(), 2)
}

///|
test "segment_by_distance all_one_cluster" {
  let pts = [
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(0.5, 0.0, 0.0),
    @core.Point3D::new(1.0, 0.0, 0.0),
  ]
  let clusters = segment_by_distance(pts, 1.0)
  assert_eq(clusters.length(), 1)
}
