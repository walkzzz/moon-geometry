///|
pub fn cech_nerve(balls : Int32) -> Array[Array[Int32]] {
  let result : Array[Array[Int32]] = []
  for i in 0..<balls {
    result.push([i])
  }
  result
}

///|
pub fn cech_dimension(max_dim : Int32) -> Int32 {
  max_dim
}
