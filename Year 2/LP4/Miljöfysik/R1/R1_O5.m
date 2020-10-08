material    = ["Al",    "SiHp",     "SiKr",     "SiHn",     "ITO"]      
density     = [2.7,     2.3*0.97,   2.33,       2.3*0.97,   7.6  ].*10^3
energy      = [720,     2650+3200,  3400,       2650+3200,  2200 ].*10^6
thickness   = [1e-3,    20e-9,      130e-6,     10e-9,      100e-9]
tot_energy  = sum(density.*energy.*thickness);
syms x
col_energy  = 290*x*3600*24*0.21
solve(col_energy == tot_energy)