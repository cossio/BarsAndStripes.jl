using SafeTestsets: @safetestset

@safetestset "counting" begin include("counting.jl") end
@safetestset "sampling" begin include("sampling.jl") end
