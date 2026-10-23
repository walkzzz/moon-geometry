///|
/// DXF entity variants. / DXF 实体变体。
pub(all) enum DxfEntity {
  DxfLine(@core.Point3D, @core.Point3D)
  DxfCircle(@core.Point2D, Double)
  DxfPolyline(Array[@core.Point2D])
}

///|
/// DXF document: list of entities. / DXF 文档：实体列表。
pub struct DxfDocument {
  entities : Array[DxfEntity]
}

///|
/// Create an empty DXF document. / 创建空 DXF 文档。
pub fn DxfDocument::new() -> DxfDocument {
  { entities: [], }
}

///|
/// Number of entities. / 实体数量。
pub fn DxfDocument::entity_count(d : DxfDocument) -> Int32 {
  d.entities.length()
}
