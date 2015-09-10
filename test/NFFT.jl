using GeneralizedSampling
using Base.Test

# Test if multiplication with NFFT is correct
M = 2^4
xi = collect(linspace(-0.4, 0.4, M))
xi = rand(M)*10

J = 3
T = freq2wave(xi, "Haar", J)
A = freq2Haar(xi, J)

N = 2^J
b = rand(N) + rand(N)*im
y1 = T*b
y2 = A*b

@test_approx_eq_eps(y1, y2, 1e-5) 

