using JuMP
using Clp

m = Model(Clp.Optimizer)

NUM_SOURCES = 3
NUM_SINKS = 4

COSTS = [
    [800 1300 400 700]
    [1100 1400 600 1000]
    [600 1200 800 900]
]

SUPPLIES = [12 17 11]
DEMANDS = [10 10 10 10]



@variable(m, x[1:NUM_SOURCES, 1:NUM_SINKS] ≥ 0)
@objective(m, Min, 0.5 * sum(COSTS .* x) + 100 * sum(x))

for i = 1:NUM_SOURCES
    @constraint(m, sum(x[i, :]) ≤ SUPPLIES[i])
end

for j = 1:NUM_SINKS
    @constraint(m, sum(x[:, j]) == DEMANDS[j])
end



print(m)

optimize!(m)

status = termination_status(m)

println("Solution status: ", status)

println("Objective value: ", objective_value(m))

println("Decisions: ", value.(x))
