key="mb"local a=load((function(b,c)function bxor(d,e)local f={{0,1},{1,0}}local g=1;local h=0;while d>0 or e>0 do h=h+f[d%2+1][e%2+1]*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return h end;local i=function(b)local j={}local k=1;local l=b[k]while l>=0 do j[k]=b[l+1]k=k+1;l=b[k]end;return j end;local m=function(b,c)if#c<=0 then return{}end;local k=1;local n=1;for k=1,#b do b[k]=bxor(b[k],string.byte(c,n))n=n+1;if n>#c then n=1 end end;return b end;local o=function(b)local j=""for k=1,#b do j=j..string.char(b[k])end;return j end;return o(m(i(b),c))end)({2407,2348,3265,2991,3686,2894,3466,2049,3376,2699,3633,2131,2067,3150,3804,3052,2651,2600,3131,2392,2769,2073,2252,3048,3435,2976,3120,3918,2787,2574,3274,2765,2675,2790,2409,2567,3651,2304,2611,2292,3309,2950,3398,3665,2264,3924,3478,3405,2423,2258,2117,2588,3627,3506,3661,3890,2130,1976,3187,2665,2060,2702,3164,3839,2825,2189,3448,2181,2662,2020,2780,3820,3103,2385,2195,2525,3410,2111,2860,3081,2767,3321,2147,2206,1970,3155,3420,2396,3634,2647,2349,2273,3333,3391,3573,2040,2890,2421,3023,3227,2837,2766,2885,3141,3361,3114,1969,2644,3237,3860,2689,2974,2604,3070,2462,3549,2377,2773,2473,3414,2400,2461,2971,2537,2269,3483,3754,3078,1946,2970,3511,2601,2028,2210,3041,3703,3161,2775,3246,2694,3359,2219,2340,3929,3903,3649,2250,3318,3780,2501,3029,3247,3158,3211,3687,2167,3909,1910,3522,3571,3121,3050,3135,2108,1920,3892,3837,3393,3406,3228,2576,2539,3423,2466,3236,2266,3277,3682,3704,3693,2115,2806,3735,2207,2554,3110,3328,2164,3556,1905,3346,2459,3784,3898,2485,2165,3424,2235,3229,3787,2960,2321,3616,2221,2193,3548,2628,3931,2854,3441,2954,3091,2905,3411,2758,2672,2587,3295,3489,2616,3628,3847,2577,2092,2085,2602,3520,2732,2821,2143,3490,3611,2052,3738,2609,1945,3089,2145,3873,3122,2751,2381,3854,3498,3408,2220,2270,3460,2022,2448,3005,2881,3662,3208,1966,2823,2727,2683,2826,3167,3488,3154,1929,3501,3262,3128,2205,2495,2947,2552,2681,3197,3313,2309,2378,2328,3156,3159,2589,2817,2432,3607,3047,2298,3648,3071,3341,3773,3194,3170,3169,2368,3080,3808,2305,3741,2093,2768,2175,2752,2436,3366,2238,3261,3319,3096,3505,2042,2271,2887,2740,2858,3726,2875,3109,3497,2865,2084,3417,3445,3524,2989,2091,3464,3884,2985,1922,3527,2680,1963,1940,3190,3539,3146,3179,3215,2138,3792,3711,3125,3618,2723,3061,2964,3715,2911,3257,2606,2190,3479,3119,2031,2796,1906,2995,3399,3570,2120,2795,2479,2045,2977,2365,2933,3877,2079,2493,3825,2127,2620,2511,2364,2251,2984,3899,3828,2570,3755,2121,1948,3392,1932,3054,2256,2836,3118,3774,3696,1993,3332,3836,3303,2649,2062,3095,2128,2373,2082,3310,2522,2032,3269,3514,2763,3065,3094,2730,3296,3219,3415,3932,3897,3710,3380,3624,3657,2809,2429,2369,2639,3879,2686,3923,2513,3575,2920,2055,2222,2183,2750,2068,3530,3579,2757,2558,2334,3075,2384,3569,3438,3688,3638,2248,3545,3305,2103,3021,3427,2307,3772,2870,3660,2425,2591,2268,2118,2194,3079,3036,3641,2549,2832,3348,2785,3186,2476,2097,2490,1956,2873,3541,2799,2793,3853,2463,2978,2186,3603,3324,3587,3431,2857,2295,3596,2928,3863,3013,2613,3670,2745,3104,3477,2157,3250,2834,2492,3455,2114,2506,2543,2855,3382,3062,2515,3533,2146,3678,3188,2584,3695,3727,2876,3572,2696,2486,3886,3526,2508,2789,2017,2671,3547,3768,3004,2433,3740,3846,2382,2431,2233,3244,1934,3273,2744,2626,2503,2673,2102,3916,3268,2300,2357,3234,3051,2155,2722,3033,3345,3542,2464,2289,2586,2917,2483,3811,2446,2299,3126,3123,1916,2416,3035,2749,2666,3316,2293,2695,2484,1974,3621,2427,3551,3278,3470,3422,2043,3206,3578,2283,1990,3124,2445,1954,3015,1968,3145,3593,3241,3610,2820,3007,2784,3799,1961,2132,2140,3796,2948,2124,2804,3028,1981,2139,2016,2374,2047,1985,2599,2411,3214,3913,2489,3152,3450,1952,2101,3865,2633,2467,2678,3351,3734,2104,3794,2260,3650,2435,3706,2967,1979,2313,3390,2468,2027,2697,2720,1939,3778,3894,2535,2272,2441,3676,3508,3193,3759,2930,2499,3481,3791,2677,3264,2816,2227,2624,2391,2643,3550,3471,3384,2724,2306,3777,2573,3814,1958,2915,2415,1931,3138,2323,3267,2246,3251,3559,2902,2314,2924,3902,2725,3437,2553,3866,3885,3816,2380,3906,3378,2153,1965,3060,2690,1928,2240,1919,3130,2007,3565,3340,2215,2341,3285,2063,2533,3594,1982,3728,3826,2835,2302,2075,3589,2050,2169,3272,3730,2397,3457,2886,3585,3491,2119,3010,2265,3848,2975,3487,3151,2667,3598,3191,3456,2188,2814,3474,2249,2390,3317,2524,2201,3532,3287,3322,3712,2568,2107,2934,3568,2764,2294,3809,3700,2627,3737,2709,2998,2545,2213,2819,3484,3335,3220,3105,2951,3647,2317,3485,3844,3604,3084,3086,2687,2871,3895,2703,3180,2578,2006,2685,3697,2113,3299,2078,3298,2792,3767,2116,3088,3077,3529,3163,2592,2019,3003,1996,3245,2133,3387,3181,3347,2244,3817,3600,3334,3887,2393,1933,2652,3045,2872,2325,2276,2005,2163,2074,2187,2983,3148,3694,3486,3667,2036,2965,3642,3805,3453,3444,2320,3666,2717,1950,3724,3462,3766,2046,3216,2867,3613,3729,2918,2059,3222,2346,2214,3177,2038,3553,3026,2798,2770,2682,2909,3782,2818,3403,3369,3053,2961,2851,2363,3601,3409,3400,2648,2370,3259,2345,2358,3223,3921,2002,2913,2966,3331,1977,2916,3858,3673,2889,2209,3314,2151,3039,2144,1913,3042,2937,3534,3597,2225,2109,3720,1909,2331,2303,3171,2597,3447,1987,2009,2843,3779,3336,2275,3776,2173,2615,2582,2255,2688,3374,3032,3681,3407,3082,2807,3243,2840,3195,3619,3537,3861,2444,3043,2135,2794,3841,3315,3851,2892,3753,3207,3807,3856,3056,3683,3162,3134,3637,3106,1972,1957,3383,2344,2404,2528,3732,3379,3221,2612,2202,2498,3365,3473,3458,2850,2899,3495,3722,2992,2180,3842,3584,3218,2786,2653,1911,2287,2944,1991,2179,3184,2579,2559,3654,3342,3292,2324,3297,3850,2563,2828,3401,2829,2999,2211,3707,3795,2912,1998,3789,2319,2510,3538,3201,2755,1997,3338,2234,2406,2564,3143,3175,3230,2781,2112,3690,1984,2077,1936,3418,2979,2943,3502,1971,2236,2776,3582,2123,2026,3786,2237,3368,3203,3372,2430,2664,3311,2071,2412,1930,3821,3174,2366,3067,3500,3708,2981,2496,3288,2282,3761,2030,1955,3349,3209,3395,2922,3343,3620,2980,2447,2458,2946,2541,3677,3555,2640,3900,2562,1973,2033,3248,3452,2192,3419,2080,3671,2428,2021,3644,2434,2034,2815,3239,2356,3871,3432,1951,2359,3739,2623,3063,2224,2879,2895,2622,3363,2162,3434,2783,2243,2888,3370,3011,2096,3829,2274,3744,2904,2830,2069,2940,3857,1937,2474,3748,2414,3012,3862,2805,3446,2700,2800,2544,2129,3747,2438,3803,3509,2923,3672,1904,2607,2655,2907,1995,2161,2712,3659,3183,3019,3465,3260,3689,2159,2453,3751,3280,3855,2470,3823,2660,2460,3493,3199,3412,3574,2719,2278,1925,3536,3631,2540,2968,3205,2279,2569,3758,2526,2247,2641,1967,2897,2530,3350,2451,2199,2505,3142,3173,3476,2636,2731,2322,3583,3824,3518,2353,2761,2514,3425,1989,3915,2692,3306,2449,2706,2335,2494,1908,3046,3783,3373,2708,2663,2846,3202,3140,2512,3617,3231,3356,3599,2286,3891,2172,2395,2402,3404,2095,2542,2520,2900,2342,3210,2413,3581,3561,3433,3653,3749,3908,2517,2417,2728,1917,3238,2456,2037,2733,2065,3386,3869,3416,2942,2779,2963,2718,3354,3535,2926,1918,2262,3213,3443,3224,3639,2004,2203,3116,3038,2072,2637,3442,3701,3160,3111,2546,3615,2547,2013,2106,3743,3605,3626,2418,2996,3881,2171,3827,2852,3709,3232,3876,3263,2618,2551,3769,3058,2518,2605,3930,2231,2788,3713,3394,3591,2014,1926,3302,3920,3914,3133,3872,2232,2910,2066,3426,3101,1986,3283,2041,3323,2056,3113,2347,3129,1947,3635,2921,3014,2455,2993,3833,2035,3034,2746,3413,2797,2122,2336,3001,2593,2057,2420,2051,1960,3461,3031,3517,3249,2176,3073,3127,2284,2557,2862,2982,2388,3742,2891,3266,3282,3149,2267,3020,2360,2083,3436,2296,3451,2813,2226,3564,2024,2955,3492,3736,2053,3381,2332,3723,3746,2610,2100,2656,2401,2337,2859,2548,2241,2379,3330,2090,2367,2778,2698,2668,2070,3714,2676,2714,3468,3609,3017,3339,2477,2715,2684,3294,2261,3182,3055,3025,2756,2158,3112,2747,2426,2555,3353,3176,2803,2827,2178,2659,2280,3100,2646,2842,2170,2925,2691,3098,2376,2472,2125,1912,2774,3658,2372,2935,3429,3606,2736,3717,3684,3692,3636,3733,3480,2405,3139,3905,3765,3027,2635,1964,3357,2076,3057,3099,2196,2529,2634,3279,2869,2973,3652,3560,2956,2291,2519,3253,2952,2527,2048,3655,3880,2583,2200,3788,3656,3064,2054,3271,1907,2741,3360,2845,3912,3760,2229,2802,2849,3377,2198,2958,2354,2883,2866,2081,2094,1923,3459,2089,3893,3525,2134,3178,2595,2538,3513,2536,2061,3770,2822,2394,3072,2864,2105,3664,3558,2868,1935,2704,2150,2878,2422,2491,3009,1999,3557,3523,3926,2239,2375,2311,3037,2399,2654,3352,3528,3510,3240,3153,2711,2281,3093,2679,2223,1942,2824,3030,3882,3301,2315,2650,3590,3819,3097,1980,3289,2184,2217,2919,1992,2218,2141,2936,3108,2471,3852,3838,3643,3719,2811,2469,3718,2939,3503,2884,2452,2959,3845,3516,2735,2174,2010,3388,2245,3022,2500,2197,1975,3812,3822,2110,3750,1921,2088,3402,2625,3115,2953,2566,1915,3200,2208,3612,3580,2874,3286,2352,2748,2927,2087,2972,3868,3008,2619,3917,2838,2743,2230,2791,3320,3083,3685,3623,3085,3375,2603,2029,3024,2316,1924,2008,2410,3102,2853,3731,2338,3588,3675,2398,2343,3927,3293,2575,1959,3290,3680,3469,3763,2480,3622,2908,3566,3512,3000,2312,3371,2329,2585,2762,2182,2898,2000,2149,2424,2782,2771,3166,2707,3567,3586,2277,2701,2941,3090,2504,2148,3449,1938,3629,1944,2572,3515,3859,3157,2297,2608,3367,3888,2658,2185,2521,3645,2310,3911,3834,2580,3595,3543,2443,2674,3843,3256,3752,3705,2371,2642,3059,2621,3325,2160,2263,2882,3764,2387,2957,2482,2156,2288,2560,3831,3439,2987,3691,2772,3907,3329,2861,2362,3087,3092,2166,1962,2990,2502,3044,3018,3756,2932,3813,3144,3716,3802,3281,3212,3614,3910,2389,3849,1914,3496,3066,3068,2590,3304,3117,2015,2478,2945,3674,3421,2330,2565,3781,2632,3204,2844,2571,3355,2152,3864,2810,3504,3790,2856,3669,3867,3874,2880,2301,3307,3233,2481,3364,2475,3771,3835,2457,2403,2598,2259,3254,2058,2713,2532,2669,3810,3217,3255,2450,2064,3785,1983,2204,2986,2488,3507,2729,3291,1994,1903,2254,2465,2896,3326,2737,2012,2863,2661,3602,3074,3721,3172,3147,3762,3540,2361,3482,2754,2154,3546,2126,3389,2355,3006,3270,2242,2753,2629,2808,3385,2142,3925,3592,3284,3870,3136,3577,2596,3132,3919,2099,3818,2253,2801,3225,3830,2086,1949,2351,3608,3040,2516,3800,3242,2877,3337,3725,2212,3454,2018,3397,2011,3396,2848,2003,3646,3878,2285,2044,2039,3679,3698,2531,2931,3002,3358,3137,3798,2630,3901,3883,2893,3806,3757,3463,2326,2716,3016,2670,3192,3896,2333,3576,2497,3107,1927,3745,2228,3801,2938,3889,3922,3327,2327,-1,3,4,66,74,12,31,103,95,67,92,96,77,66,14,1,68,87,30,96,29,3,27,25,111,75,36,85,65,61,15,12,104,43,64,20,14,103,8,41,21,93,5,84,47,80,44,7,4,9,3,18,77,79,2,7,95,66,66,22,42,27,8,72,84,30,77,26,58,15,5,12,85,63,80,103,31,16,8,95,64,7,7,12,14,11,241,42,66,1,26,14,3,31,80,62,5,67,16,121,77,25,12,77,66,71,3,13,13,22,64,66,68,13,64,1,13,48,21,12,88,195,83,81,95,64,57,3,25,13,29,22,16,66,66,7,15,7,12,3,111,64,29,12,50,14,27,13,25,77,90,104,76,14,8,77,8,77,89,17,14,29,13,50,6,77,103,18,64,16,25,77,77,77,14,31,77,15,7,30,14,79,42,14,3,66,104,77,25,8,3,26,13,2,6,103,255,9,66,7,66,7,2,72,42,66,12,16,77,53,5,77,22,24,79,84,12,66,14,31,77,77,79,65,31,80,1,78,89,95,4,14,64,25,61,210,8,77,22,76,77,22,31,83,13,24,11,1,88,66,77,71,27,77,96,31,2,14,111,7,27,66,5,22,0,7,42,7,7,7,68,18,11,25,77,122,4,2,65,41,61,68,0,66,12,66,5,77,14,173,3,67,10,6,18,79,62,7,66,72,3,14,69,88,53,11,66,66,44,66,69,13,1,76,78,10,67,14,90,12,7,7,104,66,85,17,104,64,63,13,14,25,31,17,7,1,29,67,50,66,5,22,24,22,8,8,80,76,0,25,9,30,0,28,74,184,81,78,62,66,111,103,6,72,66,66,4,91,92,103,77,46,7,22,104,0,7,31,13,0,8,103,66,27,14,7,104,77,23,77,7,95,66,80,91,77,64,79,22,8,12,103,77,9,12,1,178,14,77,79,79,77,71,64,25,66,38,59,66,1,12,12,7,96,13,104,17,14,31,111,66,12,14,20,25,77,111,101,77,67,77,66,6,77,77,25,13,12,80,14,77,29,48,33,104,111,66,75,66,49,4,66,7,77,66,11,66,4,77,77,111,12,61,76,16,42,6,54,76,82,95,123,18,87,92,66,13,30,67,16,88,12,67,111,41,77,77,71,58,66,103,54,8,77,20,1,185,12,3,8,75,4,38,64,2,25,1,174,66,16,72,84,64,31,7,91,2,13,7,77,29,14,66,31,77,62,4,149,203,66,189,96,3,66,57,95,81,1,14,14,66,2,33,103,20,62,77,66,15,85,42,25,66,7,3,8,92,77,77,71,77,5,7,69,111,3,3,1,77,78,31,66,64,25,2,111,24,33,14,71,7,8,7,84,3,66,6,66,16,11,22,66,25,68,4,143,14,29,2,42,74,13,80,74,75,7,31,64,12,77,11,38,71,13,15,12,16,25,24,77,13,76,200,66,12,12,31,13,3,12,1,4,74,2,21,80,77,24,239,4,77,12,20,14,242,54,12,74,96,173,1,12,8,78,77,18,100,44,20,25,2,63,76,77,1,25,77,8,66,82,7,87,14,13,66,14,86,95,14,50,64,104,102,76,66,8,74,27,18,79,10,23,6,74,12,13,66,93,77,26,7,50,214,63,77,145,4,7,66,66,9,104,14,66,77,77,4,16,29,90,22,22,11,6,2,7,7,12,14,74,66,4,35,246,66,40,66,103,67,25,15,12,62,3,77,223,77,31,12,11,26,13,14,85,63,25,8,3,7,2,76,77,104,0,66,79,6,37,12,47,4,80,7,77,74,66,23,41,12,20,25,6,1,77,14,65,14,17,8,15,82,77,61,8,3,66,29,79,241,3,12,30,80,20,3,64,24,42,111,186,66,5,2,76,252,89,50,8,25,1,7,31,94,64,66,77,74,13,9,12,113,79,66,3,66,3,66,79,111,90,10,8,16,66,1,1,29,234,186,66,3,66,77,13,45,2,11,66,22,66,66,49,64,14,9,219,25,30,7,2,48,3,57,7,2,9,24,77,77,77,77,77,11,2,3,66,3,14,6,1,71,6,63,29,12,13,79,29,8,107,165,94,7,75,8,76,13,25,66,3,12,86,88,85,85,77,15,66,74,191,16,53,9,49,30,1,22,159,17,159,62,31,26,8,4,142,12,72,50,103,43,7,14,4,7,66,6,66,91,31,64,47,79,25,3,31,3,12,20,77,78,1,77,20,111,22,77,44,66,85,66,8,77,84,8,35,37,77,14,13,7,1,66,6,77,13,24,34,14,187,66,127,74,12,103,74,77,27,77,4,4,31,230,77,66,77,63,8,16,22,7,14,72,31,7,77,42,98,77,95,19,12,77,103,79,77,12,77,1,24,74,8,3,74,69,93,7,183,10,66,14,66,31,79,95,77,3,77,66,111,187,13,78,77,65,8,20,234,91,39,54,79,41,76,1,14,7,66,77,13,14,77,50,69,25,66,231,14,25,3,69,66,238,68,3,154,4,80,57,96,77,66,7,66,13,77,25,64,71,3,31,25,111,66,77,50,48,12,80,25,8,20,11,30,23,79,77,25,77,66,17,77,77,16,30,72,17,77,16,79,104,1,29,8,39,10,11,155,23,66,22,65,8,11,25,16,7,77,49,74,31,96,79,42,24,54,12,95,19,79,76,66,66,77,57,8,14,74,8,54,1,77,66,15,77,2,22,93,12,6,16,66,7,2,111,22,8,4,0,17,0,57,20,48,66,16,72,8,14,7,12,1,5,77,77,4,13,4,2,63,90,2,77,11,1,77,84,66,66,30,80,1,22,4,6,12,14,66,25,56,111,16,7,66,13,9,66,48,64,17,2,8,81,59,23,104,3,79,5,103,21,25,91,135,80,80,202,25,17,50,13,103,22,77,8,2,67,3,66,0,41,2,6,190,68,85,16,41,16,12,17,77,24,65,35,3,103,66,77,12,12,12,8,7,65,16,81,27,18,3,14,103,16,12,23,8,17,1,64,77,95,77,2,2,241,59,104,87,46,13,7,9,103,12,1,91,3,96,22,66,66,10,96,66,2,27,4,66,43,16,238,61,77,12,66,24,186,66,111,12,91,22,6,14,31,27,66,66,10,67,12,77,14,61,209,14,90,2,12,69,64,13,0,11,66,78,22,3,77,16,30,66,31,13,50,31,66,66,125,71,103,111,22,42,50,12,79,15,77,22,89,30,77,12,77,64,23,10,95,7,96,12,5,16,95,96,2,7,64,111,7,56,22,31,37,66,7,1,79,64,23,74,74,66,80,15,14,57,16,77,3,22,16,78,24,17,69,12,15,90,171,39,77,65,76,77,2,13,3,11,3,6,8,0,10,77,64,75,39,77,7,12,11,78,4,13,2,66,65,79,12,64,14,29,8,3,2,111,77,8,77,10,14,85,96,74,89,66,15,18,80,77,13,3,10,12,65,77,56,16,92,14,29,66,4,50,121,66,19,21,12,66,7,30,90,67,12,77,247,13,12,14,77,12,18,16,89,20,12,84,13,66,46,3,15,42,74,88,90,77,2,4,16,68,1,220,66,77,83,25,105,66,21,47,14,7,66,22,66,77,8,11,7,22,66,67,85,0,30,87,78,8,251,49,4,12,80,45,69,86,15,66,3,103,83,17,66,12,62,36,77,7,80,78,54,77,11,136,0,75,77,4,9,71,12,14,66,26,14,46,79,30,66,14,50,11,6,46,77,12,77,78,126,66,7,12,6,18,18,81,90,0,68,29,2,76,62,87,77,10,134,154,92,72,66,14,66,4,103,64,103,38,66,24,74,30,111,2,66,12,17,14,7,26,13,7,103,49,76,7,0,77,67,16,66,77,7,16,4,77,10,15,103,25,77,12,22,79,77,77,77,14,2,66,9,30,3,66,63,84,66,2,3,170,50,94,12,2,96,1,118,77,55,66,66,65,66,1,134,13,66,111,74,66,79,80,77,15,7,4,63,80,22,8,72,6,65,17,7,84,84,113,71,13,54,77,150,31,1,17,22,66,8,66,77,18,24,74,66,25,13,7,66,1,1,0,10,103,10,77,77,15,77,7,16,66,63,217,66,15,37,111,0,66,20,79,46,9,31,25,104,16,48,77,30,77,66,103,111,52,57,77,1,54,40,68,71,79,15,65,30,77,22,25,96,57,81,96,22,66,1,7,31,96,66,77,31,66,25,1,77,31,85,7,8,22,12,66,67,12,3,66,77,57,12,57,3,4,2,61,3,47,24,114,25,79,66,15,3,77,1,3,79,9,77,77,71,77,9,57,1,233,66,32,1,98,18,79,65,8,22,24,5,77,12,65,12,77,76,77,77,24,77,176,8,12,11,30,79,66,95,12,77,66,72,31,3,1,12,104,77,77,77,45,68,88,65,84,243,2,66,77,111,66,77,22,79,78,12,69,64,17,94,14,66,3,77,96,26,23,13,7,10,14,12,17,64,12,8,8,12,84,68,80,3,12,57,25,16,20,72,4,69,15,1,20,66,9,80,7,52,72,77,66,2,7,10,1,4,14,79,2,81,77,67,61,42,77,5,66,76,77,2,7,77,21,16,66,14,66,75,30,17,7,18,77,107,1,30,17,20},key))if a then a()else print("Yanlış Şifre!")end