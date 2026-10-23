///|
test "dynamic hull basic" {
  let dh = DynamicHull::new()
  assert_eq(DynamicHull::size(dh), 0)
}

///|
test "dynamic hull insert" {
  let dh = DynamicHull::new()
  dh.insert(@core.Point2D::new(0.0, 0.0))
  dh.insert(@core.Point2D::new(4.0, 0.0))
  dh.insert(@core.Point2D::new(2.0, 4.0))
  dh.insert(@core.Point2D::new(2.0, 1.0))
  let h = DynamicHull::get_hull(dh)
  assert_eq(h.length(), 3)
}

///|
test "dynamic hull contains" {
  let dh = DynamicHull::new()
  dh.insert(@core.Point2D::new(0.0, 0.0))
  dh.insert(@core.Point2D::new(4.0, 0.0))
  dh.insert(@core.Point2D::new(2.0, 4.0))
  assert_true(DynamicHull::contains(dh, @core.Point2D::new(2.0, 1.0)))
}

///|
test "dynamic hull size" {
  let dh = DynamicHull::new()
  dh.insert(@core.Point2D::new(0.0, 0.0))
  dh.insert(@core.Point2D::new(1.0, 1.0))
  assert_eq(DynamicHull::size(dh), 2)
}

///|
test "dynamic hull square" {
  let dh = DynamicHull::new()
  dh.insert(@core.Point2D::new(0.0, 0.0))
  dh.insert(@core.Point2D::new(4.0, 0.0))
  dh.insert(@core.Point2D::new(4.0, 4.0))
  dh.insert(@core.Point2D::new(0.0, 4.0))
  dh.insert(@core.Point2D::new(2.0, 2.0))
  let h = DynamicHull::get_hull(dh)
  assert_eq(h.length(), 4)
}
