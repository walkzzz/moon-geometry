///|
/// Intersection point in a line segment arrangement. / 线段排列中的交点。
pub struct ArrangementVertex {
  point : @core.Point2D
  seg_ids : Array[Int]
}


///|
/// Line segment arrangement: computes all intersection points of a set of segments. / 线段排列：计算一组线段的所有交点。
pub struct Arrangement {
  segments : Array[@core.Segment]
  vertices : Array[ArrangementVertex]
}
