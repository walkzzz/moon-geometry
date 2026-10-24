///|
test "simplify_topology_preserve basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.01),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.01),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let result = simplify_topology_preserve(pts, 0.1)
  assert_true(result.length() <= pts.length())
}

///|
test "simplify_visvalingam basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.01),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.01),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let result = simplify_visvalingam(pts, 4)
  assert_eq(result.length(), 4)
}

///|
test "douglas_peucker basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.01),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.01),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let result = douglas_peucker(pts, 0.1)
  assert_true(result.length() < pts.length())
}

///|
test "simplify_topology_preserve small" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let result = simplify_topology_preserve(pts, 0.1)
  assert_eq(result.length(), 3)
}

///|
test "simplify_visvalingam target too large" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let result = simplify_visvalingam(pts, 10)
  assert_eq(result.length(), 4)
}

///|
test "simplify_topology_preserve already simple" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let result = simplify_topology_preserve(pts, 0.5)
  assert_true(result.length() <= 4)
  assert_true(result.length() >= 3)
}

///|
test "simplify_topology_preserve two vertices" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  let result = simplify_topology_preserve(pts, 0.1)
  assert_eq(result.length(), 2)
}

///|
test "simplify_visvalingam target less than three" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let result = simplify_visvalingam(pts, 2)
  assert_eq(result.length(), 4)
}

///|
test "simplify_visvalingam equal to n" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let result = simplify_visvalingam(pts, 4)
  assert_eq(result.length(), 4)
}

///|
test "simplify_visvalingam five to three" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(0.0, 2.0),
  ]
  let result = simplify_visvalingam(pts, 3)
  assert_eq(result.length(), 3)
}

///|
test "douglas_peucker three vertices" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let result = douglas_peucker(pts, 0.1)
  assert_eq(result.length(), 3)
}

///|
test "douglas_peucker large epsilon" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.01),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.01),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let result = douglas_peucker(pts, 10.0)
  assert_true(result.length() <= 2)
}
///|
test "simplify_visvalingam remove last point" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let result = simplify_visvalingam(pts, 4)
  assert_eq(result.length(), 4)
}

///|
test "simplify_visvalingam collinear points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(0.0, 3.0),
  ]
  let result = simplify_visvalingam(pts, 3)
  assert_eq(result.length(), 3)
}

///|
test "simplify_visvalingam many collinear" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let result = simplify_visvalingam(pts, 4)
  assert_eq(result.length(), 4)
}

///|
test "douglas_peucker no simplification needed" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(4.0, 0.0),
  ]
  let result = douglas_peucker(pts, 0.01)
  assert_true(result.length() <= 4)
}

///|
test "simplify_topology_preserve high tolerance" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let result = simplify_topology_preserve(pts, 5.0)
  assert_true(result.length() <= 7)
}

///|
test "simplify_topology_preserve empty" {
  let pts : Array[@core.Point2D] = []
  let result = simplify_topology_preserve(pts, 0.1)
  assert_eq(result.length(), 0)
}

///|
test "douglas_peucker empty" {
  let pts : Array[@core.Point2D] = []
  let result = douglas_peucker(pts, 0.1)
  assert_eq(result.length(), 0)
}

///|
test "simplify_visvalingam empty" {
  let pts : Array[@core.Point2D] = []
  let result = simplify_visvalingam(pts, 3)
  assert_eq(result.length(), 0)
}

///|
test "simplify_topology_preserve complex shape" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.5),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(2.0, 3.5),
    @core.Point2D::new(0.0, 4.0),
  ]
  let result = simplify_topology_preserve(pts, 0.3)
  assert_true(result.length() >= 3)
  assert_true(result.length() <= 6)
}
