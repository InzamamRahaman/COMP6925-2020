using JuMP
using Clp

m = Model(Clp.Optimizer)

# specify variables and their ranges
@variable(m, x[1:10] >= 0)
C = rand(6)
for i in 1:6
    @constraint(m, sum(x[i:(i + 4)]) <= C[i])
end


X = [x1, x2]

C = [0.4, 0.5]

# specify the objective function to optimize and whether to minimize or maximize
@objective(m, Min, dot(C, X))

# specify the constraints
@constraint(m, 0.3x1 + 0.1x2 <= 2.7)
@constraint(m, 0.5x1 + 0.5x2 == 6)
@constraint(m, 0.6x1 + 0.4x2 >= 6)

print(m)

status = solve(m)

println("Solution status: ", status)

println("Objective value: ", getobjectivevalue(m))
println("x1 = ", getvalue(x1))
println("x2 = ", getvalue(x2))
