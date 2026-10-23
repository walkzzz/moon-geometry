///|
/// # Simulation of Simplicity (SoS)
/// # 简单性模拟
///
/// Symbolic perturbation to break degeneracies.
/// 符号扰动打破退化。

///|
pub fn sos_sign(det : Double, perturbation_order : Int32) -> Int32 {
  if det != 0.0 {
    if det > 0.0 {
      1
    } else {
      -1
    }
  } else if perturbation_order % 2 == 0 {
    1
  } else {
    -1
  }
}

///|
pub fn sos_orientation(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
  ia : Int32,
  ib : Int32,
  ic : Int32,
) -> Int32 {
  let det = (b.x() - a.x()) * (c.y() - a.y()) -
    (b.y() - a.y()) * (c.x() - a.x())
  if det != 0.0 {
    if det > 0.0 {
      1
    } else {
      -1
    }
  } else if ia < ib && ib < ic {
    1
  } else {
    -1
  }
}

///|
pub fn sos_compare(a : Double, b : Double, ia : Int32, ib : Int32) -> Int32 {
  if a < b {
    -1
  } else if a > b {
    1
  } else if ia < ib {
    -1
  } else {
    1
  }
}
