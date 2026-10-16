///| Molecular Geometry | 分子几何
///| Bond angles, torsion angles, RMSD alignment
///| 键角、扭转角、RMSD 对齐

pub fn bond_length(a1x : Double, a1y : Double, a1z : Double, a2x : Double, a2y : Double, a2z : Double) -> Double {
  let dx = a2x - a1x
  let dy = a2y - a1y
  let dz = a2z - a1z
  (dx * dx + dy * dy + dz * dz).sqrt()
}

pub fn bond_angle(a1x : Double, a1y : Double, a1z : Double, cx : Double, cy : Double, cz : Double, a2x : Double, a2y : Double, a2z : Double) -> Double {
  let v1x = a1x - cx
  let v1y = a1y - cy
  let v1z = a1z - cz
  let v2x = a2x - cx
  let v2y = a2y - cy
  let v2z = a2z - cz
  let dot = v1x * v2x + v1y * v2y + v1z * v2z
  let n1 = (v1x * v1x + v1y * v1y + v1z * v1z).sqrt()
  let n2 = (v2x * v2x + v2y * v2y + v2z * v2z).sqrt()
  if n1 < 1.0e-10 || n2 < 1.0e-10 {
    0.0
  } else {
    @math.acos(dot / (n1 * n2))
  }
}

pub fn torsion_angle(p1x : Double, p1y : Double, p1z : Double, p2x : Double, p2y : Double, p2z : Double, p3x : Double, p3y : Double, p3z : Double, p4x : Double, p4y : Double, p4z : Double) -> Double {
  let b1x = p2x - p1x
  let b1y = p2y - p1y
  let b1z = p2z - p1z
  let b2x = p3x - p2x
  let b2y = p3y - p2y
  let b2z = p3z - p2z
  let b3x = p4x - p3x
  let b3y = p4y - p3y
  let b3z = p4z - p3z
  let n1x = b1y * b2z - b1z * b2y
  let n1y = b1z * b2x - b1x * b2z
  let n1z = b1x * b2y - b1y * b2x
  let n2x = b2y * b3z - b2z * b3y
  let n2y = b2z * b3x - b2x * b3z
  let n2z = b2x * b3y - b2y * b3x
  let dot = n1x * n2x + n1y * n2y + n1z * n2z
  let cross = b2x * (n1y * n2z - n1z * n2y) + b2y * (n1z * n2x - n1x * n2z) + b2z * (n1x * n2y - n1y * n2x)
  @math.atan2(cross, dot)
}

pub fn rmsd(coords1 : Array[(Double, Double, Double)], coords2 : Array[(Double, Double, Double)]) -> Double {
  let n = if coords1.length() < coords2.length() { coords1.length() } else { coords2.length() }
  let mut sum_sq = 0.0
  for i in 0..<n {
    let dx = coords1[i].0 - coords2[i].0
    let dy = coords1[i].1 - coords2[i].1
    let dz = coords1[i].2 - coords2[i].2
    sum_sq += dx * dx + dy * dy + dz * dz
  }
  (sum_sq / n.to_double()).sqrt()
}
