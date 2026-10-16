test "emd_1d" {
  let a = [0.0, 1.0, 2.0]
  let b = [0.0, 1.0, 2.0]
  assert_true((emd_1d(a, b) - 0.0).abs() < 0.001)
}

test "emd_1d_shifted" {
  let a = [0.0, 1.0]
  let b = [1.0, 2.0]
  assert_true((emd_1d(a, b) - 1.0).abs() < 0.001)
}

test "emd_uniform" {
  let a = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  let b = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  assert_true((emd_uniform(a, b) - 0.0).abs() < 0.001)
}

test "emd_weighted" {
  let pos = [0.0, 1.0, 2.0]
  let wa = [1.0, 0.0, 0.0]
  let wb = [0.0, 0.0, 1.0]
  let d = emd_weighted(pos, wa, wb)
  assert_true(d > 0.0)
}

test "emd_1d_empty" {
  let a : Array[Double] = []
  let b : Array[Double] = []
  assert_true(emd_1d(a, b) == 0.0)
}