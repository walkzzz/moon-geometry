test "pharmacophore distance" {
  let d = pharmacophore_distance([0.0, 0.0], [3.0, 4.0])
  assert_eq(d, 5.0)
}

test "docking score compat" {
  let s = docking_score_compat(5.0, 5.0, 1.0)
  assert_eq(s, 1.0)
}

test "clash detection" {
  assert_true(clash_detection(2.0, 1.7, 1.7))
  assert_true(!clash_detection(5.0, 1.7, 1.7))
}
