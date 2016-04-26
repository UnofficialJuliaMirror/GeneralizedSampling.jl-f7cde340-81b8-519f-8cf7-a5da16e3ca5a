#= 
Reconstruct "brain" from Fourier measurements.
The measurements are generated with the Matlab files from
http://bigwww.epfl.ch/algorithms/mriphantom
=#

# ------------------------------------------------------------
# Load data

using JLD
data_file = joinpath(dirname(@__FILE__), "brain512.jld")
F = load( data_file )
f = F["freqs"]

# Sampling locations
M = size( f )
J = Int( log2(M[1]) ) - 1


# ------------------------------------------------------------
# Compute reconstruction

using GeneralizedSampling

xi = GeneralizedSampling.grid(M)
T = freq2wave( xi, "Haar", J )
wcoef = T \ f

w = fftshift(wcoef)

# ------------------------------------------------------------
# Plot reconstruction

using WaveletPlot, Winston

y = weval( abs(w), 10 )

miny = minimum(y)
maxy = maximum(y)
imagesc( y, (miny,maxy) )

