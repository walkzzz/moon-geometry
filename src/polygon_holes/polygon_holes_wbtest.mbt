test "polygon_with_holes_area" {
  let outer = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let hole = [
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(7.0, 3.0),
    @core.Point2D::new(7.0, 7.0),
    @core.Point2D::new(3.0, 7.0),
  ]
  let p = polygon_with_holes_new(outer, [hole])
  let area = polygon_with_holes_area(p)
  assert_true((area - 84.0).abs() < 0.001)
}

test "polygon_with_holes_contains" {
  let outer = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let hole = [
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(7.0, 3.0),
    @core.Point2D::new(7.0, 7.0),
    @core.Point2D::new(3.0, 7.0),
  ]
  let p = polygon_with_holes_new(outer, [hole])
  assert_true(polygon_with_holes_contains(p, @core.Point2D::new(1.0, 1.0)))
  assert_false(polygon_with_holes_contains(p, @core.Point2D::new(5.0, 5.0)))
  assert_false(polygon_with_holes_contains(p, @core.Point2D::new(15.0, 15.0)))
}

test "polygon_with_holes_perimeter" {
  let outer = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let hole = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(1.0, 3.0),
  ]
  let p = polygon_with_holes_new(outer, [hole])
  let perim = polygon_with_holes_perimeter(p)
  assert_true((perim - 24.0).abs() < 0.001)
}

test "polygon_with_holes_count" {
  let outer = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
  ]
  let h1 = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(1.0, 2.0),
  ]
  let h2 = [
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(6.0, 5.0),
    @core.Point2D::new(6.0, 6.0),
    @core.Point2D::new(5.0, 6.0),
  ]
  let p = polygon_with_holes_new(outer, [h1, h2])
  assert_true(polygon_with_holes_count(p) == 2)
}

test "polygon_with_holes_no_holes" {
  let outer = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let p = polygon_with_holes_new(outer, [])
  assert_true((polygon_with_holes_area(p) - 16.0).abs() < 0.001)
  assert_true(polygon_with_holes_count(p) == 0)
}