test "grasp_contact_normal" {
  let n = grasp_contact_normal((0.0, 0.0, 0.0), (1.0, 0.0, 0.0))
  assert_true(n.0 > 0.99 && n.0 < 1.01)
}
test "grasp_force_closure balanced" {
  let v = grasp_force_closure([(1.0, 0.0, 0.0), (-1.0, 0.0, 0.0)], [(1.0, 0.0, 0.0), (-1.0, 0.0, 0.0)])
  assert_true(v)
}
test "grasp_force_closure unbalanced" {
  let v = grasp_force_closure([(1.0, 0.0, 0.0), (1.0, 0.0, 0.0)], [(1.0, 0.0, 0.0), (-1.0, 0.0, 0.0)])
  assert_false(v)
}
