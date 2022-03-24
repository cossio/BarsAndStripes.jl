import Makie
import CairoMakie
using BarsAndStripes: bas
nothing #hide

# Some example patterns of the Bars and Stripes (BAS) ensemble.

fig = Makie.Figure(resolution = (600,600))
for col in 1:7, row in 1:4
    ax = Makie.Axis(fig[row, col], yreversed=true)
    Makie.image!(ax, bas(10, 10), colorrange=(1,0))
    Makie.hidedecorations!(ax)
    Makie.hidespines!(ax)
end
fig
