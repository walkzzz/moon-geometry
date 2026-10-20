test "marching squares flat" {
  let g = ContourGrid::new(3, 3, [5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0], 1.0, 0.0, 0.0)
  let segs = marching_squares(g, 10.0)
  assert_eq(segs.length(), 0)
}

test "marching squares simple gradient" {
  let g = ContourGrid::new(3, 2, [0.0, 5.0, 10.0, 0.0, 5.0, 10.0], 1.0, 0.0, 0.0)
  let segs = marching_squares(g, 5.0)
  assert_true(segs.length() > 0)
}

test "marching squares single peak" {
  let g = ContourGrid::new(3, 3, [0.0, 0.0, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0, 0.0], 1.0, 0.0, 0.0)
  let segs = marching_squares(g, 5.0)
  assert_true(segs.length() > 0)
}

test "marching squares no crossing" {
  let g = ContourGrid::new(3, 3, [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], 1.0, 0.0, 0.0)
  let segs = marching_squares(g, 5.0)
  assert_eq(segs.length(), 0)
}

test "extract contours multiple levels" {
  let g = ContourGrid::new(3, 3, [0.0, 3.0, 6.0, 3.0, 6.0, 9.0, 6.0, 9.0, 12.0], 1.0, 0.0, 0.0)
  let result = extract_contours(g, [5.0, 8.0])
  assert_eq(result.length(), 2)
}

test "label cell basic" {
  let g = ContourGrid::new(3, 3, [0.0, 0.0, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0, 0.0], 1.0, 0.0, 0.0)
  let label = label_cell(g, 0, 0, 5.0)
  assert_true(label >= 0 && label <= 15)
}

test "label cell out of bounds" {
  let g = ContourGrid::new(3, 3, [0.0, 0.0, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0, 0.0], 1.0, 0.0, 0.0)
  let label = label_cell(g, 5, 5, 5.0)
  assert_eq(label, -1)
}

test "count contour segments" {
  let g = ContourGrid::new(3, 3, [0.0, 3.0, 6.0, 3.0, 6.0, 9.0, 6.0, 9.0, 12.0], 1.0, 0.0, 0.0)
  let count = count_contour_segments(g, 5.0)
  assert_true(count >= 0)
}

test "contour segment construct" {
  let s = ContourSegment::new(1.0, 2.0, 3.0, 4.0)
  assert_true(((s.x1) - (1.0)).abs() <= (0.001))
  assert_true(((s.y2) - (4.0)).abs() <= (0.001))
}

test "marching squares saddle" {
  let g = ContourGrid::new(3, 3, [10.0, 0.0, 10.0, 0.0, 5.0, 0.0, 10.0, 0.0, 10.0], 1.0, 0.0, 0.0)
  let segs = marching_squares(g, 5.0)
  assert_true(segs.length() >= 0)
}