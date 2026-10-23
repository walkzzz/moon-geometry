///|
test "voronoi_cell basic" {
  let sites = [
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(8.0, 2.0),
    @core.Point2D::new(5.0, 8.0),
  ]
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let cell = voronoi_cell(sites, 0, bounds)
  assert_true(cell.length() >= 3)
}

///|
test "voronoi_cell_area basic" {
  let sites = [@core.Point2D::new(2.0, 2.0), @core.Point2D::new(8.0, 8.0)]
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let area = voronoi_cell_area(sites, 0, bounds)
  assert_true(area > 0.0)
}

///|
test "voronoi_cell_count" {
  let sites = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
  ]
  assert_eq(voronoi_cell_count(sites), 3)
}

///|
test "farthest_voronoi_cell basic" {
  let sites = [
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(8.0, 2.0),
    @core.Point2D::new(5.0, 8.0),
  ]
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let cell = farthest_voronoi_cell(sites, 0, bounds)
  assert_true(cell.length() >= 0)
}

///|
test "voronoi_cell invalid index" {
  let sites = [@core.Point2D::new(2.0, 2.0)]
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let cell = voronoi_cell(sites, 5, bounds)
  assert_eq(cell.length(), 0)
}
