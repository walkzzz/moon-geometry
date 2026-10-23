///|
/// Classify cube configuration into one of 33 equivalence classes.
/// 将立方体配置分类为 33 个等价类之一。
pub fn cube_config_class(cube_idx : Int) -> Int {
  // Count inside corners; use popcount to reduce to base classes.
  // 统计内部角数，归约为基类。
  let mut bits = 0
  for b in 0..<8 {
    if ((cube_idx >> b) & 1) == 1 {
      bits += 1
    }
  }
  if bits == 0 || bits == 8 {
    0
  } else if bits == 1 || bits == 7 {
    1
  } else if bits == 2 || bits == 6 {
    // edge-connected or face-diagonal or body-diagonal
    if is_edge_pair(cube_idx) {
      2
    } else if is_face_diag(cube_idx) {
      3
    } else {
      4
    }
  } else if bits == 3 || bits == 5 {
    5
  } else {
    // bits == 4
    6
  }
}

fn is_edge_pair(idx : Int) -> Bool {
  let pairs = [
    (0, 1),
    (1, 2),
    (2, 3),
    (3, 0),
    (4, 5),
    (5, 6),
    (6, 7),
    (7, 4),
    (0, 4),
    (1, 5),
    (2, 6),
    (3, 7),
  ]
  for p in pairs {
    if ((idx >> p.0) & 1) == 1 && ((idx >> p.1) & 1) == 1 {
      return true
    }
  }
  false
}

fn is_face_diag(idx : Int) -> Bool {
  let diags = [
    (0, 2),
    (1, 3),
    (4, 6),
    (5, 7),
    (0, 5),
    (1, 4),
    (2, 7),
    (3, 6),
    (0, 6),
    (1, 7),
    (2, 4),
    (3, 5),
  ]
  for d in diags {
    if ((idx >> d.0) & 1) == 1 && ((idx >> d.1) & 1) == 1 {
      return true
    }
  }
  false
}
