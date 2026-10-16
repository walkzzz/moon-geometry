///| Crystal Geometry | 晶体几何
///| Point groups, space groups, Wyckoff positions
///| 点群、空间群、Wyckoff 位置

pub fn point_group_order(group_id : Int) -> Int {
  if group_id == 1 { 1 }
  else if group_id == 2 { 2 }
  else if group_id == 3 { 3 }
  else if group_id == 4 { 4 }
  else if group_id == 6 { 6 }
  else if group_id == 8 { 8 }
  else if group_id == 12 { 12 }
  else if group_id == 24 { 24 }
  else if group_id == 48 { 48 }
  else { 1 }
}

pub fn space_group_count_2d() -> Int {
  17
}

pub fn space_group_count_3d() -> Int {
  230
}

pub fn wyckoff_multiplicity(site : Int) -> Int {
  if site == 1 { 1 }
  else if site == 2 { 2 }
  else if site == 3 { 3 }
  else if site == 4 { 4 }
  else if site == 6 { 6 }
  else if site == 8 { 8 }
  else { 1 }
}

pub fn bravais_type(a : Double, b : Double, c : Double, alpha : Double, beta : Double, gamma : Double) -> String {
  let tol = 0.01
  let a_eq_b = (a - b).abs() < tol
  let a_eq_c = (a - c).abs() < tol
  let all_90 = (alpha - 1.5707963267948966).abs() < tol && (beta - 1.5707963267948966).abs() < tol && (gamma - 1.5707963267948966).abs() < tol
  if a_eq_b && a_eq_c && all_90 {
    "cubic"
  } else if all_90 {
    if a_eq_b { "tetragonal" } else { "orthorhombic" }
  } else {
    "monoclinic"
  }
}
