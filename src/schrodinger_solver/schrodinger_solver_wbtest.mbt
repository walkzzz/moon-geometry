test "probability_density" {
  let p = probability_density(1.0, 0.0)
  assert_true(p > 0.99 && p < 1.01)
}
test "normalize_wavefunction" {
  let (r, i) = normalize_wavefunction([1.0, 0.0], [0.0, 0.0], 1.0)
  let mut norm = 0.0
  for j in 0..<r.length() { norm += r[j] * r[j] + i[j] * i[j] }
  assert_true(norm > 0.99 && norm < 1.01)
}
