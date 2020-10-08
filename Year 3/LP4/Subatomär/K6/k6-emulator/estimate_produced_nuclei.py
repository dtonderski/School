# Isak Svensson, March 2020.
# Quick and dirty Bayesian estimation of
# the initial number of nuclei of the two
# active isotopes in the silver plate in lab K6.

import physics

import emcee
import numpy as np

# Posterior specification
# Simple chi2 likelihood
def lnlikelihood(nnuclei, data, err, intervals):
    intensities = []
    for interval in intervals:
        t0 = interval[0]
        t1 = interval[1]
        interval_length = (t1-t0) / 60
        ndecays = physics.total_decays_in_interval(nnuclei, t0, t1)
        intensity = ndecays / interval_length
        intensities.append(intensity)
    intensities = np.array(intensities)
    return -0.5 * np.sum((intensities-data)**2/err**2)

# We definitely need a prior here, otherwise the estimation will go crazy.
# This expresses a priori expectations about the isotopic abundance based
# on cross sections, half-lifes, activation times, etc.
def lnprior(nnuclei):
    # The number of nuclei cannot be negative.
    if (nnuclei < 0).any():
        return np.NINF

    # Calculate total number of radioactive nuclei
    nnuclei_tot = np.sum(nnuclei)

    # So handwavy my hand might fall off. This heavily affects
    # the estimation for the short activations, due to the
    # pitiful amount of data available. It has little effect on
    # the estimation for the long activation.
    frac_110 = nnuclei[1] / nnuclei_tot
    expectation = 0.7
    return -0.5*(frac_110-expectation)**2/0.10**2

# Bayes' theorem, ignoring the irrelevant denominator
def lnposterior(nnuclei, data, err, intervals):
    return lnprior(nnuclei) + lnlikelihood(nnuclei, data, err, intervals)

def sanity_check(estimates, t0, t1):
    ndecays_tot = physics.total_decays_in_interval(estimates, t0, t1)
    ndecays_tot = int(round(ndecays_tot))
    print(f'[Sanity check] Total decays between {t0}-{t1} s: {ndecays_tot}')

def estimate(setup, intervals):
    raw_data = np.loadtxt(f'dat/{setups[i]}.dat')
    data = np.mean(raw_data, axis=0)
    err = np.std(raw_data, axis=0)

    # Sampling parameters
    ndim, nwalkers = 2, 20
    guess = np.array([5000, 5000])
    p0 = guess/100 * np.random.randn(nwalkers, ndim) + guess
    nsamples = 5000

    # Do the sampling
    lnposterior_args = [data, err, intervals]
    sampler = emcee.EnsembleSampler(nwalkers, ndim, lnposterior, args=lnposterior_args)
    sampler.run_mcmc(p0, nsamples)

    # Burn-in and flatten chain
    nburn = nsamples // 2
    chain = sampler.chain[:, nburn:, :]
    chain = chain.reshape((nwalkers*(nsamples-nburn), -1))

    # Estimate the number of nuclei as the median of the Markov chain
    estimates = np.median(chain, axis=0)
    estimates = [int(round(estimates[i])) for i in range(len(estimates))]
    estimates = np.array(estimates)
    nnuclei_tot = np.sum(estimates)

    # Print result
    print('Estimated initial number of nuclei:')
    print(f'Ag108: {estimates[0]} ({100*estimates[0]/nnuclei_tot:.0f}%)')
    print(f'Ag110: {estimates[1]} ({100*estimates[1]/nnuclei_tot:.0f}%)')
    print(f'Total: {nnuclei_tot}')

    # Sanity checks
    sanity_check(estimates, 30, 60)
    sanity_check(estimates, 30, 40)
    sanity_check(estimates, 310, 330)


setups = ['equilibrium', 'pos1_no_cd', 'pos2_no_cd', 'pos3_no_cd', 'pos2_cd', 'pos3_cd']
setups_nice = ['Equilibrium', 'Position 1, no Cd cover', 'Position 2, no Cd cover', 'Position 3, no Cd cover', 'Position 2 with Cd cover', 'Position 3 with Cd cover']

# I heard you like lists, so I made a list of lists of lists
intervals_list = [[[30, 60]] for i in range(len(setups))]
intervals_list[0] = [[30,40], [50,60], # 0
                     [70,80], [90,100], [110,120], # 1
                     [130,140], [150,160], [170,180], # 2
                     [190,200], [210,220], [230,240], # 3
                     [250,270], [280,300], # 4
                     [310,330], [340,360], # 5
                     [370,390], [400,420], # 6
                     [430,450], [460,480], # 7
                     [490,510], [520,540], # 8
                     [550,570], [580,600], # 9
                     [610,660], # 10
                     [670,720], # 11
                     [730,780]] # 12

for i in range(len(setups)):
    if i > 0:
        print('')
    print(setups_nice[i])
    estimate(setups[i], intervals_list[i])
