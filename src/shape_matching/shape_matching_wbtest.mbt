test "hungarian 2x2" {
  let cost = [[4.0, 1.0], [2.0, 3.0]]
  let assign = hungarian(cost)
  assert_true(assign[0] == 1)
  assert_true(assign[1] == 0)
}

test "hungarian 3x3 identity" {
  let cost = [
    [0.0, 100.0, 100.0],
    [100.0, 0.0, 100.0],
    [100.0, 100.0, 0.0],
  ]
  let assign = hungarian(cost)
  assert_true(assign[0] == 0)
  assert_true(assign[1] == 1)
  assert_true(assign[2] == 2)
}

test "hungarian 1x1" {
  let cost = [[5.0]]
  let assign = hungarian(cost)
  assert_true(assign[0] == 0)
}

test "hungarian empty" {
  let assign = hungarian([])
  assert_true(assign.length() == 0)
}

test "hungarian rectangular" {
  let cost = [[1.0, 2.0, 3.0], [3.0, 1.0, 2.0]]
  let assign = hungarian(cost)
  assert_true(assign.length() == 2)
  assert_true(assign[0] >= 0)
  assert_true(assign[1] >= 0)
}

test "shape_matching_icp basic" {
  let target = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let source = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 1.0),
    @core.Point2D::new(1.0, 2.0),
  ]
  let matched = shape_matching_icp(source, target, 50)
  assert_true(matched.length() == 3)
}

test "shape_matching_hungarian basic" {
  let source = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let target = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let matched = shape_matching_hungarian(source, target)
  assert_true(matched.length() == 3)
}

test "shape_matching_score identical" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let score = shape_matching_score(pts, pts)
  assert_true(score < 0.01)
}

test "shape_matching_score positive" {
  let src = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
  ]
  let tgt = [
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(6.0, 5.0),
  ]
  let score = shape_matching_score(src, tgt)
  assert_true(score >= 0.0)
}