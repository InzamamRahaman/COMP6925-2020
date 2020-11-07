using JuMP
using Cbc

m =  Model(Cbc.Optimizer)

@variable(m, b >= 0, Int)
@variable(m, p >= 0, Int)
@variable(m, s >= 0, Int)
@variable(m, g >= 0, Int)
@variable(m, ml >= 0, Int)
@variable(m, j >= 0, Int)

@objective(m, Min, 5b + 4p + 7s + 8g + 15ml + 35j)

@constraint(m, b == 2)
@constraint(m, p ≥ 2s)
@expression(m, tcals, 70b + 100p + 50s + 60g + 150ml + 100j)
@expression(m, fcals, 10b + 75p + 20g + 70ml)
@constraint(m, tcals ≥ 400)
@constraint(m, tcals ≤ 600)
@constraint(m, ml + j ≥ 1)
@constraint(m, fcals ≤ 0.3tcals)

optimize!(m)
status = termination_status(m)
println(status)
