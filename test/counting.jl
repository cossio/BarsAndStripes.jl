using Test: @test, @testset, @inferred
using Random: bitrand
using BarsAndStripes: nbas, lognbas, isbas, iscols, isrows

@testset "isbas, iscols, isrows" begin
    @test iscols(falses(5,7))
    @test isrows(falses(5,7))
    @test isbas(falses(5, 7))

    @test iscols(trues(5,7))
    @test isrows(trues(5,7))
    @test isbas(trues(10, 7))

    @test isrows(bitrand(100,1))
    @test isbas(bitrand(100,1))

    @test iscols(bitrand(1,100))
    @test isbas(bitrand(1,100))
end

@testset "nbas" begin
    n, m = 3, 5
    ds = digits.(0:(2^(n * m) - 1); base = 2, pad = n * m)
    imgs = [reshape(BitArray(d), n, m) for d in ds]
    @test @inferred(nbas(n, m)) == sum(isbas.(imgs))
end

@testset "lognbas" begin
    for n in 1:3, m in 1:3
        @test @inferred(lognbas(n, m)) ≈ log(@inferred nbas(n, m))
    end
end
