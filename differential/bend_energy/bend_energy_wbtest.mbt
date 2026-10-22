test "bend_energy circle" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<32 {
    let theta = i.to_double() * 6.283185307179586 / 32.0
    pts.push(@core.Point2D::new(@math.cos(theta), @math.sin(theta)))
  }
  let e = bend_energy(pts)
  assert_true(e > 0.0)
}

test "bend_energy straight line" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
  ]
  let e = bend_energy(pts)
  assert_true(e < 0.001)
}

test "bend_energy too few points" {
  let pts = [@core.Point2D::new(0.0, 0.0), @core.Point2D::new(1.0, 0.0)]
  let e = bend_energy(pts)
  assert_true(e == 0.0)
}

test "bend_energy_open basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 1.0),
  ]
  let e = bend_energy_open(pts)
  assert_true(e > 0.0)
}

test "total_curvature_energy circle" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<32 {
    let theta = i.to_double() * 6.283185307179586 / 32.0
    pts.push(@core.Point2D::new(@math.cos(theta), @math.sin(theta)))
  }
  let tc = total_curvature_energy(pts)
  assert_true(tc > 5.0)
}

test "elastic_energy basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(2.0, 0.0),
    @core.Point2D::new(3.0, 1.0),
  ]
  let e = elastic_energy(pts, 0.5)
  assert_true(e > 0.0)
}

test "curve_length basic" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(3.0, 0.0),
    @core.Point2D::new(3.0, 4.0),
    @core.Point2D::new(0.0, 4.0),
  ]
  let len = curve_length(pts)
  assert_true((len - 14.0).abs() < 0.001)
}

test "bend_energy square" {
  let pts = [
    @core.Point2D::new(0.0, 0.0),
    @core.Point2D::new(1.0, 0.0),
    @core.Point2D::new(1.0, 1.0),
    @core.Point2D::new(0.0, 1.0),
  ]
  let e = bend_energy(pts)
  assert_true(e > 0.0)
}

test "bend_energy scale invariance" {
  let pts1 : Array[@core.Point2D] = []
  let pts2 : Array[@core.Point2D] = []
  for i in 0..<16 {
    let theta = i.to_double() * 6.283185307179586 / 16.0
    pts1.push(@core.Point2D::new(@math.cos(theta), @math.sin(theta)))
    pts2.push(@core.Point2D::new(3.0 * @math.cos(theta), 3.0 * @math.sin(theta)))
  }
  let e1 = bend_energy(pts1) * curve_length(pts1)
  let e2 = bend_energy(pts2) * curve_length(pts2)
  assert_true((e1 - e2).abs() < 0.5)
}
test "normalized_bend_energy positive for circle" {
  let pts : Array[@core.Point2D] = []
  for i in 0..<16 {
    let theta = i.to_double() * 6.283185307179586 / 16.0
    pts.push(@core.Point2D::new(@math.cos(theta), @math.sin(theta)))
  }
  let nbe = normalized_bend_energy(pts)
  assert_true(nbe > 0.0)
}