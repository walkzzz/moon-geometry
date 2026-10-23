///|
test "compute_centroid triangle" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(3.0, 6.0),
  ]
  let c = compute_centroid(poly)
  assert_true((c.x() - 3.0).abs() < 0.0000001)
  assert_true((c.y() - 2.0).abs() < 0.0000001)
}

///|
test "compute_centroid square" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let c = compute_centroid(poly)
  assert_true((c.x() - 2.0).abs() < 0.0000001)
  assert_true((c.y() - 2.0).abs() < 0.0000001)
}

///|
test "compute_centroid degenerate" {
  let poly = [@core.Point2D::new(1.0, 2.0)]
  let c = compute_centroid(poly)
  assert_true((c.x() - 1.0).abs() < 0.0000001)
  assert_true((c.y() - 2.0).abs() < 0.0000001)
}

///|
test "lloyd_energy" {
  let sites = [@core.Point2D::new(2.0, 2.0), @core.Point2D::new(8.0, 8.0)]
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let e = lloyd_energy(sites, bounds)
  assert_true(e > 0.0)
}

///|
test "lloyd_iteration" {
  let sites = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(9.0, 1.0),
    @core.Point2D::new(1.0, 9.0),
    @core.Point2D::new(9.0, 9.0),
  ]
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let result = lloyd_iteration(sites, bounds, 10)
  assert_eq(result.length(), 4)
}

///|
test "lloyd_iteration convergence" {
  let sites = [@core.Point2D::new(2.0, 5.0), @core.Point2D::new(8.0, 5.0)]
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let result = lloyd_iteration(sites, bounds, 100)
  assert_true((result[0].x() - 2.5).abs() < 0.01)
  assert_true((result[1].x() - 7.5).abs() < 0.01)
}

///|
test "centroidal_voronoi" {
  let sites = [
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(8.0, 2.0),
    @core.Point2D::new(5.0, 8.0),
  ]
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let cvt = centroidal_voronoi(sites, bounds, 20)
  assert_eq(cvt.sites.length(), 3)
  assert_eq(cvt.cells.length(), 3)
  assert_true(cvt.iterations >= 1)
}

///|
test "CVTResult::new" {
  let r = CVTResult::new()
  assert_eq(r.sites.length(), 0)
  assert_eq(r.iterations, 0)
}

///|
test "lloyd_energy zero sites" {
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let e = lloyd_energy([], bounds)
  assert_true(e == 0.0)
}
