///| Sum edge contributions of a discrete connection. / 求和离散联络的边贡献。
pub fn discrete_connection(edges : Array[Double]) -> Double {
  let mut total = 0.0
  for e in edges {
    total += e
  }
  total
}
