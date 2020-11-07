using JuMP
using Cbc

m = Model(Cbc.Optimizer)


# specify variables and their ranges
@variable(m, 0 <= x1 <= 1, Int)
@variable(m, 0 <= x2 <= 1, Int)
@variable(m, 0 <= x3 <= 1, Int)
@variable(m, 0 <= x4 <= 1, Int)
@variable(m, 0 <= x5 <= 1, Int)




# specify the objective function to optimize and whether to minimize or maximize
@objective(m, Max, 20x1 + 40x2 + 20x3 + 15x4 + 30x5)

# specify the constraints
@constraint(m, 5x1 + 4x2 + 3x3 + 7x4 + 8x5 <= 25)
@constraint(m, x1 + 7x2 + 9x3 + 4x4 + 6x5 <= 25)
@constraint(m, 8x1 + 10x2 + 2x3 + x4 + 10x5 <= 25)

print(m)

optimize!(m)

status = termination_status(m)

println("Solution status: ", status)

println("Objective value: ", objective_value(m))

println("Values: ", value(x1))
