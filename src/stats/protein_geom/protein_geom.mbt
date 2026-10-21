///| Protein Geometry | 蛋白质几何
///| Secondary structure, Ramachandran plot, backbone geometry
///| 二级结构、Ramachandran 图、骨架几何

///| Check if (phi, psi) angles fall in allowed Ramachandran regions. / 检查 (phi, psi) 角是否落在允许的 Ramachandran 区域。
pub fn ramachandran_allowed(phi : Double, psi : Double) -> Bool {
  let phi_deg = phi * 180.0 / @math.PI
  let psi_deg = psi * 180.0 / @math.PI
  (phi_deg > -160.0 && phi_deg < -30.0 && psi_deg > -90.0 && psi_deg < 50.0) ||
  (phi_deg > -130.0 && phi_deg < 50.0 && psi_deg > 100.0 && psi_deg < 180.0)
}

///| Compute helix pitch from rise and turn per residue. / 由每残基升高与转角计算螺旋螺距。
pub fn helix_pitch(rise_per_residue : Double, turn_per_residue : Double) -> Double {
  rise_per_residue * 2.0 * @math.PI / turn_per_residue
}

///| Compute helix radius from rise and turn per residue. / 由每残基升高与转角计算螺旋半径。
pub fn helix_radius(rise_per_residue : Double, turn_per_residue : Double) -> Double {
  rise_per_residue / (2.0 * @math.sin(turn_per_residue / 2.0))
}

///| Classify secondary structure as helix, sheet, or coil from (phi, psi). / 由 (phi, psi) 分类二级结构为螺旋、片层或卷曲。
pub fn secondary_structure_type(phi : Double, psi : Double) -> String {
  let phi_deg = phi * 180.0 / @math.PI
  let psi_deg = psi * 180.0 / @math.PI
  if phi_deg > -80.0 && phi_deg < -40.0 && psi_deg > -60.0 && psi_deg < -20.0 {
    "helix"
  } else if phi_deg > -160.0 && phi_deg < -100.0 && psi_deg > 100.0 && psi_deg < 180.0 {
    "sheet"
  } else {
    "coil"
  }
}

///| Count contact map differences between two CA coordinate sets under threshold. / 统计两组 CA 坐标在阈值下接触图的差异数。
pub fn contact_map_distance(ca1 : Array[(Double, Double, Double)], ca2 : Array[(Double, Double, Double)], threshold : Double) -> Int {
  let n = if ca1.length() < ca2.length() { ca1.length() } else { ca2.length() }
  let mut count = 0
  for i in 0..<n {
    for j in (i + 1)..<n {
      let dx = ca1[i].0 - ca1[j].0
      let dy = ca1[i].1 - ca1[j].1
      let dz = ca1[i].2 - ca1[j].2
      let d1 = (dx * dx + dy * dy + dz * dz).sqrt()
      let dx2 = ca2[i].0 - ca2[j].0
      let dy2 = ca2[i].1 - ca2[j].1
      let dz2 = ca2[i].2 - ca2[j].2
      let d2 = (dx2 * dx2 + dy2 * dy2 + dz2 * dz2).sqrt()
      if (d1 < threshold) != (d2 < threshold) {
        count += 1
      }
    }
  }
  count
}
