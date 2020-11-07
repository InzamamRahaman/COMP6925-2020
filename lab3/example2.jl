using JuMP
using Ipopt


m = Model(Ipopt.Optimizer)

@variable(m, x1 >= 0)
@variable(m, x2 >= 0)

@NLobjective(m, Max, 126x1 - 9x2^2 + 182x2 - 13x2^2)

# specify the constraints
@constraint(m, x1 <= 4)
@constraint(m, 2x2 <= 12)
@constraint(m, 3x1 + 2x2 <= 25)

print(m)

optimize!(m)

status = termination_status(m)

println("Solution status: ", status)

println("Objective value: ", objective_value(m))

println("Values: ", value(x1))

println("Values: ", value(x2))
