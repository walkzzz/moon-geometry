test "hausdorff self similar cantor" {
  let d = self_similar_dimension(2, 1.0 / 3.0)
  let expected = 0.6309297535714574
  assert_true((d - expected).abs() < 0.0000001)
}

test "hausdorff self similar sierpinski" {
  let d = self_similar_dimension(3, 1.0 / 2.0)
  let expected = 1.5849625007211563
  assert_true((d - expected).abs() < 0.0000001)
}

test "hausdorff cantor set dimension" {
  let d = cantor_set_dimension()
  let expected = 0.6309297535714574
  assert_true((d - expected).abs() < 0.0000001)
}

test "hausdorff sierpinski triangle dimension" {
  let d = sierpinski_triangle_dimension()
  let expected = 1.5849625007211563
  assert_true((d - expected).abs() < 0.0000001)
}

test "hausdorff sierpinski carpet dimension" {
  let d = sierpinski_carpet_dimension()
  let expected = 1.8927892607143724
  assert_true((d - expected).abs() < 0.0000001)
}

test "hausdorff koch curve dimension" {
  let d = koch_curve_dimension()
  let expected = 1.2618595071429158
  assert_true((d - expected).abs() < 0.0000001)
}

test "hausdorff menger sponge dimension" {
  let d = menger_sponge_dimension()
  let expected = 2.7268330278608426
  assert_true((d - expected).abs() < 0.0000001)
}

test "hausdorff moran dimension equal ratios" {
  let ratios = [1.0 / 3.0, 1.0 / 3.0]
  let d = moran_dimension(ratios)
  let expected = 0.6309297535714574
  assert_true((d - expected).abs() < 0.001)
}

test "hausdorff moran dimension unequal" {
  let ratios = [0.5, 0.25]
  let d = moran_dimension(ratios)
  assert_true(d > 0.0)
  assert_true(d < 2.0)
  let residual = verify_moran(ratios, d)
  assert_true(residual.abs() < 0.001)
}

test "hausdorff verify moran" {
  let ratios = [1.0 / 3.0, 1.0 / 3.0]
  let d = moran_dimension(ratios)
  let residual = verify_moran(ratios, d)
  assert_true(residual.abs() < 0.001)
}

test "hausdorff self affine dimension" {
  let d = self_affine_dimension(3, 0.5, 0.25)
  assert_true(d > 0.0)
  assert_true(d < 2.0)
}

test "hausdorff estimate from points" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<100 {
    let x = i.to_double() / 100.0
    pts.push(@core.Point2D::new(x, x))
  }
  let d = estimate_from_points(pts, 0.01, 0.5, 10)
  assert_true(d > 0.7)
  assert_true(d < 1.3)
}

test "hausdorff self similar invalid" {
  let d = self_similar_dimension(0, 0.5)
  assert_true(d.abs() < 0.000000001)
  let d2 = self_similar_dimension(2, 1.5)
  assert_true(d2.abs() < 0.000000001)
}