///|
/// Check if vertex is an ear. / 检查顶点是否为耳。
pub fn is_ear(poly : Array[Point2D], indices : Array[Int], i : Int) -> Bool {
  @ear_clip.is_ear(poly, indices, i)
}


///|
/// Find an ear vertex. / 找耳顶点。
pub fn find_ear(poly : Array[Point2D], indices : Array[Int]) -> Int? {
  @ear_clip.find_ear(poly, indices)
}


///|
/// Triangulate via ear clipping. / 耳裁剪三角剖分。
pub fn ear_clip_triangulate(poly : Array[Point2D]) -> Array[(Int, Int, Int)] {
  @ear_clip.ear_clip_triangulate(poly)
}


///|
/// Count ear clip triangles. / 耳裁剪三角形数。
pub fn ear_clip_count(poly : Array[Point2D]) -> Int {
  @ear_clip.ear_clip_count(poly)
}


///|
/// Ear clip total area. / 耳裁剪总面积。
pub fn ear_clip_area(poly : Array[Point2D]) -> Double {
  @ear_clip.ear_clip_area(poly)
}

// ---------------------------------------------------------------------------
// monotone: monotone polygon triangulation / 单调多边形三角剖分
// ---------------------------------------------------------------------------
