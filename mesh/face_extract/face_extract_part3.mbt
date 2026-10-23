///|
/// Compute the area of a face. / 计算面的面积。
pub fn face_area(face : Face) -> Double {
  let n = face.boundary.length()
  if n < 3 {
    return 0.0
  }
  let mut area = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    area +=
      face.boundary[i].x() * face.boundary[j].y() -
      face.boundary[j].x() * face.boundary[i].y()
  }
  (area / 2.0).abs()
}


///|
/// Count the number of faces. / 计算面数。
pub fn face_count(faces : Array[Face]) -> Int {
  faces.length()
}