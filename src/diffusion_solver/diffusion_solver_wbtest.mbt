test "crank_nicolson_coef" {
  let c = crank_nicolson_coef(1.0, 0.01, 1.0)
  assert_true(c > 0.004 && c < 0.006)
}
test "diffusion_stability_check" {
  let s = diffusion_stability_check(1.0, 0.01, 1.0)
  assert_true(s)
}
test "diffusion_stability_check unstable" {
  let s = diffusion_stability_check(1.0, 1.0, 1.0)
  assert_false(s)
}
