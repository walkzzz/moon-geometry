test "TrustRegionConfig::new" {
  let config = TrustRegionConfig::new(10.0, 0.1, 100)
  assert_true((config.max_radius - 10.0).abs() < 0.001)
}

test "trust_region_ratio" {
  let r = trust_region_ratio(0.5, 1.0)
  assert_true((r - 0.5).abs() < 0.001)
}

test "update_radius" {
  let r = update_radius(1.0, 0.5, 10.0)
  assert_true((r - 1.0).abs() < 0.001)
}
