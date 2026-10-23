///|
/// Get the number of faces crossed by the zone line. / 获取区域线穿过的面数。
pub fn zone_crossed_count(zone : Zone) -> Int32 {
  zone.crossed_faces.length()
}

///|
/// Get the entry points where the zone line crosses segments. / 获取区域线穿过线段的入口点。
pub fn zone_entry_points(zone : Zone) -> Array[@core.Point2D] {
  zone.entry_points
}

///|
/// Get the crossed face indices. / 获取穿过的面索引。
pub fn zone_crossed_faces(zone : Zone) -> Array[Int32] {
  zone.crossed_faces
}

///|
/// Compute the zone complexity (number of edges in the zone). / 计算区域复杂度（区域中的边数）。
pub fn zone_complexity(zone : Zone) -> Int32 {
  zone.crossed_faces.length() + 1
}
