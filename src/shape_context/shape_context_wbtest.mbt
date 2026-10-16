test "shape_context basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let sc = shape_context(pts, 5, 8)
  assert_true(sc.length() == 4)
  for h in sc {
    assert_true(h.length() == 40)
  }
}

test "shape_context normalized" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let sc = shape_context(pts, 3, 6)
  for h in sc {
    let mut s = 0.0
    for v in h {
      s += v
    }
    assert_true((s - 1.0).abs() < 0.001)
  }
}

test "shape_context empty" {
  let sc = shape_context([], 5, 8)
  assert_true(sc.length() == 0)
}

test "shape_context single" {
  let pts = [@core.Point2D::new(1.0, 1.0)]
  let sc = shape_context(pts, 5, 8)
  assert_true(sc.length() == 1)
  let mut s = 0.0
  for v in sc[0] {
    s += v
  }
  assert_true(s < 0.001)
}

test "shape_context distance identical" {
  let h = [0.25, 0.25, 0.25, 0.25]
  let d = shape_context_distance(h, h)
  assert_true(d < 0.0001)
}

test "shape_context distance positive" {
  let h1 = [1.0, 0.0, 0.0, 0.0]
  let h2 = [0.0, 0.0, 0.0, 1.0]
  let d = shape_context_distance(h1, h2)
  assert_true(d > 0.0)
}

test "shape_context cost matrix" {
  let pts1 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
  ]
  let pts2 = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
  ]
  let sc1 = shape_context(pts1, 3, 4)
  let sc2 = shape_context(pts2, 3, 4)
  let cost = shape_context_cost(sc1, sc2)
  assert_true(cost.length() == 2)
  assert_true(cost[0].length() == 2)
}

test "shape_context match identical" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let matched = shape_context_match(pts, pts, 5, 8)
  assert_true(matched.length() == 4)
  for i in 0..<4 {
    assert_true(matched[i] == i)
  }
}

test "shape_context translation invariance" {
  let pts = [
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(-1.0, 0.0),
    @core.Point2D::new(0.0, -1.0),
  ]
  let shifted = [
    @core.Point2D::new(11.0, 10.0),
    @core.Point2D::new(10.0, 11.0),
    @core.Point2D::new(9.0, 10.0),
    @core.Point2D::new(10.0, 9.0),
  ]
  let sc1 = shape_context(pts, 5, 8)
  let sc2 = shape_context(shifted, 5, 8)
  let d = shape_context_distance(sc1[0], sc2[0])
  assert_true(d < 0.001)
}