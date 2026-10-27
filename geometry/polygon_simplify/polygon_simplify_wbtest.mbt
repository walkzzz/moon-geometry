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

///|
test "point_line_dist basic" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(4.0, 0.0)
  let p = @core.Point2D::new(2.0, 3.0)
  let d = point_line_dist(p, a, b)
  assert_true((d - 3.0).abs() < 0.001)
}

///|
test "point_line_dist zero length" {
  let a = @core.Point2D::new(1.0, 1.0)
  let p = @core.Point2D::new(4.0, 5.0)
  let d = point_line_dist(p, a, a)
  assert_true((d - 5.0).abs() < 0.001)
}

///|
test "point_line_dist on line" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(4.0, 0.0)
  let p = @core.Point2D::new(2.0, 0.0)
  let d = point_line_dist(p, a, b)
  assert_true(d < 0.001)
}

///|
test "triangle_area basic" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(4.0, 0.0)
  let c = @core.Point2D::new(0.0, 3.0)
  let area = triangle_area(a, b, c)
  assert_true((area - 6.0).abs() < 0.001)
}

///|
test "triangle_area degenerate" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(2.0, 0.0)
  let area = triangle_area(a, b, c)
  assert_true(area < 0.001)
}

///|
test "has_self_intersection none" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_false(has_self_intersection(pts))
}

///|
test "has_self_intersection yes" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  assert_true(has_self_intersection(pts))
}

///|
test "has_self_intersection triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  assert_false(has_self_intersection(pts))
}

///|
test "segments_intersect crossing" {
  let a1 = @core.Point2D::new(0.0, 0.0)
  let a2 = @core.Point2D::new(2.0, 2.0)
  let b1 = @core.Point2D::new(0.0, 2.0)
  let b2 = @core.Point2D::new(2.0, 0.0)
  assert_true(segments_intersect(a1, a2, b1, b2))
}

///|
test "segments_intersect not crossing" {
  let a1 = @core.Point2D::new(0.0, 0.0)
  let a2 = @core.Point2D::new(1.0, 1.0)
  let b1 = @core.Point2D::new(2.0, 2.0)
  let b2 = @core.Point2D::new(3.0, 3.0)
  assert_false(segments_intersect(a1, a2, b1, b2))
}

///|
test "segments_intersect parallel" {
  let a1 = @core.Point2D::new(0.0, 0.0)
  let a2 = @core.Point2D::new(2.0, 0.0)
  let b1 = @core.Point2D::new(0.0, 1.0)
  let b2 = @core.Point2D::new(2.0, 1.0)
  assert_false(segments_intersect(a1, a2, b1, b2))
}

///|
test "simplify_topology_preserve self intersecting input" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let result = simplify_topology_preserve(pts, 0.5)
  assert_true(result.length() >= 3)
}

///|
test "simplify_visvalingam removes middle collinear" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
  ]
  let result = simplify_visvalingam(pts, 3)
  assert_eq(result.length(), 3)
}

///|
test "douglas_peucker single point" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  let result = douglas_peucker(pts, 0.1)
  assert_eq(result.length(), 1)
}

///|
test "douglas_peucker two vertices" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0)]
  let result = douglas_peucker(pts, 0.1)
  assert_eq(result.length(), 2)
}

///|
test "simplify_topology_preserve collinear large eps" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  ]
  let result = simplify_topology_preserve(pts, 10.0)
  assert_eq(result.length(), 5)
}

///|
test "simplify_visvalingam remove first point" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 100.0),
    @core.Point2D::new(5.0, 0.0),
  ]
  let result = simplify_visvalingam(pts, 4)
  assert_eq(result.length(), 4)
}

///|
test "simplify_topology_preserve single vertex" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  let result = simplify_topology_preserve(pts, 0.1)
  assert_eq(result.length(), 1)
}

///|
test "douglas_peucker collinear all points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
  ]
  let result = douglas_peucker(pts, 0.01)
  assert_true(result.length() <= 2)
}

///|
test "has_self_intersection pentagon no intersection" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(5.0, 3.0),
    @core.Point2D::new(2.0, 5.0),
    @core.Point2D::new(-1.0, 3.0),
  ]
  assert_false(has_self_intersection(pts))
}

///|
test "simplify_visvalingam single vertex" {
  let pts = [@core.Point2D::new(0.0, 0.0)]
  let result = simplify_visvalingam(pts, 3)
  assert_eq(result.length(), 1)
}

///|
test "simplify_topology_preserve all collinear returns copy" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
  ]
  let result = simplify_topology_preserve(pts, 100.0)
  assert_eq(result.length(), 4)
}

///|
test "douglas_peucker four collinear vertices" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
  ]
  let result = douglas_peucker(pts, 0.01)
  assert_true(result.length() <= 2)
}
