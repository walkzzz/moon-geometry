test "affine map apply" {
  let m = AffineMap::new(0.5, 0.0, 0.0, 0.0, 0.5, 0.0)
  let p = @core.Point2D::new(2.0, 4.0)
  let r = AffineMap::apply(m, p)
  assert_true((r.x() - 1.0).abs() < 0.000000001)
  assert_true((r.y() - 2.0).abs() < 0.000000001)
}

test "affine map contraction factor" {
  let m = AffineMap::new(0.5, 0.0, 0.0, 0.0, 0.5, 0.0)
  let c = AffineMap::contraction_factor(m)
  assert_true((c - 0.5).abs() < 0.000000001)
}

test "affine map is contraction" {
  let m = AffineMap::new(0.5, 0.0, 0.0, 0.0, 0.5, 0.0)
  assert_true(AffineMap::is_contraction(m))
  let m2 = AffineMap::new(2.0, 0.0, 0.0, 0.0, 2.0, 0.0)
  assert_false(AffineMap::is_contraction(m2))
}

test "affine map fixed point" {
  let m = AffineMap::new(0.5, 0.0, 1.0, 0.0, 0.5, 0.0)
  match AffineMap::fixed_point(m) {
    Some(p) => {
      let r = AffineMap::apply(m, p)
      assert_true((r.x() - p.x()).abs() < 0.000000001)
      assert_true((r.y() - p.y()).abs() < 0.000000001)
    }
    None => assert_true(false)
  }
}

test "ifs size and contraction" {
  let maps = [
    AffineMap::new(0.5, 0.0, 0.0, 0.0, 0.5, 0.0),
    AffineMap::new(0.5, 0.0, 0.5, 0.0, 0.5, 0.0),
  ]
  let ifs = IFS::new(maps)
  assert_eq(IFS::size(ifs), 2)
  assert_true(IFS::is_contractive(ifs))
}

test "ifs chaos game" {
  let maps = [
    AffineMap::new(0.5, 0.0, 0.0, 0.0, 0.5, 0.0),
    AffineMap::new(0.5, 0.0, 0.5, 0.0, 0.5, 0.0),
    AffineMap::new(0.5, 0.0, 0.25, 0.0, 0.5, 0.4330127019),
  ]
  let ifs = IFS::new(maps)
  let seed = @core.Point2D::new(0.0, 0.0)
  let pts = chaos_game(ifs, seed, 100, 10, fn(n) { (n * 3 + 1) % 3 })
  assert_true(pts.length() == 100)
}

test "ifs iterate deterministic" {
  let maps = [
    AffineMap::new(0.5, 0.0, 0.0, 0.0, 0.5, 0.0),
    AffineMap::new(0.5, 0.0, 0.5, 0.0, 0.5, 0.0),
  ]
  let ifs = IFS::new(maps)
  let seed = @core.Point2D::new(0.0, 0.0)
  let pts = ifs_attractor(ifs, seed, 3)
  assert_eq(pts.length(), 8)
}

test "ifs iterate single step" {
  let maps = [
    AffineMap::new(0.5, 0.0, 0.0, 0.0, 0.5, 0.0),
    AffineMap::new(0.5, 0.0, 0.5, 0.0, 0.5, 0.0),
  ]
  let ifs = IFS::new(maps)
  let input = [@core.Point2D::new(0.0, 0.0)]
  let pts = ifs_iterate(ifs, input)
  assert_eq(pts.length(), 2)
}

test "ifs bbox" {
  let pts = [
    @core.Point2D::new(1.0, 2.0),
    @core.Point2D::new(-1.0, 3.0),
    @core.Point2D::new(0.0, -1.0),
  ]
  let (min_x, min_y, max_x, max_y) = ifs_bbox(pts)
  assert_true((min_x - (-1.0)).abs() < 0.000000001)
  assert_true((max_x - 1.0).abs() < 0.000000001)
  assert_true((min_y - (-1.0)).abs() < 0.000000001)
  assert_true((max_y - 3.0).abs() < 0.000000001)
}

test "ifs max contraction" {
  let maps = [
    AffineMap::new(0.3, 0.0, 0.0, 0.0, 0.3, 0.0),
    AffineMap::new(0.5, 0.0, 0.0, 0.0, 0.5, 0.0),
  ]
  let ifs = IFS::new(maps)
  let mc = IFS::max_contraction(ifs)
  assert_true((mc - 0.5).abs() < 0.000000001)
}