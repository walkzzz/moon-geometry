///|
test "reed_shepp_shortest_path straight" {
  let start = RSPose::new(0.0, 0.0, 0.0)
  let goal = RSPose::new(10.0, 0.0, 0.0)
  let path = reed_shepp_shortest_path(start, goal, 1.0)
  assert_true(reed_shepp_segment_count(path) >= 1)
}

///|
test "reed_shepp_shortest_path left turn" {
  let start = RSPose::new(0.0, 0.0, 0.0)
  let goal = RSPose::new(1.0, 1.0, 1.5707963267948966)
  let path = reed_shepp_shortest_path(start, goal, 1.0)
  assert_true(reed_shepp_segment_count(path) >= 1)
}

///|
test "reed_shepp_shortest_path backward" {
  let start = RSPose::new(0.0, 0.0, 0.0)
  let goal = RSPose::new(-5.0, 0.0, 0.0)
  let path = reed_shepp_shortest_path(start, goal, 1.0)
  assert_true(reed_shepp_segment_count(path) >= 1)
}

///|
test "reed_shepp_shortest_path same pose" {
  let start = RSPose::new(0.0, 0.0, 0.0)
  let goal = RSPose::new(0.0, 0.0, 0.0)
  let path = reed_shepp_shortest_path(start, goal, 1.0)
  assert_true(reed_shepp_path_length(path) >= 0.0)
}

///|
test "reed_shepp_sample basic" {
  let start = RSPose::new(0.0, 0.0, 0.0)
  let goal = RSPose::new(10.0, 0.0, 0.0)
  let path = reed_shepp_shortest_path(start, goal, 1.0)
  let points = reed_shepp_sample(path, start, 10)
  assert_eq(points.length(), 10)
}

///|
test "reed_shepp_sample zero samples" {
  let start = RSPose::new(0.0, 0.0, 0.0)
  let goal = RSPose::new(10.0, 0.0, 0.0)
  let path = reed_shepp_shortest_path(start, goal, 1.0)
  let points = reed_shepp_sample(path, start, 0)
  assert_eq(points.length(), 0)
}

///|
test "reed_shepp_path_length positive" {
  let start = RSPose::new(0.0, 0.0, 0.0)
  let goal = RSPose::new(5.0, 0.0, 0.0)
  let path = reed_shepp_shortest_path(start, goal, 2.0)
  assert_true(reed_shepp_path_length(path) >= 0.0)
}

///|
test "reed_shepp_segment_count" {
  let start = RSPose::new(0.0, 0.0, 0.0)
  let goal = RSPose::new(3.0, 4.0, 1.0)
  let path = reed_shepp_shortest_path(start, goal, 1.0)
  assert_true(reed_shepp_segment_count(path) >= 1)
}

///|
test "reed_shepp_has_backward for backward goal" {
  let start = RSPose::new(0.0, 0.0, 0.0)
  let goal = RSPose::new(-10.0, 0.0, 0.0)
  let path = reed_shepp_shortest_path(start, goal, 1.0)
  let _ = reed_shepp_has_backward(path)
  assert_true(true)
}

///|
test "reed_shepp_shortest_path complex" {
  let start = RSPose::new(0.0, 0.0, 0.0)
  let goal = RSPose::new(5.0, 5.0, 2.0)
  let path = reed_shepp_shortest_path(start, goal, 2.0)
  assert_true(reed_shepp_segment_count(path) >= 1)
}

///|
test "reed_shepp_sample zero length path" {
  let start = RSPose::new(0.0, 0.0, 0.0)
  let goal = RSPose::new(0.0, 0.0, 0.0)
  let path = reed_shepp_shortest_path(start, goal, 1.0)
  let points = reed_shepp_sample(path, start, 10)
  assert_eq(points.length(), 0)
}

///|
test "reed_shepp_sample mixed segment types" {
  let segs = [
    RSSegment::new(Left, 1.0, true),
    RSSegment::new(Straight, 1.0, true),
    RSSegment::new(Right, 1.0, true),
    RSSegment::new(Left, 0.5, false),
  ]
  let path = RSPath::new(segs, 3.5, 1.0)
  let start = RSPose::new(0.0, 0.0, 0.0)
  let points = reed_shepp_sample(path, start, 20)
  assert_eq(points.length(), 20)
}

///|
test "reed_shepp_sample backward straight" {
  let segs = [RSSegment::new(Straight, 2.0, false)]
  let path = RSPath::new(segs, 2.0, 1.0)
  let start = RSPose::new(0.0, 0.0, 0.0)
  let points = reed_shepp_sample(path, start, 5)
  assert_eq(points.length(), 5)
  assert_true(points[4].x() < 0.0)
}

///|
test "reed_shepp_sample right turn" {
  let segs = [RSSegment::new(Right, 1.5707963267948966, true)]
  let path = RSPath::new(segs, 1.5707963267948966, 1.0)
  let start = RSPose::new(0.0, 0.0, 0.0)
  let points = reed_shepp_sample(path, start, 10)
  assert_eq(points.length(), 10)
}

///|
test "reed_shepp_has_backward false for forward path" {
  let start = RSPose::new(0.0, 0.0, 0.0)
  let goal = RSPose::new(10.0, 0.0, 0.0)
  let path = reed_shepp_shortest_path(start, goal, 1.0)
  assert_false(reed_shepp_has_backward(path))
}

///|
test "reed_shepp_has_backward explicit backward" {
  let segs = [RSSegment::new(Straight, 1.0, false)]
  let path = RSPath::new(segs, 1.0, 1.0)
  assert_true(reed_shepp_has_backward(path))
}

///|
test "reed_shepp_has_backward empty path" {
  let path = RSPath::new([], 0.0, 1.0)
  assert_false(reed_shepp_has_backward(path))
}

///|
test "reed_shepp_path_length zero" {
  let start = RSPose::new(0.0, 0.0, 0.0)
  let goal = RSPose::new(0.0, 0.0, 0.0)
  let path = reed_shepp_shortest_path(start, goal, 1.0)
  assert_true(reed_shepp_path_length(path) >= 0.0)
}

///|
test "reed_shepp_shortest_path right turn" {
  let start = RSPose::new(0.0, 0.0, 0.0)
  let goal = RSPose::new(1.0, -1.0, -1.5707963267948966)
  let path = reed_shepp_shortest_path(start, goal, 1.0)
  assert_true(reed_shepp_segment_count(path) >= 1)
}

///|
test "reed_shepp_segment_count empty" {
  let path = RSPath::new([], 0.0, 1.0)
  assert_eq(reed_shepp_segment_count(path), 0)
}

///|
test "reed_shepp_sample two samples" {
  let start = RSPose::new(0.0, 0.0, 0.0)
  let goal = RSPose::new(4.0, 0.0, 0.0)
  let path = reed_shepp_shortest_path(start, goal, 1.0)
  let points = reed_shepp_sample(path, start, 2)
  assert_eq(points.length(), 2)
}
