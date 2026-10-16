///| Robust Orientation | 鲁棒定向
///| Sign determination with error bounds
///| 带误差界的符号判定

pub fn robust_orient2d(ax : Double, ay : Double, bx : Double, by : Double, cx : Double, cy : Double) -> Int {
  let det = (bx - ax) * (cy - ay) - (cx - ax) * (by - ay)
  if det > 1.0e-12 { 1 } else if det < -1.0e-12 { -1 } else { 0 }
}

pub fn robust_orient3d(ax : Double, ay : Double, az : Double, bx : Double, by : Double, bz : Double, cx : Double, cy : Double, cz : Double, dx : Double, dy : Double, dz : Double) -> Int {
  let adx = bx - ax
  let ady = by - ay
  let adz = bz - az
  let bdx = cx - ax
  let bdy = cy - ay
  let bdz = cz - az
  let cdx = dx - ax
  let cdy = dy - ay
  let cdz = dz - az
  let det = adx * (bdy * cdz - bdz * cdy) - ady * (bdx * cdz - bdz * cdx) + adz * (bdx * cdy - bdy * cdx)
  if det > 1.0e-12 { 1 } else if det < -1.0e-12 { -1 } else { 0 }
}

pub fn robust_sign(val : Double, tol : Double) -> Int {
  if val > tol { 1 } else if val < -tol { -1 } else { 0 }
}

pub fn robust_compare(a : Double, b : Double, tol : Double) -> Int {
  robust_sign(a - b, tol)
}
