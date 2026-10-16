///| Geometric Drug Design | 几何药物设计
///| Pharmacophore matching, molecular docking geometry
///| 药效团匹配、分子对接几何

pub fn pharmacophore_distance(f1 : Array[Double], f2 : Array[Double]) -> Double {
  let n = if f1.length() < f2.length() { f1.length() } else { f2.length() }
  let mut sum = 0.0
  for i in 0..<n {
    let d = f1[i] - f2[i]
    sum += d * d
  }
  sum.sqrt()
}

pub fn docking_score_compat(distance : Double, ideal : Double, tolerance : Double) -> Double {
  let diff = (distance - ideal).abs()
  if diff < tolerance {
    1.0 - diff / tolerance
  } else {
    0.0
  }
}

pub fn vdw_radius(element : Int) -> Double {
  if element == 1 { 1.2 }
  else if element == 6 { 1.7 }
  else if element == 7 { 1.55 }
  else if element == 8 { 1.52 }
  else { 1.8 }
}

pub fn clash_detection(d : Double, r1 : Double, r2 : Double) -> Bool {
  d < r1 + r2 - 0.4
}

pub fn binding_pocket_volume(radius : Double) -> Double {
  4.0 / 3.0 * @math.PI * radius * radius * radius
}
