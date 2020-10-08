import numpy as np

# Decay constants of Ag108 and Ag110 (per second)
lambda_108 = 0.693 / (2.4 * 60)
lambda_110 = 0.693 / 25.0

# Calculate the expected number of decays in
# the interval [t0, t1] for a single isotope.
def calculate_decays_in_interval_single(n, lmbda, t0, t1):
    return n * (np.exp(-lmbda*t0) - np.exp(-lmbda*t1))

# Calculate the expected number of decays in
# the interval [t0, t1] for each of the two isotopes.
def calculate_decays_in_interval(nnuclei, t0, t1):
    ndecays_108 = calculate_decays_in_interval_single(nnuclei[0], lambda_108, t0, t1)
    ndecays_110 = calculate_decays_in_interval_single(nnuclei[1], lambda_110, t0, t1)
    return np.array([ndecays_108, ndecays_110])

# Calculate the total number of expected decays in the time interval.
def total_decays_in_interval(nnuclei, t0, t1):
    return np.sum(calculate_decays_in_interval(nnuclei, t0, t1))

# Draws a random number of decays in time period dt,
# given the previous number of nuclei, nnuclei.
# A random number generator is passed along too
def decay(nnuclei, dt, rng):
    expected_decays = calculate_decays_in_interval(nnuclei, 0, dt)
    ndecays = np.zeros(2, dtype=int)
    if expected_decays[0] > 0:
        ndecays[0] = rng.poisson(expected_decays[0])
    if expected_decays[1] > 0:
        ndecays[1] = rng.poisson(expected_decays[1])
    return ndecays
