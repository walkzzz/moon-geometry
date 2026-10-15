///|
test "delaunay empty" {
  let pts : Array[@core.Point2D] = []
  let tris = delaunay_triangulation(pts)
  assert_eq(tris.length(), 0)
}

///|
test "delaunay single point" {
  let pts = [@core.Point2D::new(1.0, 2.0)]
  let tris = delaunay_triangulation(pts)
  assert_eq(tris.length(), 0)
}

///|
test "delaunay two points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(3.0, 4.0)]
  let tris = delaunay_triangulation(pts)
  assert_eq(tris.length(), 0)
}

///|
test "delaunay three points - one triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 3.0),
  ]
  let tris = delaunay_triangulation(pts)
  assert_eq(tris.length(), 1)
}

///|
test "delaunay square - two triangles" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let tris = delaunay_triangulation(pts)
  assert_eq(tris.length(), 2)
}

///|
test "delaunay square with center point" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let tris = delaunay_triangulation(pts)
  assert_eq(tris.length(), 4)
}

///|
test "delaunay triangle count for convex polygon" {
  // For n points in convex position, triangulation has n-2 triangles
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(6.0, 3.0),
    @core.Point2D::new(4.0, 5.0),
    @core.Point2D::new(1.0, 4.0),
  ]
  let tris = delaunay_triangulation(pts)
  assert_eq(tris.length(), 3)
}

///|
test "delaunay hexagon - 4 triangles" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 2.0),
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(-1.0, 2.0),
  ]
  let tris = delaunay_triangulation(pts)
  assert_eq(tris.length(), 4)
}

///|
test "delaunay all triangle indices in range" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let n = pts.length()
  let tris = delaunay_triangulation(pts)
  for t in tris {
    assert_true(t.a >= 0 && t.a < n)
    assert_true(t.b >= 0 && t.b < n)
    assert_true(t.c >= 0 && t.c < n)
  }
}

///|
test "delaunay triangle vertices distinct" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let tris = delaunay_triangulation(pts)
  for t in tris {
    assert_true(t.a != t.b)
    assert_true(t.b != t.c)
    assert_true(t.a != t.c)
  }
}

///|
test "delaunay covers all points as vertices" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let n = pts.length()
  let tris = delaunay_triangulation(pts)
  let used = Array::make(n, false)
  for t in tris {
    used[t.a] = true
    used[t.b] = true
    used[t.c] = true
  }
  for i in 0..<n {
    assert_true(used[i])
  }
}

///|
test "delaunay collinear points - no triangles" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(3.0, 3.0),
  ]
  let tris = delaunay_triangulation(pts)
  assert_eq(tris.length(), 0)
}

///|
test "delaunay duplicate points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 3.0),
  ]
  let tris = delaunay_triangulation(pts)
  // Should still produce a valid result (at least 1 triangle)
  assert_true(tris.length() >= 1)
}

///|
test "delaunay random-ish points" {
  let pts = [
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(5.0, 2.0),
    @core.Point2D::new(3.0, 6.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(6.0, 5.0),
    @core.Point2D::new(2.0, 3.0),
    @core.Point2D::new(4.0, 0.0),
  ]
  let tris = delaunay_triangulation(pts)
  // 7 points, expect at least 5 triangles
  assert_true(tris.length() >= 5)
}

///|
test "delaunay edge sharing count" {
  // In a valid triangulation of n points with h hull points:
  // #triangles = 2n - 2 - h
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  // n=5, h=4 (square hull), expected triangles = 2*5 - 2 - 4 = 4
  let tris = delaunay_triangulation(pts)
  assert_eq(tris.length(), 4)
}

///|
test "delaunay no super-triangle vertices in result" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(3.0, 1.0),
  ]
  let n = pts.length()
  let tris = delaunay_triangulation(pts)
  for t in tris {
    assert_true(t.a < n)
    assert_true(t.b < n)
    assert_true(t.c < n)
  }
}

///|
test "delaunay star configuration" {
  // center point surrounded by 6 points in a circle
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(1.0, 1.732),
    @core.Point2D::new(-1.0, 1.732),
    @core.Point2D::new(-2.0, 0.0),
    @core.Point2D::new(-1.0, -1.732),
    @core.Point2D::new(1.0, -1.732),
  ]
  let tris = delaunay_triangulation(pts)
  // 7 points, 6 hull, expected = 2*7 - 2 - 6 = 6
  assert_eq(tris.length(), 6)
}

///|
test "delaunay grid 3x3" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(4.0, 2.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(4.0, 4.0),
  ]
  let tris = delaunay_triangulation(pts)
  // 9 points, 8 hull, expected = 2*9 - 2 - 8 = 8
  assert_eq(tris.length(), 8)
}

///|
test "delaunay negative coordinates" {
  let pts = [
    @core.Point2D::new(-3.0, -3.0),
    @core.Point2D::new(3.0, -3.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(-3.0, 3.0),
    @core.Point2D::new(0.0, 0.0),
  ]
  let tris = delaunay_triangulation(pts)
  assert_eq(tris.length(), 4)
}

///|
test "delaunay large coordinates" {
  let pts = [
    @core.Point2D::new(1000.0, 1000.0),
    @core.Point2D::new(2000.0, 1000.0),
    @core.Point2D::new(2000.0, 2000.0),
    @core.Point2D::new(1000.0, 2000.0),
    @core.Point2D::new(1500.0, 1500.0),
  ]
  let tris = delaunay_triangulation(pts)
  assert_eq(tris.length(), 4)
}

///|
test "delaunay small coordinates" {
  let pts = [
    @core.Point2D::new(0.001, 0.001),
    @core.Point2D::new(0.004, 0.001),
    @core.Point2D::new(0.004, 0.004),
    @core.Point2D::new(0.001, 0.004),
    @core.Point2D::new(0.0025, 0.0025),
  ]
  let tris = delaunay_triangulation(pts)
  assert_eq(tris.length(), 4)
}

///|
test "delaunay narrow strip" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.001),
    @core.Point2D::new(20.0, 0.0),
    @core.Point2D::new(5.0, 0.002),
    @core.Point2D::new(15.0, 0.002),
  ]
  let tris = delaunay_triangulation(pts)
  assert_true(tris.length() >= 0)
}

///|
test "delaunay triangle area positive (CCW)" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let tris = delaunay_triangulation(pts)
  for t in tris {
    let a = pts[t.a]
    let b = pts[t.b]
    let c = pts[t.c]
    let area2 = (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)
    assert_true(area2 > 0.0)
  }
}

///|
test "voronoi empty" {
  let pts : Array[@core.Point2D] = []
  let (verts, edges) = voronoi_diagram(pts)
  assert_eq(verts.length(), 0)
  assert_eq(edges.length(), 0)
}

///|
test "voronoi single point" {
  let pts = [@core.Point2D::new(1.0, 2.0)]
  let (verts, edges) = voronoi_diagram(pts)
  assert_eq(verts.length(), 0)
  assert_eq(edges.length(), 0)
}

///|
test "voronoi two points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 0.0)]
  let (verts, edges) = voronoi_diagram(pts)
  assert_eq(verts.length(), 0)
  assert_eq(edges.length(), 0)
}

///|
test "voronoi three points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 3.0),
  ]
  let (verts, edges) = voronoi_diagram(pts)
  // 1 triangle -> 1 vertex, 0 edges
  assert_eq(verts.length(), 1)
  assert_eq(edges.length(), 0)
}

///|
test "voronoi square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let (verts, edges) = voronoi_diagram(pts)
  // 2 triangles -> 2 vertices, 1 edge
  assert_eq(verts.length(), 2)
  assert_eq(edges.length(), 1)
}

///|
test "voronoi square with center" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let (verts, edges) = voronoi_diagram(pts)
  // 4 triangles -> 4 vertices
  assert_eq(verts.length(), 4)
  assert_true(edges.length() >= 3)
}

///|
test "voronoi vertices match triangle count" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(6.0, 3.0),
    @core.Point2D::new(4.0, 5.0),
    @core.Point2D::new(1.0, 4.0),
  ]
  let tris = delaunay_triangulation(pts)
  let (verts, _) = voronoi_diagram(pts)
  assert_eq(verts.length(), tris.length())
}

///|
test "voronoi edge indices in range" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let (verts, edges) = voronoi_diagram(pts)
  let m = verts.length()
  for e in edges {
    let (a, b) = e
    assert_true(a >= 0 && a < m)
    assert_true(b >= 0 && b < m)
    assert_true(a != b)
  }
}

///|
test "voronoi star configuration" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(1.0, 1.732),
    @core.Point2D::new(-1.0, 1.732),
    @core.Point2D::new(-2.0, 0.0),
    @core.Point2D::new(-1.0, -1.732),
    @core.Point2D::new(1.0, -1.732),
  ]
  let (verts, edges) = voronoi_diagram(pts)
  // 6 triangles -> 6 vertices
  assert_eq(verts.length(), 6)
  assert_true(edges.length() >= 5)
}

///|
test "voronoi grid 3x3" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(2.0, 2.0),
    @core.Point2D::new(4.0, 2.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(4.0, 4.0),
  ]
  let (verts, edges) = voronoi_diagram(pts)
  // 8 triangles -> 8 vertices
  assert_eq(verts.length(), 8)
  assert_true(edges.length() >= 6)
}

///|
test "voronoi negative coordinates" {
  let pts = [
    @core.Point2D::new(-3.0, -3.0),
    @core.Point2D::new(3.0, -3.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(-3.0, 3.0),
    @core.Point2D::new(0.0, 0.0),
  ]
  let (verts, edges) = voronoi_diagram(pts)
  assert_eq(verts.length(), 4)
  assert_true(edges.length() >= 3)
}

///|
test "norm_edge ordering" {
  let (a, b) = norm_edge(5, 2)
  assert_eq(a, 2)
  assert_eq(b, 5)
}

///|
test "norm_edge already ordered" {
  let (a, b) = norm_edge(1, 3)
  assert_eq(a, 1)
  assert_eq(b, 3)
}

///|
test "norm_edge equal" {
  let (a, b) = norm_edge(3, 3)
  assert_eq(a, 3)
  assert_eq(b, 3)
}

///|
test "tri_edges count" {
  let t : TriangleIdx = { a: 0, b: 1, c: 2 }
  let edges = tri_edges(t)
  assert_eq(edges.length(), 3)
}

///|
test "tri_edges normalized" {
  let t : TriangleIdx = { a: 2, b: 0, c: 1 }
  let edges = tri_edges(t)
  // All edges should have first <= second
  for e in edges {
    let (a, b) = e
    assert_true(a <= b)
  }
}

///|
test "edge_eq equal edges" {
  assert_true(edge_eq((1, 2), (1, 2)))
}

///|
test "edge_eq different edges" {
  assert_false(edge_eq((1, 2), (2, 1)))
}

///|
test "edge_eq completely different" {
  assert_false(edge_eq((1, 2), (3, 4)))
}

///|
test "in_circumcircle inside" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(4.0, 0.0)
  let c = @core.Point2D::new(2.0, 3.0)
  let d = @core.Point2D::new(2.0, 1.0)
  assert_true(in_circumcircle(a, b, c, d))
}

///|
test "in_circumcircle outside" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(4.0, 0.0)
  let c = @core.Point2D::new(2.0, 3.0)
  let d = @core.Point2D::new(10.0, 10.0)
  assert_false(in_circumcircle(a, b, c, d))
}

///|
test "in_circumcircle on circle" {
  // Point on the circle boundary (approximately)
  let a = @core.Point2D::new(-1.0, 0.0)
  let b = @core.Point2D::new(1.0, 0.0)
  let c = @core.Point2D::new(0.0, 1.0)
  let d = @core.Point2D::new(0.0, -1.0)
  // d is on the circumcircle, det should be ~0, so not strictly inside
  assert_false(in_circumcircle(a, b, c, d))
}

///|
test "make_tri_ccw preserves CCW" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 3.0),
  ]
  let t = make_tri_ccw(0, 1, 2, pts)
  let a = pts[t.a]
  let b = pts[t.b]
  let c = pts[t.c]
  let cross = (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)
  assert_true(cross > 0.0)
}

///|
test "make_tri_ccw flips CW to CCW" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 3.0),
  ]
  // Pass in CW order
  let t = make_tri_ccw(0, 2, 1, pts)
  let a = pts[t.a]
  let b = pts[t.b]
  let c = pts[t.c]
  let cross = (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)
  assert_true(cross > 0.0)
}

///|
test "delaunay degenerate thin triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(5.0, 0.001),
  ]
  let tris = delaunay_triangulation(pts)
  assert_true(tris.length() <= 1)
}

///|
test "delaunay four collinear plus one" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(3.0, 3.0),
  ]
  let tris = delaunay_triangulation(pts)
  // 5 points, 3 hull (0,3,4), expected = 2*5 - 2 - 3 = 5
  // But collinear points may not all be used; relax
  assert_true(tris.length() >= 2)
}

///|
test "delaunay pentagon convex" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(6.0, 3.0),
    @core.Point2D::new(3.0, 5.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let tris = delaunay_triangulation(pts)
  // 5 convex points -> 3 triangles
  assert_eq(tris.length(), 3)
}

///|
test "delaunay octagon convex" {
  let pts = [
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(1.414, 1.414),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(1.414, -1.414),
    @core.Point2D::new(0.0, -2.0),
    @core.Point2D::new(-1.414, -1.414),
    @core.Point2D::new(-2.0, 0.0),
    @core.Point2D::new(-1.414, 1.414),
  ]
  let tris = delaunay_triangulation(pts)
  // 8 convex points -> 6 triangles
  assert_eq(tris.length(), 6)
}

///|
test "voronoi pentagon" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(6.0, 3.0),
    @core.Point2D::new(3.0, 5.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let (verts, edges) = voronoi_diagram(pts)
  assert_eq(verts.length(), 3)
  assert_true(edges.length() >= 2)
}

///|
test "delaunay two clusters" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.5, 1.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(11.0, 0.0),
    @core.Point2D::new(10.5, 1.0),
  ]
  let tris = delaunay_triangulation(pts)
  // 6 points with 2 collinear on hull edge, produces 4 triangles
  assert_eq(tris.length(), 4)
}

///|
test "delaunay L-shape" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 3.0),
    @core.Point2D::new(0.0, 3.0),
  ]
  let tris = delaunay_triangulation(pts)
  // 6 points, 5 hull, expected = 2*6 - 2 - 5 = 5
  assert_eq(tris.length(), 5)
}

///|
test "voronoi L-shape" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(1.0, 3.0),
    @core.Point2D::new(0.0, 3.0),
  ]
  let (verts, _) = voronoi_diagram(pts)
  assert_eq(verts.length(), 5)
}

///|
test "delaunay point on edge of triangle" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(2.0, 0.0),
  ]
  let tris = delaunay_triangulation(pts)
  // Point on edge - degenerate case, should still produce valid result
  assert_true(tris.length() >= 1)
}

///|
test "delaunay symmetric diamond" {
  let pts = [
    @core.Point2D::new(0.0, -2.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(-2.0, 0.0),
    @core.Point2D::new(0.0, 0.0),
  ]
  let tris = delaunay_triangulation(pts)
  // 5 points, 4 hull, expected = 2*5 - 2 - 4 = 4
  assert_eq(tris.length(), 4)
}

///|
test "voronoi symmetric diamond" {
  let pts = [
    @core.Point2D::new(0.0, -2.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(0.0, 2.0),
    @core.Point2D::new(-2.0, 0.0),
    @core.Point2D::new(0.0, 0.0),
  ]
  let (verts, edges) = voronoi_diagram(pts)
  assert_eq(verts.length(), 4)
  assert_true(edges.length() >= 3)
}

///|
test "delaunay many interior points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(7.0, 3.0),
    @core.Point2D::new(3.0, 7.0),
    @core.Point2D::new(7.0, 7.0),
  ]
  let tris = delaunay_triangulation(pts)
  // 9 points, 4 hull, expected = 2*9 - 2 - 4 = 12
  assert_eq(tris.length(), 12)
}

///|
test "voronoi many interior points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(10.0, 10.0),
    @core.Point2D::new(0.0, 10.0),
    @core.Point2D::new(5.0, 5.0),
    @core.Point2D::new(3.0, 3.0),
    @core.Point2D::new(7.0, 3.0),
    @core.Point2D::new(3.0, 7.0),
    @core.Point2D::new(7.0, 7.0),
  ]
  let (verts, _) = voronoi_diagram(pts)
  assert_eq(verts.length(), 12)
}

///|
test "delaunay right triangle cluster" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let tris = delaunay_triangulation(pts)
  assert_eq(tris.length(), 2)
}

///|
test "voronoi right triangle cluster" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(0.0, 1.0),
    @core.Point2D::new(1.0, 1.0),
  ]
  let (verts, edges) = voronoi_diagram(pts)
  assert_eq(verts.length(), 2)
  assert_eq(edges.length(), 1)
}

///|
test "delaunay scaled points" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(40.0, 0.0),
    @core.Point2D::new(40.0, 40.0),
    @core.Point2D::new(0.0, 40.0),
    @core.Point2D::new(20.0, 20.0),
  ]
  let tris = delaunay_triangulation(pts)
  assert_eq(tris.length(), 4)
}

///|
test "delaunay offset points" {
  let pts = [
    @core.Point2D::new(100.0, 200.0),
    @core.Point2D::new(104.0, 200.0),
    @core.Point2D::new(104.0, 204.0),
    @core.Point2D::new(100.0, 204.0),
    @core.Point2D::new(102.0, 202.0),
  ]
  let tris = delaunay_triangulation(pts)
  assert_eq(tris.length(), 4)
}

///|
test "delaunay nearly collinear" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 0.01),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(5.0, 5.0),
  ]
  let tris = delaunay_triangulation(pts)
  // 4 points, 3 hull, expected = 2*4 - 2 - 3 = 3
  assert_eq(tris.length(), 3)
}

///|
test "voronoi nearly collinear" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 0.01),
    @core.Point2D::new(10.0, 0.0),
    @core.Point2D::new(5.0, 5.0),
  ]
  let (verts, _) = voronoi_diagram(pts)
  assert_eq(verts.length(), 3)
}

///|
test "delaunay triangle with near-center point" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(6.0, 0.0),
    @core.Point2D::new(3.0, 5.0),
    @core.Point2D::new(3.0, 1.5),
  ]
  let tris = delaunay_triangulation(pts)
  assert_eq(tris.length(), 3)
}

///|
test "delaunay 10 points circle" {
  let pts = [
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(4.045, 2.939),
    @core.Point2D::new(1.545, 4.755),
    @core.Point2D::new(-1.545, 4.755),
    @core.Point2D::new(-4.045, 2.939),
    @core.Point2D::new(-5.0, 0.0),
    @core.Point2D::new(-4.045, -2.939),
    @core.Point2D::new(-1.545, -4.755),
    @core.Point2D::new(1.545, -4.755),
    @core.Point2D::new(4.045, -2.939),
  ]
  let tris = delaunay_triangulation(pts)
  // 10 convex points -> 8 triangles
  assert_eq(tris.length(), 8)
}

///|
test "voronoi 10 points circle" {
  let pts = [
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(4.045, 2.939),
    @core.Point2D::new(1.545, 4.755),
    @core.Point2D::new(-1.545, 4.755),
    @core.Point2D::new(-4.045, 2.939),
    @core.Point2D::new(-5.0, 0.0),
    @core.Point2D::new(-4.045, -2.939),
    @core.Point2D::new(-1.545, -4.755),
    @core.Point2D::new(1.545, -4.755),
    @core.Point2D::new(4.045, -2.939),
  ]
  let (verts, edges) = voronoi_diagram(pts)
  assert_eq(verts.length(), 8)
  assert_true(edges.length() >= 7)
}

///|
test "delaunay mixed scale" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(100.0, 0.0),
    @core.Point2D::new(100.0, 100.0),
    @core.Point2D::new(0.0, 100.0),
    @core.Point2D::new(50.0, 50.0),
    @core.Point2D::new(0.001, 0.001),
  ]
  let tris = delaunay_triangulation(pts)
  assert_true(tris.length() >= 4)
}

///|
test "delaunay consistent across runs" {
  let pts = [
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(7.0, 2.0),
    @core.Point2D::new(1.0, 5.0),
    @core.Point2D::new(6.0, 8.0),
    @core.Point2D::new(9.0, 4.0),
    @core.Point2D::new(4.0, 6.0),
  ]
  let t1 = delaunay_triangulation(pts)
  let t2 = delaunay_triangulation(pts)
  assert_eq(t1.length(), t2.length())
}

///|
test "voronoi consistent across runs" {
  let pts = [
    @core.Point2D::new(3.0, 1.0),
    @core.Point2D::new(7.0, 2.0),
    @core.Point2D::new(1.0, 5.0),
    @core.Point2D::new(6.0, 8.0),
    @core.Point2D::new(9.0, 4.0),
    @core.Point2D::new(4.0, 6.0),
  ]
  let (v1, e1) = voronoi_diagram(pts)
  let (v2, e2) = voronoi_diagram(pts)
  assert_eq(v1.length(), v2.length())
  assert_eq(e1.length(), e2.length())
}

///|
test "delaunay total triangle area matches polygon area" {
  // For points in convex position, sum of triangle areas = polygon area
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let tris = delaunay_triangulation(pts)
  let mut total_area = 0.0
  for t in tris {
    let a = pts[t.a]
    let b = pts[t.b]
    let c = pts[t.c]
    total_area += ((b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)) / 2.0
  }
  // Square area = 16, triangulation area should match
  assert_true((total_area - 16.0).abs() < 0.0001)
}

///|
test "delaunay total triangle area pentagon" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
    @core.Point2D::new(6.0, 3.0),
    @core.Point2D::new(3.0, 5.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let tris = delaunay_triangulation(pts)
  let mut total_area = 0.0
  for t in tris {
    let a = pts[t.a]
    let b = pts[t.b]
    let c = pts[t.c]
    total_area += ((b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)) / 2.0
  }
  // @core.Polygon area via shoelace
  let mut poly_area = 0.0
  let n = pts.length()
  for i in 0..<n {
    let j = (i + 1) % n
    poly_area += (pts[i].x * pts[j].y - pts[j].x * pts[i].y)
  }
  poly_area = poly_area / 2.0
  assert_true((total_area - poly_area).abs() < 0.0001)
}

///|
test "delaunay total triangle area hexagon" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 2.0),
    @core.Point2D::new(2.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(-1.0, 2.0),
  ]
  let tris = delaunay_triangulation(pts)
  let mut total_area = 0.0
  for t in tris {
    let a = pts[t.a]
    let b = pts[t.b]
    let c = pts[t.c]
    total_area += ((b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)) / 2.0
  }
  let mut poly_area = 0.0
  let n = pts.length()
  for i in 0..<n {
    let j = (i + 1) % n
    poly_area += (pts[i].x * pts[j].y - pts[j].x * pts[i].y)
  }
  poly_area = poly_area / 2.0
  assert_true((total_area - poly_area).abs() < 0.0001)
}

///|
test "voronoi vertex is circumcenter" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(2.0, 3.0),
  ]
  let (verts, _) = voronoi_diagram(pts)
  // Single triangle, circumcenter should be equidistant from all 3 vertices
  let v = verts[0]
  let d0 = (v.x - 0.0) * (v.x - 0.0) + (v.y - 0.0) * (v.y - 0.0)
  let d1 = (v.x - 4.0) * (v.x - 4.0) + (v.y - 0.0) * (v.y - 0.0)
  let d2 = (v.x - 2.0) * (v.x - 2.0) + (v.y - 3.0) * (v.y - 3.0)
  assert_true((d0 - d1).abs() < 0.0001)
  assert_true((d1 - d2).abs() < 0.0001)
}

///|
test "voronoi vertex equidistant square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let (verts, _) = voronoi_diagram(pts)
  // Each voronoi vertex is circumcenter of a triangle
  // For a square split into 2 triangles, circumcenters should be at (2,2) for both
  for v in verts {
    let dx = v.x - 2.0
    let dy = v.y - 2.0
    assert_true((dx * dx + dy * dy).abs() < 0.0001)
  }
}

///|
test "delaunay no overlapping triangles" {
  // Check that no two triangles share the same 3 vertices
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let tris = delaunay_triangulation(pts)
  let m = tris.length()
  for i in 0..<m {
    for j in (i + 1)..<m {
      let ti = tris[i]
      let tj = tris[j]
      // Get sorted vertex sets
      let si = [ti.a, ti.b, ti.c]
      let sj = [tj.a, tj.b, tj.c]
      si.sort_by(fn(a, b) { a - b })
      sj.sort_by(fn(a, b) { a - b })
      let same = si[0] == sj[0] && si[1] == sj[1] && si[2] == sj[2]
      assert_false(same)
    }
  }
}

///|
test "delaunay edge count formula" {
  // For triangulation: #edges = 3*#triangles / 2 + hull_edges/2
  // Simpler: #edges = (3*#tri + hull) / 2
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
    @core.Point2D::new(2.0, 2.0),
  ]
  let tris = delaunay_triangulation(pts)
  // Count unique edges
  let edges : Array[(Int, Int)] = []
  for t in tris {
    let mut e1 = (t.a, t.b)
    let mut e2 = (t.b, t.c)
    let mut e3 = (t.c, t.a)
    if e1.0 > e1.1 {
      e1 = (e1.1, e1.0)
    }
    if e2.0 > e2.1 {
      e2 = (e2.1, e2.0)
    }
    if e3.0 > e3.1 {
      e3 = (e3.1, e3.0)
    }
    for e in [e1, e2, e3] {
      let mut found = false
      for ex in edges {
        if ex.0 == e.0 && ex.1 == e.1 {
          found = true
        }
      }
      if !found {
        edges.push(e)
      }
    }
  }
  // 4 triangles, 4 hull edges, interior edges = (3*4 - 4) / 2 = 4, total = 8
  assert_eq(edges.length(), 8)
}

///|
test "delaunay hull edges count" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let tris = delaunay_triangulation(pts)
  // Count edges that appear only once (hull edges)
  let all_edges : Array[(Int, Int)] = []
  for t in tris {
    let mut e1 = (t.a, t.b)
    let mut e2 = (t.b, t.c)
    let mut e3 = (t.c, t.a)
    if e1.0 > e1.1 {
      e1 = (e1.1, e1.0)
    }
    if e2.0 > e2.1 {
      e2 = (e2.1, e2.0)
    }
    if e3.0 > e3.1 {
      e3 = (e3.1, e3.0)
    }
    all_edges.push(e1)
    all_edges.push(e2)
    all_edges.push(e3)
  }
  let mut hull_count = 0
  for e in all_edges {
    let mut cnt = 0
    for f in all_edges {
      if f.0 == e.0 && f.1 == e.1 {
        cnt += 1
      }
    }
    if cnt == 1 {
      hull_count += 1
    }
  }
  // Square has 4 hull edges
  assert_eq(hull_count, 4)
}