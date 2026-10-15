test "vector: normalize" {
  let v = @core.Point2D::new(3.0, 4.0)
  let n = normalize(v)
  assert_true(@core.approx_eq(n.x(), 0.6, 0.001))
  assert_true(@core.approx_eq(n.y(), 0.8, 0.001))
}

test "vector: normalize zero" {
  let v = @core.Point2D::new(0.0, 0.0)
  let n = normalize(v)
  assert_true(@core.approx_eq(n.x(), 0.0, 0.001))
  assert_true(@core.approx_eq(n.y(), 0.0, 0.001))
}

test "vector: reflect" {
  let v = @core.Point2D::new(1.0, -1.0)
  let n = @core.Point2D::new(0.0, 1.0)
  let r = reflect(v, n)
  assert_true(@core.approx_eq(r.x(), 1.0, 0.001))
  assert_true(@core.approx_eq(r.y(), 1.0, 0.001))
}

test "vector: project" {
  let v = @core.Point2D::new(3.0, 4.0)
  let u = @core.Point2D::new(1.0, 0.0)
  let p = project(v, u)
  assert_true(@core.approx_eq(p.x(), 3.0, 0.001))
  assert_true(@core.approx_eq(p.y(), 0.0, 0.001))
}

test "vector: lerp" {
  let a = @core.Point2D::new(0.0, 0.0)
  let b = @core.Point2D::new(10.0, 20.0)
  let m = lerp(a, b, 0.5)
  assert_true(@core.approx_eq(m.x(), 5.0, 0.001))
  assert_true(@core.approx_eq(m.y(), 10.0, 0.001))
}

test "vector: perp" {
  let v = @core.Point2D::new(1.0, 0.0)
  let p = perp(v)
  assert_true(@core.approx_eq(p.x(), 0.0, 0.001))
  assert_true(@core.approx_eq(p.y(), 1.0, 0.001))
}

test "vector: length" {
  let v = @core.Point2D::new(3.0, 4.0)
  assert_true(@core.approx_eq(length(v), 5.0, 0.001))
}

test "vector: angle between" {
  let a = @core.Point2D::new(1.0, 0.0)
  let b = @core.Point2D::new(0.0, 1.0)
  assert_true(@core.approx_eq(angle_between(a, b), 1.5707963, 0.001))
}

test "vector: reject" {
  let v = @core.Point2D::new(3.0, 4.0)
  let u = @core.Point2D::new(1.0, 0.0)
  let r = reject(v, u)
  assert_true(@core.approx_eq(r.x(), 0.0, 0.001))
  assert_true(@core.approx_eq(r.y(), 4.0, 0.001))
}