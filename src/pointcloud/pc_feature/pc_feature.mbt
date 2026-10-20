///|
/// # Point Cloud Features
/// # 点云特征
///
/// Local geometric feature descriptors for point clouds.
/// 点云的局部几何特征描述子。

///|
/// Compute local point density (count within radius). / 计算局部点密度（半径内点数）。
pub fn local_density(points : Array[@core.Point3D], center : @core.Point3D, radius : Double) -> Int {
  let mut count = 0
  for i in 0..<points.length() {
    if points[i].dist(center) < radius {
      count += 1
    }
  }
  count
}

///|
/// Compute local curvature feature (eigenvalue ratio). / 计算局部曲率特征（特征值比）。
pub fn curvature_feature(eigenvalues : Array[Double]) -> Double {
  if eigenvalues.length() < 3 {
    return 0.0
  }
  let l1 = eigenvalues[0]
  let l2 = eigenvalues[1]
  let l3 = eigenvalues[2]
  let sum = l1 + l2 + l3
  if sum < 0.000000000001 {
    return 0.0
  }
  l3 / sum
}

///|
/// Compute planarity feature. / 计算平面性特征。
pub fn planarity_feature(eigenvalues : Array[Double]) -> Double {
  if eigenvalues.length() < 3 {
    return 0.0
  }
  let l1 = eigenvalues[0]
  let l2 = eigenvalues[1]
  let l3 = eigenvalues[2]
  let sum = l1 + l2 + l3
  if sum < 0.000000000001 {
    return 0.0
  }
  (l2 - l3) / sum
}

///|
/// Compute scattering feature. / 计算散布性特征。
pub fn scattering_feature(eigenvalues : Array[Double]) -> Double {
  if eigenvalues.length() < 3 {
    return 0.0
  }
  let l1 = eigenvalues[0]
  let l2 = eigenvalues[1]
  let l3 = eigenvalues[2]
  let sum = l1 + l2 + l3
  if sum < 0.000000000001 {
    return 0.0
  }
  l3 / sum
}
