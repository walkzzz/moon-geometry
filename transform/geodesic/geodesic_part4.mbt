///|
/// Antipodal check: are two points nearly antipodal? / 对跖点检查：两点是否近似对跖？
pub fn is_antipodal(
  lat1 : Double,
  lon1 : Double,
  lat2 : Double,
  lon2 : Double,
) -> Bool {
  let d = haversine_distance(lat1, lon1, lat2, lon2)
  d > 19000000.0
}
