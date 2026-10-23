///|
/// Merge two AABBs into one. / 合并两个 AABB。
pub fn AABB3D::merge(a : AABB3D, b : AABB3D) -> AABB3D {
  {
    min_x: if a.min_x < b.min_x {
      a.min_x
    } else {
      b.min_x
    },
    min_y: if a.min_y < b.min_y {
      a.min_y
    } else {
      b.min_y
    },
    min_z: if a.min_z < b.min_z {
      a.min_z
    } else {
      b.min_z
    },
    max_x: if a.max_x > b.max_x {
      a.max_x
    } else {
      b.max_x
    },
    max_y: if a.max_y > b.max_y {
      a.max_y
    } else {
      b.max_y
    },
    max_z: if a.max_z > b.max_z {
      a.max_z
    } else {
      b.max_z
    },
  }
}
