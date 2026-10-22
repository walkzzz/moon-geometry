test "project to 2d" {
  let p = @core.Point3D::new(3.0, 4.0, 5.0)
  let q = project_to_2d(p)
  assert_true(@core.approx_eq(q.x(), 3.0, 0.000001))
  assert_true(@core.approx_eq(q.y(), 4.0, 0.000001))
}

test "project segment" {
  let s = LineSeg3D::new(
    @core.Point3D::new(1.0, 2.0, 3.0),
    @core.Point3D::new(4.0, 5.0, 6.0),
  )
  let (p1, p2) = project_segment(s)
  assert_true(@core.approx_eq(p1.x(), 1.0, 0.000001))
  assert_true(@core.approx_eq(p2.y(), 5.0, 0.000001))
}

test "point in triangle inside" {
  let p = @core.Point2D::new(0.5, 0.5)
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(2.0, 0.0)
  let c = @core.Point2D::new(0.0, 2.0)
  assert_true(point_in_triangle_2d(p, a, b, c))
}

test "point in triangle outside" {
  let p = @core.Point2D::new(2.0, 2.0)
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(2.0, 0.0)
  let c = @core.Point2D::new(0.0, 2.0)
  assert_false(point_in_triangle_2d(p, a, b, c))
}

test "triangle z at" {
  let tri = (
    @core.Point3D::new(0.0, 0.0, 0.0),
    @core.Point3D::new(2.0, 0.0, 0.0),
    @core.Point3D::new(0.0, 2.0, 2.0),
  )
  match triangle_z_at(tri, 0.5, 0.5) {
    Some(z) => assert_true(z > 0.0)
    None => assert_true(false)
  }
}

test "hidden line no occluders" {
  let segs = [
    LineSeg3D::new(
      @core.Point3D::new(0.0, 0.0, 0.0),
      @core.Point3D::new(1.0, 1.0, 0.0),
    ),
  ]
  let tris : Array[(@core.Point3D, @core.Point3D, @core.Point3D)] = []
  let visible = hidden_line_remove(segs, tris)
  assert_eq(visible.length(), 1)
}

test "hidden line occluded" {
  let segs = [
    LineSeg3D::new(
      @core.Point3D::new(0.0, 0.0, 0.0),
      @core.Point3D::new(2.0, 2.0, 0.0),
    ),
  ]
  let tri = (
    @core.Point3D::new(-1.0, -1.0, 1.0),
    @core.Point3D::new(3.0, -1.0, 1.0),
    @core.Point3D::new(-1.0, 3.0, 1.0),
  )
  let visible = hidden_line_remove(segs, [tri])
  assert_eq(visible.length(), 0)
}

test "hidden line partial" {
  let segs = [
    LineSeg3D::new(
      @core.Point3D::new(0.0, 0.0, 0.0),
      @core.Point3D::new(1.0, 1.0, 0.0),
    ),
    LineSeg3D::new(
      @core.Point3D::new(5.0, 5.0, 0.0),
      @core.Point3D::new(6.0, 6.0, 0.0),
    ),
  ]
  let tri = (
    @core.Point3D::new(-1.0, -1.0, 1.0),
    @core.Point3D::new(3.0, -1.0, 1.0),
    @core.Point3D::new(-1.0, 3.0, 1.0),
  )
  let visible = hidden_line_remove(segs, [tri])
  assert_eq(visible.length(), 1)
}

test "count visible" {
  let segs = [
    LineSeg3D::new(
      @core.Point3D::new(0.0, 0.0, 0.0),
      @core.Point3D::new(1.0, 0.0, 0.0),
    ),
  ]
  assert_eq(count_visible(segs, []), 1)
}

test "back face cull" {
  let tris = [
    (
      @core.Point3D::new(0.0, 0.0, 0.0),
      @core.Point3D::new(1.0, 0.0, 0.0),
      @core.Point3D::new(0.0, 1.0, 0.0),
    ),
    (
      @core.Point3D::new(0.0, 0.0, 0.0),
      @core.Point3D::new(0.0, 1.0, 0.0),
      @core.Point3D::new(1.0, 0.0, 0.0),
    ),
  ]
  let view = @core.Point3D::new(0.0, 0.0, 1.0)
  let visible = back_face_cull(tris, view)
  assert_eq(visible.length(), 1)
}