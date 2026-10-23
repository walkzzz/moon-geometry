///|
/// Count triangles generated. / 统计生成的三角形数。
pub fn marching_cubes_count(
  grid : McGrid,
  isolevel : Double,
) -> Int {
  marching_cubes(grid, isolevel).length()
}
