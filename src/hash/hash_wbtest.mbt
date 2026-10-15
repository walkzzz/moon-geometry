test "hash_cell_index" {
  let p = @core.Point2D::new(5.5, 3.2)
  let (cx, cy) = cell_index(p, 1.0)
  assert_eq(cx, 5)
  assert_eq(cy, 3)
}

test "hash_cell_index_negative" {
  let p = @core.Point2D::new(-2.5, -3.7)
  let (cx, cy) = cell_index(p, 1.0)
  assert_eq(cx, -3)
  assert_eq(cy, -4)
}

test "hash_cell_hash_consistency" {
  let p = @core.Point2D::new(5.5, 3.2)
  let h1 = cell_hash(p, 1.0, 1000)
  let h2 = cell_hash(p, 1.0, 1000)
  assert_eq(h1, h2)
}

test "hash_cell_hash_range" {
  let p = @core.Point2D::new(123.4, -56.7)
  let h = cell_hash(p, 1.0, 100)
  assert_true(h >= 0)
  assert_true(h < 100)
}

test "hash_segment_cells" {
  let seg = @core.Segment::new(
    @core.Point2D::new(1.5, 2.5),
    @core.Point2D::new(3.5, 4.5),
  )
  let ((x1, y1), (x2, y2)) = segment_cells(seg, 1.0)
  assert_eq(x1, 1)
  assert_eq(y1, 2)
  assert_eq(x2, 3)
  assert_eq(y2, 4)
}

test "hash_combine" {
  let h = hash_combine(10, 20)
  assert_eq(h, 10 * 31 + 20)
}

test "hash_cell_index_3d" {
  let p = @core.Point3D::new(1.5, 2.5, 3.5)
  let (cx, cy, cz) = cell_index_3d(p, 1.0)
  assert_eq(cx, 1)
  assert_eq(cy, 2)
  assert_eq(cz, 3)
}

test "hash_segment_hash_range" {
  let seg = @core.Segment::new(
    @core.Point2D::new(1.5, 2.5),
    @core.Point2D::new(3.5, 4.5),
  )
  let h = segment_hash(seg, 1.0, 100)
  assert_true(h >= 0)
  assert_true(h < 100)
}