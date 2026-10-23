///|
/// Zone of a line in an arrangement: the sequence of faces crossed by the line. / 线在排列中的区域：线穿过的面的序列。
pub struct Zone {
  line : @core.Line
  crossed_faces : Array[Int32]
  entry_points : Array[@core.Point2D]
}
