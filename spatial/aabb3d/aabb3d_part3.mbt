///|
/// Volume of the AABB. / AABB 体积。
pub impl @core.Measurable3D for AABB3D with fn volume(self) {
  (self.max_x - self.min_x) *
  (self.max_y - self.min_y) *
  (self.max_z - self.min_z)
}

///|
/// Surface area of the AABB. / AABB 表面积。
pub impl @core.Measurable3D for AABB3D with fn surface_area(self) {
  let dx = self.max_x - self.min_x
  let dy = self.max_y - self.min_y
  let dz = self.max_z - self.min_z
  2.0 * (dx * dy + dy * dz + dx * dz)
}

///|
/// Center point of the AABB. / AABB 中心点。
pub fn AABB3D::center(b : AABB3D) -> @core.Point3D {
  @core.Point3D::new(
    (b.min_x + b.max_x) / 2.0,
    (b.min_y + b.max_y) / 2.0,
    (b.min_z + b.max_z) / 2.0,
  )
}
