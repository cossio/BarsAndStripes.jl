"""
    sample!(img)

Samples a random BAS and writes it in `img`.
"""
function sample!(img::AbstractMatrix{<:Bool})
    n, m = size(img)
    vertical = rand(Bool)
    if vertical
        cols = randsubseq(1:m, 0.5)
        img[:, cols] .= true
    else
        rows = randsubseq(1:n, 0.5)
        img[rows, :] .= true
    end
    return img
end

function sample!(img::AbstractArray{<:Bool})
    @assert ndims(img) > 2
    for b in CartesianIndices(axes(img)[3:end])
        sample!(img[:,:,b])
    end
    return img
end

sample(n::Int...) = sample!(falses(n))

const bas = sample
const bas! = sample!
