///| Crystal Geometry | 晶体几何
///| Point groups, space groups, Wyckoff positions
///| 点群、空间群、Wyckoff 位置

///| Return the order of a crystallographic point group. / 返回晶体学点群的阶。
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

///| Return the number of 2D wallpaper groups (17). / 返回二维壁纸群数量（17）。
pub fn space_group_count_2d() -> Int {
  17
}

///| Return the number of 3D space groups (230). / 返回三维空间群数量（230）。
pub fn space_group_count_3d() -> Int {
  230
}

///| Return the Wyckoff multiplicity for a given site. / 返回给定位置的 Wyckoff 重数。
pub fn wyckoff_multiplicity(site : Int) -> Int {
  if site == 1 { 1 }
  else if site == 2 { 2 }
  else if site == 3 { 3 }
  else if site == 4 { 4 }
  else if site == 6 { 6 }
  else if site == 8 { 8 }
  else { 1 }
}

///| Classify the Bravais lattice type from cell parameters. / 由晶胞参数判定 Bravais 格类型。
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
