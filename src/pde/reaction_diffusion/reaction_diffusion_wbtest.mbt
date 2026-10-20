test "gray_scott" {
  let (du, _) = gray_scott(0.5, 0.5, 0.03, 0.06)
  assert_true(du.abs() < 1.0)
}
test "diffusion_step" {
  let u = diffusion_step([0.0, 1.0, 0.0], 1.0, 0.01, 1.0)
  assert_eq(u.length(), 3)
}
