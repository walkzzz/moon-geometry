test "line arrangement count" {
  assert_eq(line_arrangement_count(3), 6)
}

test "line intersection" {
  let (x, y) = line_intersection(1.0, 1.0, 3.0, 1.0, -1.0, 1.0)
  assert_eq(x, 2.0)
  assert_eq(y, 1.0)
}

test "arrangement faces" {
  assert_eq(arrangement_faces(3), 7)
}
test "zone_complexity" {
  assert_eq(zone_complexity(3), 6)
  assert_eq(zone_complexity(10), 48)
}

test "hyperplane_arrangement_regions d1" {
  assert_eq(hyperplane_arrangement_regions(5, 1), 6)
}

test "hyperplane_arrangement_regions d2" {
  assert_eq(hyperplane_arrangement_regions(3, 2), 7)
}

test "hyperplane_arrangement_regions d3" {
  assert_eq(hyperplane_arrangement_regions(3, 3), 9)
}

test "is_simple_arrangement true" {
  assert_true(is_simple_arrangement([1.0, 2.0, 3.0]))
}

test "is_simple_arrangement false" {
  assert_false(is_simple_arrangement([1.0, 2.0, 1.0]))
}
