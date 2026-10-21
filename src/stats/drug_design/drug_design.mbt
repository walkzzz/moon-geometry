///| Geometric Drug Design | 几何药物设计
///| Pharmacophore matching, molecular docking geometry
///| 药效团匹配、分子对接几何

///| Compute Euclidean distance between two pharmacophore feature vectors. / 计算两个药效团特征向量间的欧氏距离。
pub fn pharmacophore_distance(f1 : Array[Double], f2 : Array[Double]) -> Double {
  let n = if f1.length() < f2.length() { f1.length() } else { f2.length() }
  let mut sum = 0.0
  for i in 0..<n {
    let d = f1[i] - f2[i]
    sum += d * d
  }
  sum.sqrt()
}

///| Score docking compatibility based on distance from ideal with tolerance. / 基于距离与理想值的偏差及容差评分对接兼容性。
pub fn docking_score_compat(distance : Double, ideal : Double, tolerance : Double) -> Double {
  let diff = (distance - ideal).abs()
  if diff < tolerance {
    1.0 - diff / tolerance
  } else {
    0.0
  }
}

///| Return van der Waals radius for a given element atomic number. / 返回给定元素原子序数的范德华半径。
pub fn vdw_radius(element : Int) -> Double {
  if element == 1 { 1.2 }
  else if element == 6 { 1.7 }
  else if element == 7 { 1.55 }
  else if element == 8 { 1.52 }
  else { 1.8 }
}

///| Detect steric clash when distance is less than sum of radii minus tolerance. / 当距离小于半径和减容差时检测空间位阻冲突。
pub fn clash_detection(d : Double, r1 : Double, r2 : Double) -> Bool {
  d < r1 + r2 - 0.4
}

///| Compute spherical binding pocket volume from radius. / 根据半径计算球形结合口袋体积。
pub fn binding_pocket_volume(radius : Double) -> Double {
  4.0 / 3.0 * @math.PI * radius * radius * radius
}
