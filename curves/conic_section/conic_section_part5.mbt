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
