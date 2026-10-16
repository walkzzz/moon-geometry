test "reflect" {
  let r = reflect((1.0, -1.0, 0.0), (0.0, 1.0, 0.0))
  assert_true(r.0 > 0.99 && r.0 < 1.01)
  assert_true(r.1 > 0.99 && r.1 < 1.01)
}
test "fresnel_schlick" {
  let f = fresnel_schlick(1.0, 0.04)
  assert_true(f > 0.03 && f < 0.05)
}
