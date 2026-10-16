import re
import os

MODULES = [
    "kernel_density", "gaussian_process", "svm_geometry", "decision_boundary", "feature_projection",
    "manifold_learning", "dimension_reduction", "clustering_geom", "regression_geom", "bayesian_geom",
    "rrt_star", "prm_planner", "potential_field", "trajectory_opt", "motion_planner_3d",
    "kinematics", "dynamics_geom", "collision_detect_3d", "grasp_planning", "workspace_analysis",
    "ray_trace_ops", "raster_2d", "shading_model", "texture_mapping", "bump_mapping",
    "env_mapping", "shadow_mapping", "anti_aliasing", "splatting", "gpu_geometry",
    "heat_equation", "wave_equation", "poisson_solver", "navier_stokes", "maxwell_solver",
    "schrodinger_solver", "reaction_diffusion", "advection_solver", "diffusion_solver", "eigenvalue_solver",
]

CONFLICTS = {
    ("kernel_density", "gaussian_kernel"): "kd_gaussian_kernel",
    ("gaussian_process", "squared_exp_kernel"): "gp_squared_exp_kernel",
    ("shading_model", "lambertian"): "sm_lambertian",
    ("clustering_geom", "kmeans_assign"): "cg_kmeans_assign",
    ("manifold_learning", "laplacian_weight"): "ml_laplacian_weight",
    ("dynamics_geom", "angular_momentum"): "dg_angular_momentum",
    ("dynamics_geom", "torque"): "dg_torque",
    ("dynamics_geom", "kinetic_energy_rot"): "dg_kinetic_energy_rot",
    ("grasp_planning", "grasp_quality"): "gp_grasp_quality",
    ("workspace_analysis", "condition_number"): "wa_condition_number",
    ("heat_equation", "heat_explicit_step"): "he_heat_explicit_step",
    ("diffusion_solver", "diffusion_2d_step"): "ds_diffusion_2d_step",
    ("diffusion_solver", "diffusion_stability_check"): "ds_diffusion_stability_check",
    ("advection_solver", "upwind_advection"): "as_upwind_advection",
    ("navier_stokes", "ns_advection"): "ns_ns_advection",
    ("maxwell_solver", "fdtd_update_e"): "ms_fdtd_update_e",
    ("maxwell_solver", "fdtd_update_h"): "ms_fdtd_update_h",
    ("poisson_solver", "poisson_jacobi"): "ps_poisson_jacobi",
    ("poisson_solver", "poisson_residual"): "ps_poisson_residual",
    ("wave_equation", "wave_explicit_step"): "we_wave_explicit_step",
    ("wave_equation", "wave_damping"): "we_wave_damping",
    ("wave_equation", "wave_energy"): "we_wave_energy",
}

output = []

for mod in MODULES:
    src_file = f"src/{mod}/{mod}.mbt"
    if not os.path.exists(src_file):
        output.append(f"// WARNING: {src_file} not found")
        continue

    with open(src_file, 'r', encoding='utf-8') as f:
        content = f.read()

    output.append("")
    output.append(f"// ========== {mod} ==========")

    # Extract pub structs
    for m in re.finditer(r'^pub struct (\w+)', content, re.MULTILINE):
        struct_name = m.group(1)
        output.append(f"pub type {struct_name} = @{mod}.{struct_name}")

    # Extract pub fn declarations (not methods)
    for m in re.finditer(r'^pub fn (\w+)\s*\(', content, re.MULTILINE):
        fn_name = m.group(1)
        if '::' in fn_name:
            continue

        start = m.start()
        try:
            brace_pos = content.index('{', start)
        except ValueError:
            continue
        sig = content[start:brace_pos].strip()

        paren_start = sig.index('(')
        depth = 0
        paren_end = paren_start
        for i in range(paren_start, len(sig)):
            if sig[i] == '(':
                depth += 1
            elif sig[i] == ')':
                depth -= 1
                if depth == 0:
                    paren_end = i
                    break

        params = sig[paren_start+1:paren_end]

        after_paren = sig[paren_end+1:].strip()
        if '->' in after_paren:
            ret_type = after_paren.split('->', 1)[1].strip()
        else:
            ret_type = "Unit"

        param_names = []
        depth = 0
        current_param = ""
        for ch in params:
            if ch in '([{':
                depth += 1
                current_param += ch
            elif ch in ')]}':
                depth -= 1
                current_param += ch
            elif ch == ',' and depth == 0:
                p = current_param.strip()
                if p:
                    name = p.split(':')[0].strip()
                    if name.startswith('let '):
                        name = name[4:]
                    if name and name != '_':
                        param_names.append(name)
                current_param = ""
            else:
                current_param += ch
        p = current_param.strip()
        if p:
            name = p.split(':')[0].strip()
            if name.startswith('let '):
                name = name[4:]
            if name and name != '_':
                param_names.append(name)

        call_args = ', '.join(param_names)

        export_name = CONFLICTS.get((mod, fn_name), fn_name)

        if params.strip():
            output.append(f"pub fn {export_name}({params}) -> {ret_type} {{")
        else:
            output.append(f"pub fn {export_name}() -> {ret_type} {{")
        output.append(f"  @{mod}.{fn_name}({call_args})")
        output.append("}")

print('\n'.join(output))