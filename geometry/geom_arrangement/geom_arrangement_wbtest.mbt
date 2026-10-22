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
