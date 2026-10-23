///|
test "spatial_hash_build" {
  let points = [
    @core.Point2D::new(1.5, 2.5),
    @core.Point2D::new(3.5, 4.5),
    @core.Point2D::new(5.5, 6.5),
  ]
  let hash = build_spatial_hash(points, 1.0)
  assert_eq(spatial_hash_size(hash), 3)
}

///|
test "spatial_hash_query_radius" {
  let points = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let hash = build_spatial_hash(points, 1.0)
  let center = @core.Point2D::new(0.0, 0.0)
  let result = spatial_hash_query_radius(hash, center, 1.5)
  assert_eq(result.length(), 3)
}

///|
test "spatial_hash_query_rect" {
  let points = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(8.0, 8.0),
  ]
  let hash = build_spatial_hash(points, 1.0)
  let rect = @core.Rectangle::new(0.0, 0.0, 4.0, 4.0)
  let result = spatial_hash_query_rect(hash, rect)
  assert_eq(result.length(), 2)
}

///|
test "spatial_hash_nearby" {
  let points = [
    @core.Point2D::new(1.5, 1.5),
    @core.Point2D::new(1.7, 1.3),
    @core.Point2D::new(5.5, 5.5),
    @core.Point2D::new(2.5, 1.5),
  ]
  let hash = build_spatial_hash(points, 1.0)
  let p = @core.Point2D::new(1.6, 1.4)
  let result = spatial_hash_nearby(hash, p)
  assert_true(result.length() >= 2)
}

///|
test "spatial_hash_empty" {
  let points : Array[@core.Point2D] = []
  let hash = build_spatial_hash(points, 1.0)
  assert_eq(spatial_hash_size(hash), 0)
}
