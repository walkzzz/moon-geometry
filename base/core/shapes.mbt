///|
/// Orientation of an ordered point sequence.
/// 有序点序列的方向。
pub(all) enum Orientation {
  Clockwise
  CounterClockwise
  Collinear
} derive(Debug, Eq)

///|
/// A polygon as an ordered sequence of vertices.
/// 由有序顶点序列定义的多边形。
pub struct Polygon {
  vertices : Array[Point2D]
} derive(Debug)

///|
/// Construct a polygon from a vertex array.
/// 从顶点数组构造多边形。
pub fn Polygon::new(vertices : Array[Point2D]) -> Polygon {
  { vertices, }
}

///|
/// Number of vertices.
/// 顶点数量。
pub fn Polygon::size(self : Polygon) -> Int32 {
  self.vertices.length()
}

///|
/// Get the i-th vertex (with modular wraparound).
/// 获取第 i 个顶点（带模环绕）。
pub fn Polygon::get(self : Polygon, i : Int32) -> Point2D {
  let n = self.vertices.length()
  if n == 0 {
    abort("Polygon::get: empty polygon")
  }
  let idx = (i % n + n) % n
  self.vertices[idx]
}

///|
/// A triangle defined by three vertices.
/// 由三个顶点定义的三角形。
pub struct Triangle {
  a : Point2D
  b : Point2D
  c : Point2D
} derive(Debug)
