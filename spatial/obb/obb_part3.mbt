///|
/// Volume of the OBB. / OBB 体积。
pub impl @core.Measurable3D for OBB with volume(self) {
  8.0 * self.half_extents[0] * self.half_extents[1] * self.half_extents[2]
}
