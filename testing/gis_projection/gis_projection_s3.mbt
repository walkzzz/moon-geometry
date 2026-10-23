///|
/// Web Mercator (EPSG:3857) forward. / Web Mercator 正向投影。
pub fn web_mercator_forward(lat : Double, lon : Double) -> ProjXY {
  mercator_forward(lat, lon)
}


///|
/// Web Mercator inverse. / Web Mercator 反向投影。
pub fn web_mercator_inverse(x : Double, y : Double) -> (Double, Double) {
  mercator_inverse(x, y)
}
