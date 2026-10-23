///|
test "mandelbrot escape" {
  let i = mandelbrot_escape(0.0, 0.0, 100)
  assert_eq(i, 100)
  let i2 = mandelbrot_escape(2.0, 0.0, 100)
  assert_true(i2 < 100)
}

///|
test "julia escape" {
  let i = julia_escape(0.0, 0.0, -1.0, 0.0, 100)
  assert_eq(i, 100)
}

///|
test "koch curve length" {
  let l = koch_curve_length(1, 1.0)
  assert_eq(l, 4.0 / 3.0)
}

///|
test "ifs_contractive_factor" {
  let f = ifs_contractive_factor([0.5, -0.3, 0.4])
  assert_true((f - 0.5).abs() < 0.001)
}

///|
test "ifs_contractive_factor_negative" {
  let f = ifs_contractive_factor([-0.7, 0.2])
  assert_true((f - 0.7).abs() < 0.001)
}

///|
test "ifs_contractive_factor_empty" {
  let f = ifs_contractive_factor([])
  assert_true(f.abs() < 0.001)
}

///|
test "fractal_dimension_box" {
  let d = fractal_dimension_box([(0.1, 10), (0.01, 100)])
  assert_true(d > 0.0)
}

///|
test "fractal_dimension_box_single" {
  let d = fractal_dimension_box([(0.1, 10)])
  assert_true(d.abs() < 0.001)
}

///|
test "koch_curve_length_zero_iter" {
  let l = koch_curve_length(0, 2.0)
  assert_true((l - 2.0).abs() < 0.001)
}
