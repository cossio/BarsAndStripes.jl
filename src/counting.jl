"""
    nbas(n, m)

Number of images belonging to the Bars and Stripes ensemble, in a `n x m` grid.
"""
nbas(n::Integer, m::Integer) = 2^n + 2^m - 2

"""
    lognbas(n, m)

log(nbas(n,m)) computed without intermediate overflow.
"""
function lognbas(n::Integer, m::Integer)
    m, n = minmax(n, m)
    return n * log(2) + log1p((1 - 2.0^(1 - m)) * 2.0^(m - n))
end

"""
    isbas(img)

Returns `true` if `img` belongs to the Bars and Stripes ensemble.
"""
isbas(img::AbstractMatrix{<:Bool}) = iscols(img) || isrows(img)
iscols(img::AbstractMatrix{<:Bool}) = all(all.(eachcol(img)) .⊻ all.(!, eachcol(img)))
isrows(img::AbstractMatrix{<:Bool}) = all(all.(eachrow(img)) .⊻ all.(!, eachrow(img)))
