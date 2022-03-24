using Test: @test, @testset, @inferred
using BarsAndStripes: bas, bas!, isbas, iscols, isrows, nbas

@testset "bas, bas!" begin
    @test isbas(bas(100, 100))
    n = 3
    m = 5
    imgs = [reshape(BitArray(digits(x; base=2, pad=n*m)), n, m) for x in 0:(2^(n * m) - 1)]
    dict = Dict(img => 1 for img in imgs if isbas(img))
    @test length(keys(dict)) == nbas(n,m)
    for _ = 1:10^7
        mergewith!(+, dict, Dict(bas(n,m) => 1))
    end
    @test length(keys(dict)) == nbas(n,m)
    @test all(isbas, keys(dict))
    total_count = sum(values(dict))
    @test total_count == 10^7 + nbas(n,m)
    freqs = Dict(img => count / total_count for (img, count) in dict)
    for (img, freq) in freqs
        if all(img) || all(!, img)
            @test freq  ≈ 1 / 2^(n + 1) + 1 / 2^(m + 1) rtol=0.1
        elseif isrows(img)
            @test freq  ≈ 1 / 2^(n + 1) rtol=0.1
        elseif iscols(img)
            @test freq  ≈ 1 / 2^(m + 1) rtol=0.1
        end
    end
end
