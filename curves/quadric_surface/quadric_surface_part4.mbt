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
