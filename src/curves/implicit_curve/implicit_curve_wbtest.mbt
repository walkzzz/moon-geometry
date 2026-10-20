fn circle_f(x : Double, y : Double) -> Double {
  x * x + y * y - 1.0
}

fn circle_fx(x : Double, _y : Double) -> Double {
  2.0 * x
}

fn circle_fy(_x : Double, y : Double) -> Double {
  2.0 * y
}

test "implicit curve newton correct" {
  let p = @core.Point2D::new(1.0, 0.1)
  let corrected = newton_correct(circle_f, circle_fx, circle_fy, p, 20)
  assert_true(circle_f(corrected.x(), corrected.y()).abs() < 0.0000001)
}

test "implicit curve trace circle" {
  let seed = @core.Point2D::new(1.0, 0.0)
  let pts = trace_curve(circle_f, circle_fx, circle_fy, seed, 0.1, 20)
  assert_true(pts.length() == 21)
  for p in pts {
    assert_true(circle_f(p.x(), p.y()).abs() < 0.001)
  }
}

test "implicit curve tangent" {
  let p = @core.Point2D::new(1.0, 0.0)
  let t = tangent(circle_fx, circle_fy, p)
  let mag = (t.x() * t.x() + t.y() * t.y()).sqrt()
  assert_true((mag - 1.0).abs() < 0.000000001)
  assert_true(t.x().abs() < 0.000000001)
}

test "implicit curve normal" {
  let p = @core.Point2D::new(1.0, 0.0)
  let n = normal(circle_fx, circle_fy, p)
  assert_true((n.x() - 1.0).abs() < 0.000000001)
  assert_true(n.y().abs() < 0.000000001)
}

fn circle_fxx(_x : Double, _y : Double) -> Double {
  2.0
}

fn circle_fxy(_x : Double, _y : Double) -> Double {
  0.0
}

fn circle_fyy(_x : Double, _y : Double) -> Double {
  2.0
}

test "implicit curve curvature circle" {
  let p = @core.Point2D::new(1.0, 0.0)
  let k = curvature(
    circle_fx,
    circle_fy,
    circle_fxx,
    circle_fxy,
    circle_fyy,
    p,
  )
  assert_true((k - 1.0).abs() < 0.000000001)
}

test "implicit curve find seed" {
  let result = find_seed(circle_f, -2.0, 2.0, -2.0, 2.0, 50)
  match result {
    Some(p) => assert_true(circle_f(p.x(), p.y()).abs() < 0.01)
    None => assert_true(false)
  }
}

test "implicit curve trace both directions" {
  let seed = @core.Point2D::new(1.0, 0.0)
  let pts = trace_both_directions(circle_f, circle_fx, circle_fy, seed, 0.1, 10)
  assert_true(pts.length() >= 20)
}

test "implicit curve trace line" {
  fn line_f(x : Double, y : Double) -> Double {
    y - x
  }
  fn line_fx(_x : Double, _y : Double) -> Double {
    -1.0
  }
  fn line_fy(_x : Double, _y : Double) -> Double {
    1.0
  }
  let seed = @core.Point2D::new(0.0, 0.0)
  let pts = trace_curve(line_f, line_fx, line_fy, seed, 0.1, 10)
  assert_true(pts.length() == 11)
  for p in pts {
    assert_true((p.y() - p.x()).abs() < 0.001)
  }
}

test "implicit curve newton already on curve" {
  let p = @core.Point2D::new(0.0, 1.0)
  let corrected = newton_correct(circle_f, circle_fx, circle_fy, p, 20)
  assert_true((corrected.x() - 0.0).abs() < 0.000000001)
  assert_true((corrected.y() - 1.0).abs() < 0.000000001)
}