test "perturb_normal" {
  let n = perturb_normal((0.0, 0.0, 1.0), 0.0)
  assert_true(n.2 > 0.99 && n.2 < 1.01)
}
test "normal_from_height flat" {
  let n = normal_from_height(0.0, 0.0, 0.0, 1.0)
  assert_true(n.2 > 0.99 && n.2 < 1.01)
}
