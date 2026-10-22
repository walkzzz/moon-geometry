test "grid_index_build" {
  let points = [
    @core.Point2D::new(1.5, 2.5),
    @core.Point2D::new(3.5, 4.5),
    @core.Point2D::new(5.5, 6.5),
  ]
  let grid = build_grid_index(points, 1.0)
  assert_eq(grid_size(grid), 3)
}

test "grid_index_query_radius" {
  let points = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let grid = build_grid_index(points, 1.0)
  let center = @core.Point2D::new(0.0, 0.0)
  let result = grid_query_radius(grid, center, 1.5)
  assert_eq(result.length(), 3)
}

test "grid_index_query_rect" {
  let points = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(8.0, 8.0),
  ]
  let grid = build_grid_index(points, 1.0)
  let rect = @core.Rectangle::new(0.0, 0.0, 4.0, 4.0)
  let result = grid_query_rect(grid, rect)
  assert_eq(result.length(), 2)
}

test "grid_index_query_cell" {
  let points = [
    @core.Point2D::new(1.5, 2.5),
    @core.Point2D::new(1.7, 2.3),
    @core.Point2D::new(5.5, 6.5),
  ]
  let grid = build_grid_index(points, 1.0)
  let p = @core.Point2D::new(1.6, 2.4)
  let result = grid_query_cell(grid, p)
  assert_eq(result.length(), 2)
}

test "grid_index_empty" {
  let points : Array[@core.Point2D] = []
  let grid = build_grid_index(points, 1.0)
  assert_eq(grid_size(grid), 0)
}