using StaticArrays
using WaterLily
using Plots

function cylinder(n, m; Re=250, U=1, ω=0, mem=Array, T=Float32)
    radius = T(m / 8)
    center = SVector{2,T}(T(m / 2), T(m / 2))

    sdf(x, t) = sqrt(sum(abs2, x)) - radius

    map = RigidMap(center, zero(T); ω=T(ω))
    body = AutoBody(sdf, map)

    Simulation(
        (n, m),
        (U, 0),
        2radius;
        T,
        ν=U * 2radius / Re,
        body,
        mem
    )
end

cID = "2D_Cylinder_Comparison"

stationary = cylinder(
    3 * 2^5,
    2^6;
    Re=100,
    U=1,
    ω=0
)

rotating = cylinder(
    3 * 2^5,
    2^6;
    Re=100,
    U=1,
    ω=0.5
)

sim_gif!(
    stationary;
    duration=10,
    step=0.2,
    clims=(-5, 5),
    plotbody=true
)

sim_gif!(
    rotating;
    duration=10,
    step=0.2,
    clims=(-5, 5),
    plotbody=true
)