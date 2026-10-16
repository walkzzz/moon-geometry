///|
/// # Conic Sections
/// # 圆锥曲线
///
/// General second-degree curve Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0.
/// Classification via discriminant B^2 - 4AC into ellipse / parabola / hyperbola.
/// 一般二次曲线 Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0，
/// 通过判别式 B^2 - 4AC 分类为椭圆 / 抛物线 / 双曲线。

///|
/// Conic section type. / 圆锥曲线类型。
pub(all) enum ConicType {
  Ellipse
  Hyperbola
  Parabola
  Degenerate
}

///|
/// Conic section coefficients Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0.
/// 圆锥曲线系数 Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0。
pub struct Conic {
  a : Double
  b : Double
  c : Double
  d : Double
  e : Double
  f : Double
}

///|
/// Construct a conic from coefficients. / 由系数构造圆锥曲线。
pub fn Conic::new(
  a : Double,
  b : Double,
  c : Double,
  d : Double,
  e : Double,
  f : Double,
) -> Conic {
  { a, b, c, d, e, f }
}

///|
/// Evaluate the conic polynomial at a point. / 在一点求值圆锥曲线多项式。
pub fn Conic::eval(conic : Conic, p : @core.Point2D) -> Double {
  let x = p.x()
  let y = p.y()
  conic.a * x * x +
  conic.b * x * y +
  conic.c * y * y +
  conic.d * x +
  conic.e * y +
  conic.f
}

///|
/// Check if a point lies on the conic. / 检查点是否在圆锥曲线上。
pub fn Conic::on_curve(conic : Conic, p : @core.Point2D, eps : Double) -> Bool {
  Conic::eval(conic, p).abs() <= eps
}

///|
/// Discriminant B^2 - 4AC. / 判别式 B^2 - 4AC。
pub fn Conic::discriminant(conic : Conic) -> Double {
  conic.b * conic.b - 4.0 * conic.a * conic.c
}

///|
/// Classify the conic section. / 分类圆锥曲线。
pub fn Conic::classify(conic : Conic) -> ConicType {
  let disc = Conic::discriminant(conic)
  let eps = 0.0000000001
  if disc.abs() < eps {
    Parabola
  } else if disc < 0.0 {
    let i3 = Conic::det3(conic)
    if i3.abs() < eps {
      Degenerate
    } else {
      Ellipse
    }
  } else {
    let i3 = Conic::det3(conic)
    if i3.abs() < eps {
      Degenerate
    } else {
      Hyperbola
    }
  }
}

///|
/// Determinant of the 3x3 matrix of the conic (invariant I3).
/// 圆锥曲线 3x3 矩阵行列式（不变量 I3）。
pub fn Conic::det3(conic : Conic) -> Double {
  let a = conic.a
  let b = conic.b / 2.0
  let c = conic.c
  let d = conic.d / 2.0
  let e = conic.e / 2.0
  let f = conic.f
  a * (c * f - e * e) - b * (b * f - e * d) + d * (b * e - c * d)
}

///|
/// Center of the conic (ellipse / hyperbola). Returns None for parabola.
/// 圆锥曲线中心（椭圆 / 双曲线），抛物线返回 None。
pub fn Conic::center(conic : Conic) -> @core.Point2D? {
  let eps = 0.0000000001
  let det = 4.0 * conic.a * conic.c - conic.b * conic.b
  if det.abs() < eps {
    return None
  }
  let cx = (conic.b * conic.e - 2.0 * conic.c * conic.d) / det
  let cy = (conic.b * conic.d - 2.0 * conic.a * conic.e) / det
  Some(@core.Point2D::new(cx, cy))
}

///|
/// Tangent line at a point on the conic. / 圆锥曲线上一点处的切线。
/// Returns line coefficients (a, b, c) for a*x + b*y + c = 0.
/// 返回直线系数 (a, b, c)，满足 a*x + b*y + c = 0。
pub fn Conic::tangent_at(conic : Conic, p : @core.Point2D) -> (Double, Double, Double) {
  let x0 = p.x()
  let y0 = p.y()
  let la = 2.0 * conic.a * x0 + conic.b * y0 + conic.d
  let lb = conic.b * x0 + 2.0 * conic.c * y0 + conic.e
  let lc = conic.d * x0 + conic.e * y0 + 2.0 * conic.f
  (la, lb, lc)
}

///|
/// Asymptote lines of a hyperbola. / 双曲线的渐近线。
/// Returns two lines (a, b, c) or None if not a hyperbola.
/// 返回两条直线 (a, b, c)，非双曲线返回 None。
pub fn Conic::asymptotes(conic : Conic) -> ((Double, Double, Double), (Double, Double, Double))? {
  let eps = 0.0000000001
  let disc = Conic::discriminant(conic)
  if disc <= eps {
    return None
  }
  let center = match Conic::center(conic) {
    Some(c) => c
    None => return None
  }
  let h = center.x()
  let k = center.y()
  let sq = disc.sqrt()
  let m1 = (-conic.b + sq) / (2.0 * conic.a)
  let m2 = (-conic.b - sq) / (2.0 * conic.a)
  let l1 = (m1, -1.0, k - m1 * h)
  let l2 = (m2, -1.0, k - m2 * h)
  Some((l1, l2))
}

///|
/// Eccentricity of the conic. / 圆锥曲线离心率。
pub fn Conic::eccentricity(conic : Conic) -> Double? {
  let eps = 0.0000000001
  let ct = Conic::classify(conic)
  match ct {
    Parabola => Some(1.0)
    Ellipse => {
      let trace = conic.a + conic.c
      let det = conic.a * conic.c - conic.b * conic.b / 4.0
      if det.abs() < eps {
        return None
      }
      let disc = trace * trace - 4.0 * det
      if disc.abs() < eps {
        return Some(0.0)
      }
      let sq = disc.abs().sqrt()
      let lam1 = (trace + sq) / 2.0
      let lam2 = (trace - sq) / 2.0
      let major = if lam1.abs() < lam2.abs() { lam2 } else { lam1 }
      let minor = if lam1.abs() < lam2.abs() { lam1 } else { lam2 }
      if major.abs() < eps {
        return None
      }
      Some((1.0 - minor / major).abs().sqrt())
    }
    Hyperbola => {
      let trace = conic.a + conic.c
      let det = conic.a * conic.c - conic.b * conic.b / 4.0
      let disc = trace * trace - 4.0 * det
      if disc.abs() < eps {
        return None
      }
      let sq = disc.abs().sqrt()
      let lam1 = (trace + sq) / 2.0
      let lam2 = (trace - sq) / 2.0
      let abs1 = lam1.abs()
      let abs2 = lam2.abs()
      let major = if abs1 > abs2 { abs1 } else { abs2 }
      let minor = if abs1 > abs2 { abs2 } else { abs1 }
      if major.abs() < eps {
        return None
      }
      Some((1.0 + minor / major).sqrt())
    }
    Degenerate => None
  }
}

///|
/// Translate the conic so its center is at the origin (ellipse / hyperbola).
/// 平移圆锥曲线使中心位于原点（椭圆 / 双曲线）。
pub fn Conic::centered(conic : Conic) -> Conic {
  let center = match Conic::center(conic) {
    Some(c) => c
    None => return conic
  }
  let nf = Conic::eval(conic, center)
  { a: conic.a, b: conic.b, c: conic.c, d: 0.0, e: 0.0, f: nf, }
}

///|
/// Rotate the conic to eliminate the xy term. Returns new conic and rotation angle.
/// 旋转圆锥曲线消去 xy 项，返回新圆锥曲线和旋转角。
pub fn Conic::axis_aligned(conic : Conic) -> (Conic, Double) {
  let eps = 0.0000000001
  if conic.b.abs() < eps {
    return (conic, 0.0)
  }
  let theta = 0.5 * @math.atan2(conic.b, conic.a - conic.c)
  let cs = @math.cos(theta)
  let sn = @math.sin(theta)
  let c2 = cs * cs
  let s2 = sn * sn
  let sc = sn * cs
  let na = conic.a * c2 + conic.b * sc + conic.c * s2
  let nb = 0.0
  let nc = conic.a * s2 - conic.b * sc + conic.c * c2
  let nd = conic.d * cs + conic.e * sn
  let ne = -conic.d * sn + conic.e * cs
  ({ a: na, b: nb, c: nc, d: nd, e: ne, f: conic.f }, theta)
}