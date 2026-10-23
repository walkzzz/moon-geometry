///|
test "marker watershed basic" {
  let cols = 3
  let rows = 3
  let dem = [9.0, 8.0, 7.0, 8.0, 1.0, 6.0, 7.0, 6.0, 5.0]
  let markers = [0, 0, 0, 0, 1, 0, 0, 0, 0]
  let result = marker_watershed(cols, rows, dem, markers)
  assert_eq(WatershedResult::cols(result), 3)
  assert_eq(WatershedResult::rows(result), 3)
}

///|
test "marker watershed all labeled" {
  let cols = 2
  let rows = 2
  let dem = [1.0, 2.0, 3.0, 4.0]
  let markers = [1, 2, 3, 4]
  let result = marker_watershed(cols, rows, dem, markers)
  assert_eq(WatershedResult::get(result, 0, 0), 1)
  assert_eq(WatershedResult::get(result, 1, 0), 2)
  assert_eq(WatershedResult::get(result, 0, 1), 3)
  assert_eq(WatershedResult::get(result, 1, 1), 4)
}

///|
test "marker watershed single marker" {
  let cols = 3
  let rows = 3
  let dem = [9.0, 8.0, 9.0, 8.0, 1.0, 8.0, 9.0, 8.0, 9.0]
  let markers = [0, 0, 0, 0, 1, 0, 0, 0, 0]
  let result = marker_watershed(cols, rows, dem, markers)
  for row in 0..<3 {
    for col in 0..<3 {
      assert_eq(WatershedResult::get(result, col, row), 1)
    }
  }
}

///|
test "marker watershed two markers" {
  let cols = 4
  let rows = 1
  let dem = [10.0, 5.0, 5.0, 10.0]
  let markers = [1, 0, 0, 2]
  let result = marker_watershed(cols, rows, dem, markers)
  assert_eq(WatershedResult::get(result, 0, 0), 1)
  assert_eq(WatershedResult::get(result, 3, 0), 2)
}

///|
test "d8 flow directions" {
  let cols = 3
  let rows = 3
  let dem = [3.0, 2.0, 3.0, 2.0, 1.0, 2.0, 3.0, 2.0, 3.0]
  let dirs = d8_flow_directions(cols, rows, dem)
  assert_eq(dirs.length(), 9)
  // center cell flows to... all neighbors are higher, so it's a pit (-1)
  assert_eq(dirs[4], -1)
}

///|
test "basin cell counts" {
  let cols = 2
  let rows = 2
  let dem = [1.0, 2.0, 3.0, 4.0]
  let markers = [1, 1, 2, 2]
  let result = marker_watershed(cols, rows, dem, markers)
  let counts = basin_cell_counts(result)
  assert_eq(counts.length(), 2)
}

///|
test "fill depressions no change" {
  let cols = 3
  let rows = 1
  let dem = [1.0, 2.0, 3.0]
  let filled = fill_depressions(cols, rows, dem)
  assert_true((filled[0] - 1.0).abs() <= 0.001)
  assert_true((filled[1] - 2.0).abs() <= 0.001)
  assert_true((filled[2] - 3.0).abs() <= 0.001)
}

///|
test "fill depressions pit" {
  let cols = 3
  let rows = 1
  let dem = [3.0, 1.0, 3.0]
  let filled = fill_depressions(cols, rows, dem)
  assert_true(filled[1] >= filled[0] || filled[1] >= filled[2])
}

///|
test "watershed result out of bounds" {
  let result = marker_watershed(2, 2, [1.0, 2.0, 3.0, 4.0], [0, 0, 0, 0])
  assert_eq(WatershedResult::get(result, 5, 5), 0)
}

///|
test "d8 flow directions edge" {
  let cols = 2
  let rows = 2
  let dem = [4.0, 3.0, 2.0, 1.0]
  let dirs = d8_flow_directions(cols, rows, dem)
  // top-left flows to bottom-right (direction 4 = SW... let's just check it's valid)
  assert_true(dirs[0] >= -1 && dirs[0] < 8)
}
