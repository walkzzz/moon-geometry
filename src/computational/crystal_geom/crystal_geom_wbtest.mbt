test "point group order" {
  assert_eq(point_group_order(1), 1)
  assert_eq(point_group_order(48), 48)
}

test "space group count" {
  assert_eq(space_group_count_2d(), 17)
  assert_eq(space_group_count_3d(), 230)
}

test "bravais type" {
  let t = bravais_type(5.0, 5.0, 5.0, 1.5707963267948966, 1.5707963267948966, 1.5707963267948966)
  assert_eq(t, "cubic")
}
