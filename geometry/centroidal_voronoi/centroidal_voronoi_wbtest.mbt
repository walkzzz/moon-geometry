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

///|
test "compute_centroid empty" {
  let c = compute_centroid([])
  assert_true((c.x() - 0.0).abs() < 0.0000001)
  assert_true((c.y() - 0.0).abs() < 0.0000001)
}

///|
test "compute_centroid two points" {
  let poly = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 6.0)]
  let c = compute_centroid(poly)
  assert_true((c.x() - 2.0).abs() < 0.0000001)
  assert_true((c.y() - 3.0).abs() < 0.0000001)
}

///|
test "compute_centroid collinear" {
  // Collinear points => zero area => fallback to vertex average
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(4.0, 4.0),
  ]
  let c = compute_centroid(poly)
  assert_true((c.x() - 2.0).abs() < 0.0000001)
  assert_true((c.y() - 2.0).abs() < 0.0000001)
}

///|
test "clip_by_bisector empty" {
  let s1 = @core.Point2D::new(2.0, 2.0)
  let s2 = @core.Point2D::new(8.0, 8.0)
  let result = clip_by_bisector([], s1, s2)
  assert_eq(result.length(), 0)
}

///|
test "clip_by_bisector keeps closer half" {
  // Square box, bisector of s1=(2,2) and s2=(8,2) is x=5; keep x <= 5
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let s1 = @core.Point2D::new(2.0, 2.0)
  let s2 = @core.Point2D::new(8.0, 2.0)
  let result = clip_by_bisector(poly, s1, s2)
  // Left half: (0,0),(5,0),(5,10),(0,10)
  assert_eq(result.length(), 4)
  assert_true((result[1].x() - 5.0).abs() < 0.0000001)
}

///|
test "voronoi_cell single site" {
  let sites = [@core.Point2D::new(5.0, 5.0)]
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let cell = voronoi_cell(sites, 0, bounds)
  // Single site: cell is the whole bounds box
  assert_eq(cell.length(), 4)
}

///|
test "voronoi_cell two sites" {
  let sites = [@core.Point2D::new(2.0, 5.0), @core.Point2D::new(8.0, 5.0)]
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let cell0 = voronoi_cell(sites, 0, bounds)
  // Site 0 cell is left half x <= 5
  assert_true(cell0.length() >= 3)
}

///|
test "lloyd_iteration empty sites" {
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let result = lloyd_iteration([], bounds, 10)
  assert_eq(result.length(), 0)
}

///|
test "lloyd_iteration zero iterations" {
  let sites = [@core.Point2D::new(2.0, 5.0), @core.Point2D::new(8.0, 5.0)]
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let result = lloyd_iteration(sites, bounds, 0)
  assert_eq(result.length(), 2)
  assert_true((result[0].x() - 2.0).abs() < 0.0000001)
}

///|
test "lloyd_energy degenerate cell" {
  // Site far outside bounds => its Voronoi cell is empty (< 3 vertices)
  let sites = [@core.Point2D::new(5.0, 5.0), @core.Point2D::new(50.0, 5.0)]
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let e = lloyd_energy(sites, bounds)
  assert_true(e >= 0.0)
}

///|
test "centroidal_voronoi empty sites" {
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let cvt = centroidal_voronoi([], bounds, 10)
  assert_eq(cvt.sites.length(), 0)
  assert_eq(cvt.cells.length(), 0)
  // Empty sites: loop body runs once with max_move=0, actual_iter increments
  // to 1 before the convergence break check fires.
  assert_eq(cvt.iterations, 1)
}

///|
test "centroidal_voronoi zero iterations" {
  let sites = [@core.Point2D::new(2.0, 5.0), @core.Point2D::new(8.0, 5.0)]
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let cvt = centroidal_voronoi(sites, bounds, 0)
  assert_eq(cvt.sites.length(), 2)
  assert_eq(cvt.iterations, 0)
}

///|
test "lloyd_iteration degenerate cell" {
  // Site far outside bounds => its Voronoi cell is empty (< 3 vertices),
  // exercising the `cell.length() < 3` continue branch in lloyd_iteration.
  let sites = [@core.Point2D::new(5.0, 5.0), @core.Point2D::new(50.0, 5.0)]
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let result = lloyd_iteration(sites, bounds, 5)
  assert_eq(result.length(), 2)
}

///|
test "centroidal_voronoi degenerate cell" {
  // Same far-outside site config, but exercising the `cell.length() < 3`
  // continue branch inside centroidal_voronoi's own iteration loop.
  let sites = [@core.Point2D::new(5.0, 5.0), @core.Point2D::new(50.0, 5.0)]
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let cvt = centroidal_voronoi(sites, bounds, 5)
  assert_eq(cvt.sites.length(), 2)
}
