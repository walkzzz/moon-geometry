test "art_gallery_guard_count" {
  assert_true(art_gallery_guard_count(3) == 1)
  assert_true(art_gallery_guard_count(6) == 2)
  assert_true(art_gallery_guard_count(9) == 3)
  assert_true(art_gallery_guard_count(10) == 3)
  assert_true(art_gallery_guard_count(2) == 0)
}

test "art_gallery_place_guards" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(5.0, 0.0),
  ]
  let guards = art_gallery_place_guards(poly)
  assert_true(guards.length() == 2)
  assert_true(guards[0].x() == 0.0)
  assert_true(guards[1].x() == 3.0)
}

test "art_gallery_covers_vertices" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let guards = [poly[0], poly[1], poly[2], poly[3]]
  assert_true(art_gallery_covers_vertices(poly, guards))
  let partial = [poly[0], poly[1]]
  assert_false(art_gallery_covers_vertices(poly, partial))
}

test "art_gallery_convex_guards" {
  assert_true(art_gallery_convex_guards() == 1)
}

test "art_gallery_estimate" {
  let poly = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(4.0, 0.0),
    @core.Point2D::new(4.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let est = art_gallery_estimate(poly)
  assert_true(est >= 1)
}