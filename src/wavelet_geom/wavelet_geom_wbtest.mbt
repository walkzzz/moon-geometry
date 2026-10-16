test "haar wavelet" {
  assert_eq(haar_wavelet(0.25), 1.0)
  assert_eq(haar_wavelet(0.75), -1.0)
  assert_eq(haar_wavelet(1.5), 0.0)
}

test "haar scaling" {
  assert_eq(haar_scaling(0.5), 1.0)
  assert_eq(haar_scaling(1.5), 0.0)
}

test "wavelet transform 1d" {
  let r = wavelet_transform_1d([1.0, 3.0, 5.0, 7.0])
  assert_true(r[0] > 0.0)
}
