test "dubins_shortest_path straight" {
  let start = DubinsPose::new(0.0, 0.0, 0.0)
  let goal = DubinsPose::new(10.0, 0.0, 0.0)
  let path = dubins_shortest_path(start, goal, 1.0)
  assert_true(dubins_segment_count(path) >= 1)
}

test "dubins_shortest_path left turn" {
  let start = DubinsPose::new(0.0, 0.0, 0.0)
  let goal = DubinsPose::new(1.0, 1.0, 1.5707963267948966)
  let path = dubins_shortest_path(start, goal, 1.0)
  assert_true(dubins_segment_count(path) >= 1)
}

test "dubins_shortest_path right turn" {
  let start = DubinsPose::new(0.0, 0.0, 0.0)
  let goal = DubinsPose::new(1.0, -1.0, -1.5707963267948966)
  let path = dubins_shortest_path(start, goal, 1.0)
  assert_true(dubins_segment_count(path) >= 1)
}

test "dubins_shortest_path same pose" {
  let start = DubinsPose::new(0.0, 0.0, 0.0)
  let goal = DubinsPose::new(0.0, 0.0, 0.0)
  let path = dubins_shortest_path(start, goal, 1.0)
  assert_true(dubins_path_length(path) >= 0.0)
}

test "dubins_sample basic" {
  let start = DubinsPose::new(0.0, 0.0, 0.0)
  let goal = DubinsPose::new(10.0, 0.0, 0.0)
  let path = dubins_shortest_path(start, goal, 1.0)
  let points = dubins_sample(path, start, 10)
  assert_true(points.length() == 10)
}

test "dubins_sample zero samples" {
  let start = DubinsPose::new(0.0, 0.0, 0.0)
  let goal = DubinsPose::new(10.0, 0.0, 0.0)
  let path = dubins_shortest_path(start, goal, 1.0)
  let points = dubins_sample(path, start, 0)
  assert_eq(points.length(), 0)
}

test "dubins_path_length positive" {
  let start = DubinsPose::new(0.0, 0.0, 0.0)
  let goal = DubinsPose::new(5.0, 0.0, 0.0)
  let path = dubins_shortest_path(start, goal, 2.0)
  assert_true(dubins_path_length(path) >= 0.0)
}

test "dubins_segment_count max 3" {
  let start = DubinsPose::new(0.0, 0.0, 0.0)
  let goal = DubinsPose::new(3.0, 4.0, 1.0)
  let path = dubins_shortest_path(start, goal, 1.0)
  assert_true(dubins_segment_count(path) <= 3)
}

test "dubins_shortest_path larger radius" {
  let start = DubinsPose::new(0.0, 0.0, 0.0)
  let goal = DubinsPose::new(10.0, 5.0, 0.5)
  let path = dubins_shortest_path(start, goal, 5.0)
  assert_true(dubins_segment_count(path) >= 1)
}

test "dubins_sample start point" {
  let start = DubinsPose::new(2.0, 3.0, 0.0)
  let goal = DubinsPose::new(12.0, 3.0, 0.0)
  let path = dubins_shortest_path(start, goal, 1.0)
  let points = dubins_sample(path, start, 5)
  if points.length() > 0 {
    assert_true((points[0].x() - 2.0).abs() < 0.1)
  }
}