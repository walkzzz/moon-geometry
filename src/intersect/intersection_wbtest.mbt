///|
test "segments_intersect crossing" {
  let s1 = @core.Segment::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 4.0))
  let s2 = @core.Segment::new(@core.Point2D::new(0.0, 4.0), @core.Point2D::new(4.0, 0.0))
  assert_true(segments_intersect(s1, s2))
}

///|
test "segments_intersect parallel no" {
  let s1 = @core.Segment::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 0.0))
  let s2 = @core.Segment::new(@core.Point2D::new(0.0, 1.0), @core.Point2D::new(4.0, 1.0))
  assert_false(segments_intersect(s1, s2))
}

///|
test "segments_intersect disjoint" {
  let s1 = @core.Segment::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0))
  let s2 = @core.Segment::new(@core.Point2D::new(2.0, 0.0), @core.Point2D::new(3.0, 1.0))
  assert_false(segments_intersect(s1, s2))
}

///|
test "segments_intersect endpoint touch" {
  let s1 = @core.Segment::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 0.0))
  let s2 = @core.Segment::new(@core.Point2D::new(2.0, 0.0), @core.Point2D::new(2.0, 2.0))
  assert_true(segments_intersect(s1, s2))
}

///|
test "segments_intersect collinear overlap" {
  let s1 = @core.Segment::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 0.0))
  let s2 = @core.Segment::new(@core.Point2D::new(2.0, 0.0), @core.Point2D::new(6.0, 0.0))
  assert_true(segments_intersect(s1, s2))
}

///|
test "segments_intersect collinear no overlap" {
  let s1 = @core.Segment::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0))
  let s2 = @core.Segment::new(@core.Point2D::new(2.0, 0.0), @core.Point2D::new(3.0, 0.0))
  assert_false(segments_intersect(s1, s2))
}

///|
test "segments_intersect T-junction" {
  let s1 = @core.Segment::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 0.0))
  let s2 = @core.Segment::new(@core.Point2D::new(2.0, -1.0), @core.Point2D::new(2.0, 0.0))
  assert_true(segments_intersect(s1, s2))
}

///|
test "segment_intersection crossing" {
  let s1 = @core.Segment::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 4.0))
  let s2 = @core.Segment::new(@core.Point2D::new(0.0, 4.0), @core.Point2D::new(4.0, 0.0))
  match segment_intersection(s1, s2) {
    Some(p) => {
      assert_true(@core.approx_eq(p.x(), 2.0, 0.000000001))
      assert_true(@core.approx_eq(p.y(), 2.0, 0.000000001))
    }
    None => assert_true(false)
  }
}

///|
test "segment_intersection parallel none" {
  let s1 = @core.Segment::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 0.0))
  let s2 = @core.Segment::new(@core.Point2D::new(0.0, 1.0), @core.Point2D::new(4.0, 1.0))
  assert_true(segment_intersection(s1, s2) is None)
}

///|
test "segment_intersection no cross none" {
  let s1 = @core.Segment::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 1.0))
  let s2 = @core.Segment::new(@core.Point2D::new(2.0, 0.0), @core.Point2D::new(3.0, 1.0))
  assert_true(segment_intersection(s1, s2) is None)
}

///|
test "segment_intersection endpoint" {
  let s1 = @core.Segment::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 0.0))
  let s2 = @core.Segment::new(@core.Point2D::new(2.0, 0.0), @core.Point2D::new(2.0, 2.0))
  match segment_intersection(s1, s2) {
    Some(p) => {
      assert_true(@core.approx_eq(p.x(), 2.0, 0.000000001))
      assert_true(@core.approx_eq(p.y(), 0.0, 0.000000001))
    }
    None => assert_true(false)
  }
}

///|
test "segment_intersection collinear overlap" {
  let s1 = @core.Segment::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 0.0))
  let s2 = @core.Segment::new(@core.Point2D::new(2.0, 0.0), @core.Point2D::new(6.0, 0.0))
  match segment_intersection(s1, s2) {
    Some(p) => assert_true(@core.approx_eq(p.y(), 0.0, 0.000000001))
    None => assert_true(false)
  }
}

///|
test "line_segment_intersection cross" {
  // y = 0 line
  let line = @core.Line::new(0.0, 1.0, 0.0)
  let seg = @core.Segment::new(@core.Point2D::new(1.0, -1.0), @core.Point2D::new(1.0, 1.0))
  match line_segment_intersection(line, seg) {
    Some(p) => {
      assert_true(@core.approx_eq(p.x(), 1.0, 0.000000001))
      assert_true(@core.approx_eq(p.y(), 0.0, 0.000000001))
    }
    None => assert_true(false)
  }
}

///|
test "line_segment_intersection parallel none" {
  let line = @core.Line::new(0.0, 1.0, 0.0) // y = 0
  let seg = @core.Segment::new(@core.Point2D::new(0.0, 1.0), @core.Point2D::new(2.0, 1.0))
  assert_true(line_segment_intersection(line, seg) is None)
}

///|
test "line_segment_intersection no reach" {
  let line = @core.Line::new(0.0, 1.0, 0.0) // y = 0
  let seg = @core.Segment::new(@core.Point2D::new(0.0, 1.0), @core.Point2D::new(2.0, 2.0))
  assert_true(line_segment_intersection(line, seg) is None)
}

///|
test "line_segment_intersection diagonal" {
  // x - y = 0 (y = x)
  let line = @core.Line::new(1.0, -1.0, 0.0)
  let seg = @core.Segment::new(@core.Point2D::new(0.0, 2.0), @core.Point2D::new(2.0, 0.0))
  match line_segment_intersection(line, seg) {
    Some(p) => {
      assert_true(@core.approx_eq(p.x(), 1.0, 0.000000001))
      assert_true(@core.approx_eq(p.y(), 1.0, 0.000000001))
    }
    None => assert_true(false)
  }
}

///|
test "segments_intersect self degenerate" {
  let p = @core.Point2D::new(1.0, 1.0)
  let s1 = @core.Segment::new(p, p)
  let s2 = @core.Segment::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 2.0))
  assert_true(segments_intersect(s1, s2))
}

///|
test "segment_intersection identical" {
  let s1 = @core.Segment::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 0.0))
  let s2 = @core.Segment::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 0.0))
  match segment_intersection(s1, s2) {
    Some(_) => assert_true(true)
    None => assert_true(false)
  }
}
///|
test "segments_intersect parallel no overlap" {
  let s1 = @core.Segment::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(4.0, 0.0))
  let s2 = @core.Segment::new(@core.Point2D::new(0.0, 1.0), @core.Point2D::new(4.0, 1.0))
  assert_false(segments_intersect(s1, s2))
}

///|
test "segments_intersect endpoint touch extra" {
  let s1 = @core.Segment::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(2.0, 0.0))
  let s2 = @core.Segment::new(@core.Point2D::new(2.0, 0.0), @core.Point2D::new(4.0, 0.0))
  assert_true(segments_intersect(s1, s2))
}

///|
test "segment_intersection perpendicular" {
  let s1 = @core.Segment::new(@core.Point2D::new(-1.0, 0.0), @core.Point2D::new(1.0, 0.0))
  let s2 = @core.Segment::new(@core.Point2D::new(0.0, -1.0), @core.Point2D::new(0.0, 1.0))
  match segment_intersection(s1, s2) {
    Some(p) => {
      assert_true(@core.approx_eq(p.x, 0.0, 0.000000001))
      assert_true(@core.approx_eq(p.y, 0.0, 0.000000001))
    }
    None => assert_true(false)
  }
}

///|
test "line_segment_intersection no intersection" {
  let line = @core.Line::new(0.0, 1.0, -10.0)
  let seg = @core.Segment::new(@core.Point2D::new(0.0, 0.0), @core.Point2D::new(5.0, 0.0))
  assert_true(line_segment_intersection(line, seg) is None)
}
