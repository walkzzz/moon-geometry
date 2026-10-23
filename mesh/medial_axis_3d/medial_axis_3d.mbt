///|
/// # 3D Medial Axis (Voronoi Dual Method)
/// # 三维中轴（Voronoi 对偶方法）
///
/// Approximate medial axis via maximal empty spheres (Voronoi dual).
/// 通过最大空球（Voronoi 对偶）近似中轴。
///
/// ## Complexity: O(n^4) for triple-based search
/// ## 复杂度: 三元搜索为 O(n^4)

///|
/// Medial ball: center and radius of a maximal empty sphere.
/// 中轴球：最大空球的球心和半径。
pub struct MedialBall3D {
  center : @core.Point3D
  radius : Double
}

///|
/// Construct a medial ball. / 构造中轴球。
pub fn MedialBall3D::new(
  center : @core.Point3D,
  radius : Double,
) -> MedialBall3D {
  { center, radius, }
}

///|
/// Center accessor. / 球心访问器。
pub fn MedialBall3D::center(self : MedialBall3D) -> @core.Point3D {
  self.center
}

///|
/// Radius accessor. / 半径访问器。
pub fn MedialBall3D::radius(self : MedialBall3D) -> Double {
  self.radius
}
