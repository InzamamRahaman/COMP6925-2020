using JuMP
using Cbc

m = Model(Cbc.Optimizer)

@variable(m, 0 ≤ em ≤ 1, Int)
@variable(m, 0 ≤ ec ≤ 1, Int)
@variable(m, 0 ≤ ed ≤ 1, Int)
@variable(m, 0 ≤ el ≤ 1, Int)

@variable(m, 0 ≤ sm ≤ 1, Int)
@variable(m, 0 ≤ sc ≤ 1, Int)
@variable(m, 0 ≤ sd ≤ 1, Int)
@variable(m, 0 ≤ sl ≤ 1, Int)

@objective(m, Min, 4.9em + 4.5sm + 7.2ec + 7.8sc + 4.3ed + 3.5sd + 3.1el + 2.9sl)

@constraint(m, em + ec + ed + el == 2)
@constraint(m, sm + sc + sd + sl == 2)

@constraint(m, em + sm == 1)
@constraint(m, ec+ sc == 1)
@constraint(m, ed + sd == 1)
@constraint(m, el + sl == 1)

print(m)

optimize!(m)

status = termination_status(m)

println("Solution status: ", status)

println("Objective value: ", objective_value(m))
println("Eve does marketing: ", value(em))
println("Steve does marketing: ", value(sm))

println("Eve does cooking: ", value(ec))
println("Steve does cooking: ", value(sc))

println("Eve does dishwashing: ", value(ed))
println("Steve does dishwashing: ", value(sd))

println("Eve does laundry: ", value(el))
println("Steve does laundry: ", value(sl))
