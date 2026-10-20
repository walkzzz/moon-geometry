test "gaussian_kernel_2d" {
  let k = gaussian_kernel_2d(0.0, 0.0, 0.0, 0.0, 1.0)
  assert_true((k - 0.15915494309189535).abs() < 0.001)
}

test "image_norm" {
  assert_true((image_norm([3.0, 4.0]) - 5.0).abs() < 0.001)
}
