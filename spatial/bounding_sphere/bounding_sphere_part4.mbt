///|
/// Volume of the sphere. / 球体积。
pub impl @core.Measurable3D for BoundingSphere with volume(self) {
  4.0 / 3.0 * 3.14159265358979323846 * self.radius * self.radius * self.radius
}


///|
/// Surface area of the sphere. / 球表面积。
pub impl @core.Measurable3D for BoundingSphere with surface_area(self) {
  4.0 * 3.14159265358979323846 * self.radius * self.radius
}