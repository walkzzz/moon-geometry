"""Generate reexport entries for Phase 21-24 modules."""
import os

MODULES = {
    "geometric_algebra": {
        "types": ["Multivector"],
        "funcs": [
            ("Multivector::new", "multivector_new", ["scalar : Double", "e1 : Double", "e2 : Double", "e12 : Double"], "Multivector"),
            ("Multivector::add", "multivector_add", ["self : Multivector", "other : Multivector"], "Multivector"),
            ("Multivector::mul", "multivector_mul", ["self : Multivector", "other : Multivector"], "Multivector"),
            ("Multivector::reverse", "multivector_reverse", ["self : Multivector"], "Multivector"),
            ("Multivector::norm", "multivector_norm", ["self : Multivector"], "Double"),
            ("rotor", "ga_rotor", ["angle : Double"], "Multivector"),
            ("rotate_vector", "ga_rotate_vector", ["vx : Double", "vy : Double", "angle : Double"], "(Double, Double)"),
        ]
    },
    "symplectic_geom": {
        "types": ["SymplecticForm"],
        "funcs": [
            ("canonical_form", "canonical_form", [], "SymplecticForm"),
            ("SymplecticForm::apply", "symplectic_apply", ["self : SymplecticForm", "v1x : Double", "v1y : Double", "v2x : Double", "v2y : Double"], "Double"),
            ("SymplecticForm::is_nondegenerate", "symplectic_is_nondegenerate", ["self : SymplecticForm"], "Bool"),
            ("hamiltonian_flow", "hamiltonian_flow", ["hx : Double", "hy : Double", "dt : Double"], "(Double, Double)"),
            ("poisson_bracket", "poisson_bracket", ["fx : Double", "fy : Double", "gx : Double", "gy : Double"], "Double"),
            ("liouville_volume", "liouville_volume", ["x1 : Double", "x2 : Double", "y1 : Double", "y2 : Double"], "Double"),
        ]
    },
    "contact_geom": {
        "types": ["ContactForm"],
        "funcs": [
            ("ContactForm::eval", "contact_eval", ["self : ContactForm", "vx : Double", "vy : Double", "vz : Double"], "Double"),
            ("ContactForm::is_contact", "contact_is_contact", ["self : ContactForm"], "Bool"),
            ("legendre_lift", "legendre_lift", ["x : Double", "y : Double", "f : (Double) -> Double"], "(Double, Double, Double)"),
            ("reeb_vector", "reeb_vector", ["a_x : Double", "a_y : Double", "a_z : Double"], "(Double, Double, Double)"),
            ("contact_hamiltonian", "contact_hamiltonian", ["h : Double", "a_z : Double"], "Double"),
        ]
    },
    "info_geom": {
        "types": [],
        "funcs": [
            ("fisher_metric_gaussian", "fisher_metric_gaussian", ["mu : Double", "sigma : Double"], "(Double, Double)"),
            ("fisher_metric_bernoulli", "fisher_metric_bernoulli", ["p : Double"], "Double"),
            ("fisher_metric_poisson", "fisher_metric_poisson", ["lambda : Double"], "Double"),
            ("kl_divergence", "kl_divergence", ["p : Double", "q : Double"], "Double"),
            ("jeffreys_divergence", "jeffreys_divergence", ["p : Double", "q : Double"], "Double"),
            ("alpha_connection", "alpha_connection", ["g11 : Double", "g22 : Double", "alpha : Double"], "(Double, Double)"),
        ]
    },
    "discrete_diff_geom": {
        "types": [],
        "funcs": [
            ("discrete_connection", "discrete_connection", ["edges : Array[Double]"], "Double"),
            ("holonomy", "ddg_holonomy", ["angles : Array[Double]"], "Double"),
            ("parallel_transport", "ddg_parallel_transport", ["vx : Double", "vy : Double", "angle : Double"], "(Double, Double)"),
            ("discrete_curvature2d", "discrete_curvature2d", ["angles : Array[Double]"], "Double"),
            ("gauss_map_normals", "gauss_map_normals", ["angles : Array[Double]"], "Array[Double]"),
        ]
    },
    "conformal_geom": {
        "types": [],
        "funcs": [
            ("is_conformal", "is_conformal", ["a : Double", "b : Double", "c : Double", "d : Double"], "Bool"),
            ("mobius_transform", "mobius_transform", ["zx : Double", "zy : Double", "a : Double", "b : Double"], "(Double, Double)"),
            ("conformal_factor", "conformal_factor", ["r : Double", "scale : Double"], "Double"),
            ("angle_preserving", "angle_preserving", ["a1x : Double", "a1y : Double", "a2x : Double", "a2y : Double"], "Double"),
            ("schwarz_christoffel_alpha", "schwarz_christoffel_alpha", ["angles : Array[Double]"], "Double"),
        ]
    },
    "geom_measure": {
        "types": [],
        "funcs": [
            ("hausdorff_dim_0", "hausdorff_dim_0", ["count : Int"], "Double"),
            ("hausdorff_measure_1d", "hausdorff_measure_1d", ["length : Double"], "Double"),
            ("hausdorff_measure_2d", "hausdorff_measure_2d", ["area : Double"], "Double"),
            ("density_2d", "gm_density_2d", ["measure : Double", "radius : Double"], "Double"),
            ("rectifiable_length", "rectifiable_length", ["segments : Array[(Double, Double, Double, Double)]"], "Double"),
            ("coarea_formula", "coarea_formula", ["fx : Double", "fy : Double", "level : Double"], "Double"),
        ]
    },
    "knot_theory": {
        "types": [],
        "funcs": [
            ("crossing_number", "crossing_number", ["crossings : Array[Int]"], "Int"),
            ("writhe", "writhe", ["signs : Array[Int]"], "Int"),
            ("jones_unknot", "jones_unknot", ["t : Double"], "Double"),
            ("jones_trefoil", "jones_trefoil", ["t : Double"], "Double"),
            ("jones_figure8", "jones_figure8", ["t : Double"], "Double"),
            ("linking_number", "linking_number", ["loop1 : Array[(Double, Double, Double)]", "loop2 : Array[(Double, Double, Double)]"], "Int"),
            ("unknotting_number", "unknotting_number", ["genus : Int"], "Int"),
        ]
    },
    "lattice_geom": {
        "types": [],
        "funcs": [
            ("bravais_lattice_volume", "bravais_lattice_volume", ["a1x : Double", "a1y : Double", "a2x : Double", "a2y : Double"], "Double"),
            ("reciprocal_lattice", "reciprocal_lattice", ["a1x : Double", "a1y : Double", "a2x : Double", "a2y : Double"], "(Double, Double, Double, Double)"),
            ("nearest_lattice_point", "nearest_lattice_point", ["px : Double", "py : Double", "a1x : Double", "a1y : Double", "a2x : Double", "a2y : Double"], "(Int, Int)"),
            ("brillouin_zone_radius", "brillouin_zone_radius", ["a : Double"], "Double"),
            ("packing_fraction_sc", "packing_fraction_sc", ["r : Double", "a : Double"], "Double"),
        ]
    },
    "geom_arrangement": {
        "types": [],
        "funcs": [
            ("line_arrangement_count", "line_arrangement_count", ["n : Int"], "Int"),
            ("line_intersection", "ga_line_intersection", ["a1 : Double", "b1 : Double", "c1 : Double", "a2 : Double", "b2 : Double", "c2 : Double"], "(Double, Double)"),
            ("zone_complexity", "zone_complexity", ["n : Int"], "Int"),
            ("arrangement_faces", "arrangement_faces", ["n : Int"], "Int"),
            ("hyperplane_arrangement_regions", "hyperplane_arrangement_regions", ["n : Int", "d : Int"], "Int"),
            ("is_simple_arrangement", "is_simple_arrangement", ["slopes : Array[Double]"], "Bool"),
        ]
    },
    "exact_pred": {
        "types": [],
        "funcs": [
            ("exact_orientation", "exact_orientation", ["x_a : Double", "y_a : Double", "x_b : Double", "y_b : Double", "x_c : Double", "y_c : Double"], "Int"),
            ("exact_incircle", "exact_incircle", ["ax : Double", "ay : Double", "bx : Double", "by : Double", "cx : Double", "cy : Double", "dx : Double", "dy : Double"], "Int"),
            ("exact_left_of_line", "exact_left_of_line", ["px : Double", "py : Double", "ax : Double", "ay : Double", "bx : Double", "by : Double"], "Bool"),
            ("exact_collinear", "exact_collinear", ["ax : Double", "ay : Double", "bx : Double", "by : Double", "cx : Double", "cy : Double"], "Bool"),
        ]
    },
    "robust_arith": {
        "types": [],
        "funcs": [
            ("two_sum", "two_sum", ["a : Double", "b : Double"], "(Double, Double)"),
            ("two_prod", "two_prod", ["a : Double", "b : Double"], "(Double, Double)"),
            ("fast_two_sum", "fast_two_sum", ["a : Double", "b : Double"], "(Double, Double)"),
            ("grow_expansion", "grow_expansion", ["e : Array[Double]", "b : Double"], "Array[Double]"),
            ("expansion_sum", "expansion_sum", ["e : Array[Double]"], "Double"),
        ]
    },
    "filtered_pred": {
        "types": [],
        "funcs": [
            ("static_filter_bound", "static_filter_bound", ["coords : Array[Double]"], "Double"),
            ("filtered_orientation", "filtered_orientation", ["ax : Double", "ay : Double", "bx : Double", "by : Double", "cx : Double", "cy : Double"], "Int"),
            ("dynamic_filter", "dynamic_filter", ["a : Double", "b : Double", "eps : Double"], "Bool"),
            ("filter_result", "filter_result", ["det : Double", "bound : Double"], "Int"),
        ]
    },
    "static_filter": {
        "types": [],
        "funcs": [
            ("epsilon_bound", "epsilon_bound", ["n : Int"], "Double"),
            ("coord_max_bound", "coord_max_bound", ["coords : Array[Double]"], "Double"),
            ("orient2d_bound", "orient2d_bound", ["max_coord : Double"], "Double"),
            ("incircle_bound", "incircle_bound", ["max_coord : Double"], "Double"),
            ("filter_pass", "filter_pass", ["det : Double", "bound : Double"], "Bool"),
        ]
    },
    "dynamic_filter": {
        "types": ["Interval"],
        "funcs": [
            ("Interval::new", "interval_new", ["lo : Double", "hi : Double"], "Interval"),
            ("Interval::add", "interval_add", ["self : Interval", "other : Interval"], "Interval"),
            ("Interval::mul", "interval_mul", ["self : Interval", "other : Interval"], "Interval"),
            ("Interval::width", "interval_width", ["self : Interval"], "Double"),
            ("Interval::contains_zero", "interval_contains_zero", ["self : Interval"], "Bool"),
        ]
    },
    "interval_arith": {
        "types": ["GeoInterval"],
        "funcs": [
            ("GeoInterval::new", "geo_interval_new", ["center : Double", "radius : Double"], "GeoInterval"),
            ("GeoInterval::add", "geo_interval_add", ["self : GeoInterval", "other : GeoInterval"], "GeoInterval"),
            ("GeoInterval::sub", "geo_interval_sub", ["self : GeoInterval", "other : GeoInterval"], "GeoInterval"),
            ("GeoInterval::mul", "geo_interval_mul", ["self : GeoInterval", "other : GeoInterval"], "GeoInterval"),
            ("GeoInterval::contains", "geo_interval_contains", ["self : GeoInterval", "val : Double"], "Bool"),
            ("GeoInterval::overlaps", "geo_interval_overlaps", ["self : GeoInterval", "other : GeoInterval"], "Bool"),
        ]
    },
    "adaptive_pred": {
        "types": [],
        "funcs": [
            ("adaptive_orient2d", "adaptive_orient2d", ["ax : Double", "ay : Double", "bx : Double", "by : Double", "cx : Double", "cy : Double"], "Int"),
            ("adaptive_incircle", "adaptive_incircle", ["ax : Double", "ay : Double", "bx : Double", "by : Double", "cx : Double", "cy : Double", "dx : Double", "dy : Double"], "Int"),
            ("precision_level", "precision_level", ["det : Double", "bound : Double"], "Int"),
        ]
    },
    "expansion_arith": {
        "types": [],
        "funcs": [
            ("scale_expansion", "scale_expansion", ["e : Array[Double]", "b : Double"], "Array[Double]"),
            ("compress_expansion", "compress_expansion", ["e : Array[Double]"], "Array[Double]"),
            ("expansion_length", "expansion_length", ["e : Array[Double]"], "Int"),
            ("expansion_norm", "expansion_norm", ["e : Array[Double]"], "Double"),
            ("expansion_negate", "expansion_negate", ["e : Array[Double]"], "Array[Double]"),
        ]
    },
    "robust_inter": {
        "types": [],
        "funcs": [
            ("robust_segment_intersect", "robust_segment_intersect", ["a1x : Double", "a1y : Double", "a2x : Double", "a2y : Double", "b1x : Double", "b1y : Double", "b2x : Double", "b2y : Double"], "(Double, Double, Bool)"),
            ("robust_line_line", "robust_line_line", ["a1 : Double", "b1 : Double", "c1 : Double", "a2 : Double", "b2 : Double", "c2 : Double"], "(Double, Double, Bool)"),
            ("robust_point_on_segment", "robust_point_on_segment", ["px : Double", "py : Double", "ax : Double", "ay : Double", "bx : Double", "by : Double"], "Bool"),
        ]
    },
    "robust_orient": {
        "types": [],
        "funcs": [
            ("robust_orient2d", "robust_orient2d", ["ax : Double", "ay : Double", "bx : Double", "by : Double", "cx : Double", "cy : Double"], "Int"),
            ("robust_orient3d", "robust_orient3d", ["ax : Double", "ay : Double", "az : Double", "bx : Double", "by : Double", "bz : Double", "cx : Double", "cy : Double", "cz : Double", "dx : Double", "dy : Double", "dz : Double"], "Int"),
            ("robust_sign", "robust_sign", ["val : Double", "tol : Double"], "Int"),
            ("robust_compare", "robust_compare", ["a : Double", "b : Double", "tol : Double"], "Int"),
        ]
    },
    "geom_opt": {
        "types": [],
        "funcs": [
            ("smallest_enclosing_circle_radius", "smallest_enclosing_circle_radius", ["points : Array[(Double, Double)]"], "Double"),
            ("minimum_width_rectangle", "minimum_width_rectangle", ["points : Array[(Double, Double)]"], "Double"),
            ("geometric_mean", "geometric_mean", ["values : Array[Double]"], "Double"),
            ("fermat_point_approx", "fermat_point_approx", ["x_a : Double", "y_a : Double", "x_b : Double", "y_b : Double", "x_c : Double", "y_c : Double"], "(Double, Double)"),
        ]
    },
    "isoperimetric": {
        "types": [],
        "funcs": [
            ("isoperimetric_ratio", "isoperimetric_ratio", ["perimeter : Double", "area : Double"], "Double"),
            ("isoperimetric_deficit", "isoperimetric_deficit", ["perimeter : Double", "area : Double"], "Double"),
            ("circle_area_from_perimeter", "circle_area_from_perimeter", ["p : Double"], "Double"),
            ("circle_perimeter_from_area", "circle_perimeter_from_area", ["a : Double"], "Double"),
            ("optimal_shape_area", "optimal_shape_area", ["perimeter : Double"], "Double"),
            ("is_isoperimetric_optimal", "is_isoperimetric_optimal", ["perimeter : Double", "area : Double"], "Bool"),
        ]
    },
    "geom_inequal": {
        "types": [],
        "funcs": [
            ("brunn_minkowski", "brunn_minkowski", ["vol_a : Double", "vol_b : Double"], "Double"),
            ("cauchy_schwarz", "cauchy_schwarz", ["a1 : Double", "a2 : Double", "b1 : Double", "b2 : Double"], "Double"),
            ("triangle_inequality", "triangle_inequality", ["a : Double", "b : Double", "c : Double"], "Bool"),
            ("ptolemy_inequality", "ptolemy_inequality", ["a : Double", "b : Double", "c : Double", "d : Double", "e : Double", "f : Double"], "Double"),
            ("weitzenbock_inequality", "weitzenbock_inequality", ["a : Double", "b : Double", "c : Double", "area : Double"], "Double"),
        ]
    },
    "geom_prob": {
        "types": [],
        "funcs": [
            ("buffon_needle_probability", "buffon_needle_probability", ["needle_length : Double", "line_spacing : Double"], "Double"),
            ("bertrand_probability", "bertrand_probability", ["method : Int"], "Double"),
            ("random_chord_length", "random_chord_length", ["radius : Double"], "Double"),
            ("geometric_probability_hit", "geometric_probability_hit", ["area_target : Double", "area_total : Double"], "Double"),
            ("expected_distance_unit_square", "expected_distance_unit_square", [], "Double"),
            ("coverage_probability", "coverage_probability", ["n : Int", "area_ratio : Double"], "Double"),
        ]
    },
    "stochastic_geom": {
        "types": [],
        "funcs": [
            ("poisson_point_count", "poisson_point_count", ["intensity : Double", "area : Double"], "Double"),
            ("poisson_probability", "poisson_probability", ["k : Int", "intensity : Double", "area : Double"], "Double"),
            ("boolean_model_coverage", "boolean_model_coverage", ["intensity : Double", "grain_area : Double"], "Double"),
            ("voronoi_cell_expected_area", "voronoi_cell_expected_area", ["intensity : Double"], "Double"),
            ("random_tessellation_edge_density", "random_tessellation_edge_density", ["intensity : Double"], "Double"),
        ]
    },
    "random_geom_graph": {
        "types": [],
        "funcs": [
            ("connectivity_threshold", "connectivity_threshold", ["n : Int", "area : Double"], "Double"),
            ("percolation_threshold_2d", "percolation_threshold_2d", [], "Double"),
            ("coverage_threshold", "coverage_threshold", ["n : Int", "area : Double"], "Double"),
            ("expected_degree", "expected_degree", ["n : Int", "radius : Double", "area : Double"], "Double"),
            ("isolation_probability", "isolation_probability", ["n : Int", "radius : Double", "area : Double"], "Double"),
        ]
    },
    "geom_hash": {
        "types": [],
        "funcs": [
            ("hash_point_2d", "hash_point_2d", ["x : Double", "y : Double", "grid_size : Double"], "(Int, Int)"),
            ("hash_basis_invariant", "hash_basis_invariant", ["p1x : Double", "p1y : Double", "p2x : Double", "p2y : Double", "p3x : Double", "p3y : Double"], "(Double, Double)"),
            ("hash_key", "hash_key", ["x : Double", "y : Double", "bins : Int"], "Int"),
            ("similarity_score", "similarity_score", ["h1 : Array[Int]", "h2 : Array[Int]"], "Double"),
        ]
    },
    "geom_coding": {
        "types": [],
        "funcs": [
            ("sphere_packing_density_sc", "sphere_packing_density_sc", [], "Double"),
            ("sphere_packing_density_fcc", "sphere_packing_density_fcc", [], "Double"),
            ("kissing_number_2d", "kissing_number_2d", [], "Int"),
            ("kissing_number_3d", "kissing_number_3d", [], "Int"),
            ("hamming_bound", "hamming_bound", ["n : Int", "d : Int", "t : Int"], "Double"),
            ("gilbert_varshamov_bound", "gilbert_varshamov_bound", ["n : Int", "d : Int"], "Double"),
        ]
    },
    "geom_mechanics": {
        "types": [],
        "funcs": [
            ("lagrangian", "lagrangian", ["kinetic : Double", "potential : Double"], "Double"),
            ("hamiltonian", "hamiltonian", ["kinetic : Double", "potential : Double"], "Double"),
            ("euler_lagrange", "euler_lagrange", ["dL_dq : Double", "dL_dqdot : Double", "dt : Double"], "Double"),
            ("hamilton_equation_q", "hamilton_equation_q", ["dH_dp : Double", "dt : Double"], "Double"),
            ("hamilton_equation_p", "hamilton_equation_p", ["dH_dq : Double", "dt : Double"], "Double"),
            ("noether_charge", "noether_charge", ["dL_dqdot : Double", "xi : Double"], "Double"),
            ("action_integral", "action_integral", ["lagrangian_vals : Array[Double]", "dt : Double"], "Double"),
        ]
    },
    "symplectic_int": {
        "types": [],
        "funcs": [
            ("stormer_verlet", "stormer_verlet", ["q : Double", "p : Double", "force : (Double) -> Double", "dt : Double"], "(Double, Double)"),
            ("leapfrog", "leapfrog", ["q : Double", "p : Double", "force : (Double) -> Double", "dt : Double"], "(Double, Double)"),
            ("ruth3", "ruth3", ["q : Double", "p : Double", "force : (Double) -> Double", "dt : Double"], "(Double, Double)"),
            ("energy_conservation_error", "energy_conservation_error", ["h0 : Double", "h1 : Double"], "Double"),
        ]
    },
    "molecular_geom": {
        "types": [],
        "funcs": [
            ("bond_length", "bond_length", ["a1x : Double", "a1y : Double", "a1z : Double", "a2x : Double", "a2y : Double", "a2z : Double"], "Double"),
            ("bond_angle", "bond_angle", ["a1x : Double", "a1y : Double", "a1z : Double", "cx : Double", "cy : Double", "cz : Double", "a2x : Double", "a2y : Double", "a2z : Double"], "Double"),
            ("torsion_angle", "torsion_angle", ["p1x : Double", "p1y : Double", "p1z : Double", "p2x : Double", "p2y : Double", "p2z : Double", "p3x : Double", "p3y : Double", "p3z : Double", "p4x : Double", "p4y : Double", "p4z : Double"], "Double"),
            ("rmsd", "rmsd", ["coords1 : Array[(Double, Double, Double)]", "coords2 : Array[(Double, Double, Double)]"], "Double"),
        ]
    },
    "protein_geom": {
        "types": [],
        "funcs": [
            ("ramachandran_allowed", "ramachandran_allowed", ["phi : Double", "psi : Double"], "Bool"),
            ("helix_pitch", "helix_pitch", ["rise_per_residue : Double", "turn_per_residue : Double"], "Double"),
            ("helix_radius", "helix_radius", ["rise_per_residue : Double", "turn_per_residue : Double"], "Double"),
            ("secondary_structure_type", "secondary_structure_type", ["phi : Double", "psi : Double"], "String"),
            ("contact_map_distance", "contact_map_distance", ["ca1 : Array[(Double, Double, Double)]", "ca2 : Array[(Double, Double, Double)]", "threshold : Double"], "Int"),
        ]
    },
    "drug_design": {
        "types": [],
        "funcs": [
            ("pharmacophore_distance", "pharmacophore_distance", ["f1 : Array[Double]", "f2 : Array[Double]"], "Double"),
            ("docking_score_compat", "docking_score_compat", ["distance : Double", "ideal : Double", "tolerance : Double"], "Double"),
            ("vdw_radius", "vdw_radius", ["element : Int"], "Double"),
            ("clash_detection", "clash_detection", ["d : Double", "r1 : Double", "r2 : Double"], "Bool"),
            ("binding_pocket_volume", "binding_pocket_volume", ["radius : Double"], "Double"),
        ]
    },
    "crystal_geom": {
        "types": [],
        "funcs": [
            ("point_group_order", "point_group_order", ["group_id : Int"], "Int"),
            ("space_group_count_2d", "space_group_count_2d", [], "Int"),
            ("space_group_count_3d", "space_group_count_3d", [], "Int"),
            ("wyckoff_multiplicity", "wyckoff_multiplicity", ["site : Int"], "Int"),
            ("bravais_type", "bravais_type", ["a : Double", "b : Double", "c : Double", "alpha : Double", "beta : Double", "gamma : Double"], "String"),
        ]
    },
    "quantum_geom": {
        "types": [],
        "funcs": [
            ("q_deformed_product", "q_deformed_product", ["a : Double", "b : Double", "q : Double"], "Double"),
            ("q_commutator", "q_commutator", ["a : Double", "b : Double", "q : Double"], "Double"),
            ("q_number", "q_number", ["n : Int", "q : Double"], "Double"),
            ("q_factorial", "q_factorial", ["n : Int", "q : Double"], "Double"),
            ("q_binomial", "q_binomial", ["n : Int", "k : Int", "q : Double"], "Double"),
            ("quantum_metric", "quantum_metric", ["g11 : Double", "g22 : Double", "q : Double"], "(Double, Double)"),
        ]
    },
    "topological_quantum": {
        "types": [],
        "funcs": [
            ("anyon_braid_phase", "anyon_braid_phase", ["theta : Double", "n : Int"], "Double"),
            ("fibonacci_anyon_phase", "fibonacci_anyon_phase", ["n : Int"], "Double"),
            ("ising_anyon_phase", "ising_anyon_phase", ["n : Int"], "Double"),
            ("braid_group_relation", "braid_group_relation", ["a : Double", "b : Double", "c : Double"], "Bool"),
            ("topological_gate_fidelity", "topological_gate_fidelity", ["phase1 : Double", "phase2 : Double"], "Double"),
            ("majorana_fusion_rule", "majorana_fusion_rule", ["n : Int"], "Int"),
        ]
    },
    "fractal_gen": {
        "types": [],
        "funcs": [
            ("mandelbrot_escape", "mandelbrot_escape", ["cx : Double", "cy : Double", "max_iter : Int"], "Int"),
            ("julia_escape", "julia_escape", ["zx : Double", "zy : Double", "cx : Double", "cy : Double", "max_iter : Int"], "Int"),
            ("ifs_contractive_factor", "ifs_contractive_factor", ["scales : Array[Double]"], "Double"),
            ("fractal_dimension_box", "fractal_dimension_box", ["counts : Array[(Double, Int)]"], "Double"),
            ("koch_curve_length", "koch_curve_length", ["iteration : Int", "base_length : Double"], "Double"),
        ]
    },
    "chaos_geom": {
        "types": [],
        "funcs": [
            ("lorenz_step", "lorenz_step", ["x : Double", "y : Double", "z : Double", "sigma : Double", "rho : Double", "beta : Double", "dt : Double"], "(Double, Double, Double)"),
            ("lyapunov_exponent_logistic", "lyapunov_exponent_logistic", ["r : Double", "x0 : Double", "n : Int"], "Double"),
            ("henon_map", "henon_map", ["x : Double", "y : Double", "a : Double", "b : Double"], "(Double, Double)"),
            ("bifurcation_point_logistic", "bifurcation_point_logistic", [], "Double"),
            ("strange_attractor_dimension", "strange_attractor_dimension", ["lyapunov : Array[Double]"], "Double"),
        ]
    },
    "wavelet_geom": {
        "types": [],
        "funcs": [
            ("haar_wavelet", "haar_wavelet", ["x : Double"], "Double"),
            ("haar_scaling", "haar_scaling", ["x : Double"], "Double"),
            ("daubechies4_weight", "daubechies4_weight", ["j : Int"], "Double"),
            ("wavelet_transform_1d", "wavelet_transform_1d", ["data : Array[Double]"], "Array[Double]"),
            ("multi_resolution_level", "multi_resolution_level", ["data : Array[Double]", "level : Int"], "Array[Double]"),
        ]
    },
    "spectral_geom": {
        "types": [],
        "funcs": [
            ("laplacian_spectrum_1d", "laplacian_spectrum_1d", ["n : Int", "length : Double"], "Array[Double]"),
            ("heat_kernel_1d", "heat_kernel_1d", ["x : Double", "t : Double", "n_terms : Int"], "Double"),
            ("weyl_law_2d", "weyl_law_2d", ["lambda : Double", "area : Double"], "Double"),
            ("spectral_zeta", "spectral_zeta", ["eigenvalues : Array[Double]", "s : Double"], "Double"),
            ("heat_trace", "heat_trace", ["eigenvalues : Array[Double]", "t : Double"], "Double"),
            ("isospectral_check", "isospectral_check", ["spec1 : Array[Double]", "spec2 : Array[Double]"], "Bool"),
        ]
    },
}

lines = []
for mod, info in MODULES.items():
    lines.append(f"\n// ========== {mod} ==========")
    for t in info["types"]:
        lines.append(f"pub type {t} = @{mod}.{t}")
    for orig_name, reexp_name, params, ret in info["funcs"]:
        param_str = ", ".join(params)
        if param_str:
            sig = f"({param_str}) -> {ret}"
        else:
            sig = f"() -> {ret}"
        if "::" in orig_name:
            call = f"@{mod}.{orig_name}"
        else:
            call = f"@{mod}.{orig_name}"
        if param_str:
            body = f"{call}({', '.join(p.split(' : ')[0] for p in params)})"
        else:
            body = f"{call}()"
        lines.append(f"pub fn {reexp_name}{sig} {{")
        lines.append(f"  {body}")
        lines.append("}")

output = "\n".join(lines) + "\n"
out_path = os.path.join(os.path.dirname(__file__), "phase21_24_reexport.txt")
with open(out_path, "w", encoding="utf-8") as f:
    f.write(output)
print(f"Generated {len(lines)} lines for {len(MODULES)} modules")