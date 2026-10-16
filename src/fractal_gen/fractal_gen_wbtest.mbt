test "mandelbrot escape" {
  let i = mandelbrot_escape(0.0, 0.0, 100)
  assert_eq(i, 100)
  let i2 = mandelbrot_escape(2.0, 0.0, 100)
  assert_true(i2 < 100)
}

test "julia escape" {
  let i = julia_escape(0.0, 0.0, -1.0, 0.0, 100)
  assert_eq(i, 100)
}

test "koch curve length" {
  let l = koch_curve_length(1, 1.0)
  assert_eq(l, 4.0 / 3.0)
}
