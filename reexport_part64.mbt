///|
pub fn planar_graph_new() -> PlanarGraph {
  @planar_graph.PlanarGraph::new()
}

///|
pub fn planar_graph_add_vertex(g : PlanarGraph, p : Point2D) -> Int {
  @planar_graph.PlanarGraph::add_vertex(g, p)
}

///|
pub fn planar_graph_add_edge(g : PlanarGraph, from : Int, to : Int) -> Unit {
  @planar_graph.PlanarGraph::add_edge(g, from, to)
}

///|
pub fn planar_graph_vertex_count(g : PlanarGraph) -> Int {
  @planar_graph.PlanarGraph::vertex_count(g)
}

///|
pub fn planar_graph_edge_count(g : PlanarGraph) -> Int {
  @planar_graph.PlanarGraph::edge_count(g)
}

///|
pub fn planar_graph_is_planar(g : PlanarGraph) -> Bool {
  @planar_graph.PlanarGraph::is_planar(g)
}

///|
pub fn planar_graph_degree(g : PlanarGraph, v : Int) -> Int {
  @planar_graph.PlanarGraph::degree(g, v)
}