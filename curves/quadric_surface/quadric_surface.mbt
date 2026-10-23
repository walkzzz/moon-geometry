///|
/// # Quadric Surfaces
/// # 二次曲面
///
/// General quadric Ax^2 + By^2 + Cz^2 + Dxy + Exz + Fyz + Gx + Hy + Iz + J = 0.
/// Classification into ellipsoid / hyperboloid / paraboloid / cone / cylinder.
/// 一般二次曲面，分类为椭球面 / 双曲面 / 抛物面 / 锥面 / 柱面。

///|
/// Quadric surface type. / 二次曲面类型。
pub(all) enum QuadricType {
  Ellipsoid
  HyperboloidOneSheet
  HyperboloidTwoSheets
  EllipticParaboloid
  HyperbolicParaboloid
  EllipticCone
  EllipticCylinder
  Degenerate
}

///|
/// Quadric surface coefficients.
/// Ax^2 + By^2 + Cz^2 + Dxy + Exz + Fyz + Gx + Hy + Iz + J = 0.
/// 二次曲面系数。
pub struct Quadric {
  a : Double
  b : Double
  c : Double
  d : Double
  e : Double
  f : Double
  g : Double
  h : Double
  i : Double
  j : Double
}

///|
/// Construct a quadric from 10 coefficients. / 由 10 个系数构造二次曲面。
pub fn Quadric::new(
  a : Double,
  b : Double,
  c : Double,
  d : Double,
  e : Double,
  f : Double,
  g : Double,
  h : Double,
  i : Double,
  j : Double,
) -> Quadric {
  { a, b, c, d, e, f, g, h, i, j, }
}

///|
/// Evaluate the quadric at a point. / 在一点求值二次曲面。
pub fn Quadric::eval(q : Quadric, p : @core.Point3D) -> Double {
  let x = p.x
  let y = p.y
  let z = p.z
  q.a * x * x +
  q.b * y * y +
  q.c * z * z +
  q.d * x * y +
  q.e * x * z +
  q.f * y * z +
  q.g * x +
  q.h * y +
  q.i * z +
  q.j
}

///|
/// Check if a point lies on the quadric. / 检查点是否在二次曲面上。
pub fn Quadric::on_surface(
  q : Quadric,
  p : @core.Point3D,
  eps : Double,
) -> Bool {
  Quadric::eval(q, p).abs() <= eps
}

///|
/// Gradient (normal direction) at a point. / 一点处的梯度（法向）。
pub fn Quadric::gradient(q : Quadric, p : @core.Point3D) -> @core.Point3D {
  let x = p.x
  let y = p.y
  let z = p.z
  let gx = 2.0 * q.a * x + q.d * y + q.e * z + q.g
  let gy = q.d * x + 2.0 * q.b * y + q.f * z + q.h
  let gz = q.e * x + q.f * y + 2.0 * q.c * z + q.i
  @core.Point3D::new(gx, gy, gz)
}

///|
/// Unit normal at a point on the surface. / 曲面上一点处的单位法向量。
pub fn Quadric::normal(q : Quadric, p : @core.Point3D) -> @core.Point3D {
  let g = Quadric::gradient(q, p)
  let norm = (g.x * g.x + g.y * g.y + g.z * g.z).sqrt()
  if norm < 0.0000000001 {
    return @core.Point3D::new(0.0, 0.0, 0.0)
  }
  @core.Point3D::new(g.x / norm, g.y / norm, g.z / norm)
}

///|
/// Center of the quadric (solve gradient = 0). Returns None for paraboloids.
/// 二次曲面中心（解梯度=0），抛物面返回 None。
pub fn Quadric::center(q : Quadric) -> @core.Point3D? {
  let eps = 0.0000000001
  let m : Array[Array[Double]] = [
    [2.0 * q.a, q.d, q.e],
    [q.d, 2.0 * q.b, q.f],
    [q.e, q.f, 2.0 * q.c],
  ]
  let rhs = [-q.g, -q.h, -q.i]
  let det = m[0][0] * (m[1][1] * m[2][2] - m[1][2] * m[2][1]) -
    m[0][1] * (m[1][0] * m[2][2] - m[1][2] * m[2][0]) +
    m[0][2] * (m[1][0] * m[2][1] - m[1][1] * m[2][0])
  if det.abs() < eps {
    return None
  }
  let cx = (
      rhs[0] * (m[1][1] * m[2][2] - m[1][2] * m[2][1]) -
      m[0][1] * (rhs[1] * m[2][2] - m[1][2] * rhs[2]) +
      m[0][2] * (rhs[1] * m[2][1] - m[1][1] * rhs[2])
    ) /
    det
  let cy = (
      m[0][0] * (rhs[1] * m[2][2] - m[1][2] * rhs[2]) -
      rhs[0] * (m[1][0] * m[2][2] - m[1][2] * m[2][0]) +
      m[0][2] * (m[1][0] * rhs[2] - rhs[1] * m[2][0])
    ) /
    det
  let cz = (
      m[0][0] * (m[1][1] * rhs[2] - rhs[1] * m[2][1]) -
      m[0][1] * (m[1][0] * rhs[2] - rhs[1] * m[2][0]) +
      rhs[0] * (m[1][0] * m[2][1] - m[1][1] * m[2][0])
    ) /
    det
  Some(@core.Point3D::new(cx, cy, cz))
}

///|
/// Trace of the quadratic form (A + B + C). / 二次型的迹（A + B + C）。
pub fn Quadric::trace(q : Quadric) -> Double {
  q.a + q.b + q.c
}

///|
/// Determinant of the 3x3 quadratic-form matrix. / 3x3 二次型矩阵行列式。
pub fn Quadric::quadratic_det(q : Quadric) -> Double {
  let a = 2.0 * q.a
  let b = 2.0 * q.b
  let c = 2.0 * q.c
  let d = q.d
  let e = q.e
  let f = q.f
  a * (b * c - f * f) - d * (d * c - f * e) + e * (d * f - b * e)
}

///|
/// Classify the quadric surface. / 分类二次曲面。
pub fn Quadric::classify(q : Quadric) -> QuadricType {
  let eps = 0.0000000001
  let det_q = Quadric::quadratic_det(q)
  let tr = Quadric::trace(q)
  let has_linear = q.g.abs() > eps || q.h.abs() > eps || q.i.abs() > eps
  if det_q.abs() > eps {
    let center = Quadric::center(q)
    let f0 = match center {
      Some(c) => Quadric::eval(q, c)
      None => q.j
    }
    if f0.abs() < eps {
      EllipticCone
    } else {
      let signs = eigen_signs(q)
      let pos = signs[0]
      let neg = signs[1]
      if f0 > 0.0 {
        if pos == 3 {
          Degenerate
        } else if pos == 2 && neg == 1 {
          HyperboloidTwoSheets
        } else if pos == 1 && neg == 2 {
          Ellipsoid
        } else {
          Degenerate
        }
      } else if pos == 3 {
        Ellipsoid
      } else if pos == 2 && neg == 1 {
        HyperboloidOneSheet
      } else if pos == 1 && neg == 2 {
        HyperboloidTwoSheets
      } else {
        Degenerate
      }
    }
  } else {
    if !has_linear {
      return EllipticCylinder
    }
    if tr.abs() < eps {
      return Degenerate
    }
    let det_sub = q.a * q.b - q.d * q.d / 4.0
    if det_sub.abs() < eps {
      HyperbolicParaboloid
    } else if det_sub > 0.0 {
      EllipticParaboloid
    } else {
      HyperbolicParaboloid
    }
  }
}

///|
fn eigen_signs(q : Quadric) -> Array[Int32] {
  let eps = 0.0000000001
  let tr = q.a + q.b + q.c
  let m2 = q.a * q.b +
    q.a * q.c +
    q.b * q.c -
    q.d * q.d / 4.0 -
    q.e * q.e / 4.0 -
    q.f * q.f / 4.0
  let m3 = Quadric::quadratic_det(q) / 8.0
  let mut pos = 0
  let mut neg = 0
  let mut zero = 0
  // Depressed cubic coefficients: t^3 + p*t + q = 0
  let p = m2 - tr * tr / 3.0
  let qc = -2.0 * tr * tr * tr / 27.0 + tr * m2 / 3.0 - m3
  let disc = -(4.0 * p * p * p + 27.0 * qc * qc)
  if p.abs() < eps && qc.abs() < eps {
    let lam = tr / 3.0
    if lam > eps {
      pos = 3
    } else if lam < -eps {
      neg = 3
    } else {
      zero = 3
    }
  } else if disc.abs() < eps {
    // Repeated root: t_d = -3q/(2p), t_s = 3q/p
    let t_d = -3.0 * qc / (2.0 * p)
    let t_s = 3.0 * qc / p
    let lam_d = t_d + tr / 3.0
    let lam_s = t_s + tr / 3.0
    for lam in [lam_d, lam_d, lam_s] {
      if lam > eps {
        pos += 1
      } else if lam < -eps {
        neg += 1
      } else {
        zero += 1
      }
    }
  } else if disc > 0.0 {
    let sq = (-p / 3.0).sqrt()
    let arg = 3.0 * qc / (2.0 * p) * (-3.0 / p).sqrt()
    let arg_c = if arg > 1.0 { 1.0 } else if arg < -1.0 { -1.0 } else { arg }
    let theta = @math.acos(arg_c)
    let lam1 = 2.0 * sq * @math.cos(theta / 3.0) + tr / 3.0
    let lam2 = 2.0 * sq * @math.cos((theta + 2.0 * @math.PI) / 3.0) + tr / 3.0
    let lam3 = 2.0 * sq * @math.cos((theta + 4.0 * @math.PI) / 3.0) + tr / 3.0
    for lam in [lam1, lam2, lam3] {
      if lam > eps {
        pos += 1
      } else if lam < -eps {
        neg += 1
      } else {
        zero += 1
      }
    }
  } else {
    let lam = tr / 3.0
    if lam > eps {
      pos = 3
    } else if lam < -eps {
      neg = 3
    } else {
      zero = 3
    }
  }
  [pos, neg, zero]
}

///|
/// Translate the quadric so its center is at the origin. / 平移二次曲面使中心位于原点。
pub fn Quadric::centered(q : Quadric) -> Quadric {
  let center = match Quadric::center(q) {
    Some(c) => c
    None => return q
  }
  let nf = Quadric::eval(q, center)
  { ..q, g: 0.0, h: 0.0, i: 0.0, j: nf, }
}
