///|
/// Re-export of all public types and functions from sub-packages.
/// Users can import a single package `walkzzz/moon-geometry` to access all APIs.
///
/// 重导出所有子包的公开类型和函数。
/// 用户只需导入单个包 `walkzzz/moon-geometry` 即可访问全部 API。


///|
/// 2D point. / 二维点。
pub type Point2D = @core.Point2D


///|
/// 3D point. / 三维点。
pub type Point3D = @core.Point3D


///|
/// Line segment. / 线段。
pub type Segment = @core.Segment


///|
/// Infinite line (a*x + b*y + c = 0). / 无限直线。
pub type Line = @core.Line


///|
/// Polygon. / 多边形。
pub type Polygon = @core.Polygon


///|
/// Triangle. / 三角形。
pub type Triangle = @core.Triangle
