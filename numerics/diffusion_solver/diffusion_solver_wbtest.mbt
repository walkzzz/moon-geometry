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
test "diffusion_2d_step constant field" {
  let field = [[1.0, 1.0], [1.0, 1.0]]
  let result = diffusion_2d_step(field, 1.0, 0.01, 1.0, 1.0)
  assert_eq(result.length(), 2)
  assert_true((result[0][0] - 1.0).abs() < 0.001)
}
test "diffusion_2d_step single cell" {
  let field = [[5.0]]
  let result = diffusion_2d_step(field, 0.5, 0.1, 1.0, 1.0)
  assert_eq(result.length(), 1)
  assert_true((result[0][0] - 5.0).abs() < 0.001)
}
test "diffusion_2d_step nonuniform" {
  let field = [[0.0, 1.0, 0.0], [0.0, 1.0, 0.0]]
  let result = diffusion_2d_step(field, 1.0, 0.01, 1.0, 1.0)
  assert_eq(result.length(), 2)
  assert_eq(result[0].length(), 3)
}
test "crank_nicolson_coef zero dt" {
  let c = crank_nicolson_coef(2.0, 0.0, 1.0)
  assert_true(c.abs() < 0.000001)
}
test "crank_nicolson_coef scaling" {
  let c1 = crank_nicolson_coef(1.0, 0.02, 1.0)
  let c2 = crank_nicolson_coef(1.0, 0.01, 1.0)
  assert_true((c1 - 2.0 * c2).abs() < 0.000001)
}
