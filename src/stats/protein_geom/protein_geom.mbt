///| Protein Geometry | 蛋白质几何
///| Secondary structure, Ramachandran plot, backbone geometry
///| 二级结构、Ramachandran 图、骨架几何

pub fn ramachandran_allowed(phi : Double, psi : Double) -> Bool {
  let phi_deg = phi * 180.0 / @math.PI
  let psi_deg = psi * 180.0 / @math.PI
  (phi_deg > -160.0 && phi_deg < -30.0 && psi_deg > -90.0 && psi_deg < 50.0) ||
  (phi_deg > -130.0 && phi_deg < 50.0 && psi_deg > 100.0 && psi_deg < 180.0)
}

pub fn helix_pitch(rise_per_residue : Double, turn_per_residue : Double) -> Double {
  rise_per_residue * 2.0 * @math.PI / turn_per_residue
}

pub fn helix_radius(rise_per_residue : Double, turn_per_residue : Double) -> Double {
  rise_per_residue / (2.0 * @math.sin(turn_per_residue / 2.0))
}

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
