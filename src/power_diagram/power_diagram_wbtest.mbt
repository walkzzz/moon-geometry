test "power_distance" {
  let s = WeightedPoint::new(@core.Point2D::new(0.0, 0.0), 1.0)
  let x = @core.Point2D::new(3.0, 4.0)
  let pd = power_distance(x, s)
  assert_true((pd - 24.0).abs() < 0.0000001)
}

test "WeightedPoint::new" {
  let wp = WeightedPoint::new(@core.Point2D::new(1.0, 2.0), 3.0)
  assert_true((wp.point.x() - 1.0).abs() < 0.0000001)
  assert_true((wp.weight - 3.0).abs() < 0.0000001)
}

test "power_diagram empty" {
  let pd = power_diagram([], (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0)))
  assert_eq(pd.cell_count(), 0)
}

test "power_diagram two sites" {
  let sites = [
    WeightedPoint::new(@core.Point2D::new(2.0, 5.0), 0.0),
    WeightedPoint::new(@core.Point2D::new(8.0, 5.0), 0.0),
  ]
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let pd = power_diagram(sites, bounds)
  assert_eq(pd.cell_count(), 2)
}

test "power_diagram weighted" {
  let sites = [
    WeightedPoint::new(@core.Point2D::new(3.0, 5.0), 4.0),
    WeightedPoint::new(@core.Point2D::new(7.0, 5.0), 0.0),
  ]
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let pd = power_diagram(sites, bounds)
  assert_eq(pd.cell_count(), 2)
  let area0 = power_cell_area(pd, 0)
  let area1 = power_cell_area(pd, 1)
  assert_true(area0 > 0.0)
  assert_true(area1 > 0.0)
}

test "power_cell" {
  let sites = [
    WeightedPoint::new(@core.Point2D::new(2.0, 2.0), 0.0),
    WeightedPoint::new(@core.Point2D::new(8.0, 8.0), 0.0),
  ]
  let bounds = (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(10.0, 10.0))
  let pd = power_diagram(sites, bounds)
  let cell = power_cell(pd, 0)
  assert_eq(cell.site_idx, 0)
  assert_true(cell.vertices.length() >= 3)
}

test "power_cell invalid" {
  let pd = PowerDiagram::new()
  let cell = power_cell(pd, 99)
  assert_eq(cell.site_idx, 99)
  assert_eq(cell.vertices.length(), 0)
}

test "regular_triangulation" {
  let sites = [
    WeightedPoint::new(@core.Point2D::new(0.0, 0.0), 0.0),
    WeightedPoint::new(@core.Point2D::new(4.0, 0.0), 0.0),
    WeightedPoint::new(@core.Point2D::new(2.0, 4.0), 0.0),
  ]
  let tris = regular_triangulation(sites)
  assert_true(tris.length() >= 1)
}

test "PowerDiagram::new" {
  let pd = PowerDiagram::new()
  assert_eq(pd.cell_count(), 0)
}