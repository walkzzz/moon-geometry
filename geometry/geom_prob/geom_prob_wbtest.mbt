test "buffon needle" {
  let p = buffon_needle_probability(1.0, 2.0)
  assert_true(p > 0.31 && p < 0.33)
}

test "bertrand probability" {
  assert_eq(bertrand_probability(1), 1.0 / 3.0)
  assert_eq(bertrand_probability(2), 1.0 / 4.0)
}

test "geometric probability hit" {
  assert_eq(geometric_probability_hit(1.0, 4.0), 0.25)
}
test "bertrand probability mode 3" {
  assert_eq(bertrand_probability(3), 1.0 / 2.0)
  assert_eq(bertrand_probability(0), 1.0 / 2.0)
}

test "random chord length" {
  assert_eq(random_chord_length(1.0), 2.0)
  assert_eq(random_chord_length(5.0), 10.0)
  assert_eq(random_chord_length(0.0), 0.0)
}

test "expected distance unit square" {
  let d = expected_distance_unit_square()
  assert_true(d > 0.32 && d < 0.33)
}

test "coverage probability" {
  let p = coverage_probability(1, 0.5)
  assert_true((p - 0.5).abs() < 0.0001)
  let p10 = coverage_probability(10, 0.5)
  assert_true(p10 > 0.99 && p10 <= 1.0)
  let p0 = coverage_probability(0, 0.5)
  assert_true(p0 == 0.0)
}
