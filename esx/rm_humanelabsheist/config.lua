Config = {}

Config['HumaneLabs'] = {
    ['requiredPoliceCount'] = 4, -- required police count for start heist
    ['nextRob'] = 3600, -- seconds for next heist,
    ['rewards'] = {
        ['money'] = 0,
        ['blackMoney'] = math.random(200, 500),
        ['items'] = { -- you can disable this, just make ['items'] = nil
            { name = 'mutagens', count = function() return math.random(1, 3) end},
            -- { name = 'diamond', count = function() return math.random(1, 5) end}
        }
    },
    ['minigameDifficulty'] = {
        ['selected'] = 'easy',
        ['difficultys'] = {
            ['easy'] = 0.035, --distance between gascutter and point axis
            ['medium'] = 0.025,
            ['hard'] = 0.015,
        }
    },
    ['startHeist'] ={ -- heist start coords
        pos = vector3(-928.97, -2961.9, 13.9450),
        peds = {
            {pos = vector3(-928.31, -2962.0, 13.9450), heading = 110.22, ped = 's_m_m_highsec_01'},
            {pos = vector3(-929.49, -2961.4, 13.9450), heading = 200.78, ped = 's_m_m_highsec_02'},
            {pos = vector3(-929.22, -2962.7, 13.9450), heading = 5.42, ped = 's_m_m_fiboffice_02'}
        }
    },
    ['middleHeist'] = {
        peds = {
            {pos = vector3(3524.77, 3699.09, 19.992), heading = 85.22, ped = 's_m_m_scientist_01'},
            {pos = vector3(3540.53, 3675.759, 19.9944), heading = 176.22, ped = 's_m_m_scientist_01'},
            {pos = vector3(3536.98, 3663.102, 27.123), heading = 164.22, ped = 's_m_m_scientist_01'},
            {pos = vector3(3538.283, 3663.785, 27.123), heading = 164.22, ped = 's_m_m_scientist_01'},
            {pos = vector3(3560.043, 3671.964, 27.123), heading = 3.22, ped = 's_m_m_scientist_01'},
            {pos = vector3(3560.96, 3681.62, 27.123), heading = 172.22, ped = 's_m_m_scientist_01'},
            
            {pos = vector3(3538.41, 3647.17, 27.1218), heading = 80.22, ped = 's_m_m_chemsec_01'},
            {pos = vector3(3537.95, 3645.37, 27.1218), heading = 80.22, ped = 's_m_m_chemsec_01'},
            {pos = vector3(3548.88, 3657.83, 27.1218), heading = 170.22, ped = 's_m_m_chemsec_01'},
            {pos = vector3(3551.43, 3657.55, 27.1218), heading = 170.22, ped = 's_m_m_chemsec_01'},
            {pos = vector3(3566.14, 3697.27, 27.1214), heading = 170.22, ped = 's_m_m_chemsec_01'},
            {pos = vector3(3568.48, 3696.83, 27.1218), heading = 170.22, ped = 's_m_m_chemsec_01'},
            {pos = vector3(3596.26, 3689.52, 27.8214), heading = 145.22, ped = 's_m_m_chemsec_01'},
            {pos = vector3(3597.68, 3688.54, 27.8217), heading = 145.22, ped = 's_m_m_chemsec_01'},
            {pos = vector3(3590.64, 3710.48, 28.6894), heading = 170.22, ped = 's_m_m_chemsec_01'},
            {pos = vector3(3592.83, 3710.43, 28.6894), heading = 170.22, ped = 's_m_m_chemsec_01'},
            {pos = vector3(3611.02, 3722.03, 28.6894), heading = 150.22, ped = 's_m_m_chemsec_01'},
            {pos = vector3(3613.17, 3720.74, 28.6894), heading = 150.22, ped = 's_m_m_chemsec_01'},
            {pos = vector3(3620.45, 3743.62, 27.6900), heading = 150.22, ped = 's_m_m_chemsec_01'},
            {pos = vector3(3626.30, 3736.96, 27.6900), heading = 50.22, ped = 's_m_m_chemsec_01'},
            {pos = vector3(3609.05, 3740.89, 27.6900), heading = 240.22, ped = 's_m_m_chemsec_01'},
            {pos = vector3(3611.10, 3744.44, 27.6900), heading = 240.22, ped = 's_m_m_chemsec_01'},
        }
    },
    ['actions'] = {
        ['start_cutting'] = vector3(3832.896, 3665.742, -23.9975),
        ['take_chemical'] = vector3(3558.75, 3669.71, 28.1218),
        ['put_chemical'] = vector3(3638.326, 3771.813, 28.93),
    },
    ['elevator'] = {
        enter = vector3(3540.54, 3675.56, 19.9918),
        exit = vector3(3540.49, 3675.52, 27.1292),
    },
    ['wetsuit'] = {
        itemName = 'oxygen_mask',
        divingTime = 600,
    }
}

Strings = {
    ['start_heist'] = 'Press ~INPUT_CONTEXT~ to Start Humane Labs. Heist',
    ['finish_heist'] = 'Press ~INPUT_CONTEXT~ to Finish Humane Labs. Heist',
    ['go_diving'] = 'Go to the location in GPS. Wear wetsuit and diving. Break the grill and enter Humane Lab.',
    ['wait_nextrob'] = 'You have to wait this long to undress again',
    ['minute'] = 'minute.',
    ['elevator'] = 'Press ~INPUT_CONTEXT~ to go upstairs.',
    ['go_tunnel'] = 'Follow the tunnel and go inside.',
    ['put_chemical'] = 'Go to exit and put the chemical to container. Be careful!',
    ['end'] = 'Helicopter will receive the chemical. Go back to where you got the job and get your reward.',
    ['tunnel_blip'] = 'Cut the grill',
    ['finish_blip'] = 'Finish the heist',
    ['take_blip'] = 'Take the chemical',
    ['put_blip'] = 'Put the chemical',
    ['police_alert'] = 'Humane Labs. Heist alert! Check your gps.',
    ['need_police'] = 'Not enough police in the city.',
    ['minigame_info'] = '~INPUT_WEAPON_WHEEL_PREV~ Up ~INPUT_WEAPON_WHEEL_NEXT~ Down ~INPUT_ATTACK~ Left ~INPUT_AIM~ Right'
}

--Dont change. Main and required things.
Chemical_1 = {
    ['objects'] = {
        'prop_cs_vial_01',
        'p_chem_vial_02b_s',
    },
    ['animations'] = {
        {'take_chemical_player0', 'take_chemical_tube', 'take_chemical_vial'}
    },
    ['scenes'] = {

    },
    ['sceneObjects'] = {

    }
}

Chemical_2 = {
    ['objects'] = {
        'prop_cs_vial_01',
        'p_chem_vial_02b_s',
    },
    ['animations'] = {
        {'put_in_vial_player0', 'put_in_vial_tube', 'put_in_vial_vial'}
    },
    ['scenes'] = {

    },
    ['sceneObjects'] = {

    }
}

minigameTable = {
    -- upper
    {lightPos = vector3(3833.42, 3665.39, -22.11), particlePos = vector3(-0.645, -0.03, 0.90), particleType = 'horizontal', axis = {0.215, 0.92}, crack = false},
    {lightPos = vector3(3833.20, 3665.51, -22.11), particlePos = vector3(-0.375, -0.03, 0.90), particleType = 'horizontal', axis = {0.355, 0.92}, crack = false},
    {lightPos = vector3(3832.98, 3665.64, -22.11), particlePos = vector3(-0.125, -0.03, 0.90), particleType = 'horizontal', axis = {0.465, 0.92}, crack = false},
    {lightPos = vector3(3832.76, 3665.77, -22.11), particlePos = vector3(0.125, -0.03, 0.90), particleType = 'horizontal', axis = {0.59, 0.92}, crack = false},
    {lightPos = vector3(3832.54, 3665.90, -22.11), particlePos = vector3(0.375, -0.03, 0.90), particleType = 'horizontal', axis = {0.715, 0.92}, crack = false},
    {lightPos = vector3(3832.32, 3666.03, -22.11), particlePos = vector3(0.625, -0.03, 0.90), particleType = 'horizontal', axis = {0.83, 0.92}, crack = false},

    -- left
    {lightPos = vector3(3833.57, 3665.35, -22.230), particlePos = vector3(-0.775, -0.03, 0.77), particleType = 'vertical', axis = {0.145, 0.88}, crack = false},
    {lightPos = vector3(3833.57, 3665.35, -22.489), particlePos = vector3(-0.775, -0.03, 0.52), particleType = 'vertical', axis = {0.145, 0.74}, crack = false},
    {lightPos = vector3(3833.57, 3665.35, -22.748), particlePos = vector3(-0.775, -0.03, 0.27), particleType = 'vertical', axis = {0.145, 0.62}, crack = false},
    {lightPos = vector3(3833.57, 3665.35, -23.007), particlePos = vector3(-0.775, -0.03, 0.02), particleType = 'vertical', axis = {0.145, 0.5}, crack = false},
    {lightPos = vector3(3833.57, 3665.35, -23.266), particlePos = vector3(-0.775, -0.03, -0.25), particleType = 'vertical', axis = {0.145, 0.375}, crack = false},
    {lightPos = vector3(3833.57, 3665.35, -23.525), particlePos = vector3(-0.775, -0.03, -0.52), particleType = 'vertical', axis = {0.145, 0.24}, crack = false},
    {lightPos = vector3(3833.57, 3665.35, -23.784), particlePos = vector3(-0.775, -0.03, -0.77), particleType = 'vertical', axis = {0.145, 0.12}, crack = false},
    
    -- bottom
    {lightPos = vector3(3833.42, 3665.39, -23.900), particlePos = vector3(-0.645, -0.03, -0.90), particleType = 'horizontal', axis = {0.215, 0.065}, crack = false},
    {lightPos = vector3(3833.20, 3665.51, -23.900), particlePos = vector3(-0.375, -0.03, -0.90), particleType = 'horizontal', axis = {0.355, 0.065}, crack = false},
    {lightPos = vector3(3832.98, 3665.64, -23.900), particlePos = vector3(-0.125, -0.03, -0.90), particleType = 'horizontal', axis = {0.465, 0.065}, crack = false},
    {lightPos = vector3(3832.76, 3665.77, -23.900), particlePos = vector3(0.125, -0.03, -0.90), particleType = 'horizontal', axis = {0.59, 0.065}, crack = false},
    {lightPos = vector3(3832.54, 3665.90, -23.900), particlePos = vector3(0.375, -0.03, -0.90), particleType = 'horizontal', axis = {0.715, 0.065}, crack = false},
    {lightPos = vector3(3832.32, 3666.03, -23.900), particlePos = vector3(0.625, -0.03, -0.90), particleType = 'horizontal', axis = {0.83, 0.065}, crack = false},
    
    -- right
    {lightPos = vector3(3832.21, 3666.14, -22.230), particlePos = vector3(0.775, -0.03, 0.77), particleType = 'vertical', axis = {0.895, 0.88}, crack = false},
    {lightPos = vector3(3832.21, 3666.14, -22.489), particlePos = vector3(0.775, -0.03, 0.52), particleType = 'vertical', axis = {0.895, 0.74}, crack = false},
    {lightPos = vector3(3832.21, 3666.14, -22.748), particlePos = vector3(0.775, -0.03, 0.27), particleType = 'vertical', axis = {0.895, 0.62}, crack = false},
    {lightPos = vector3(3832.21, 3666.14, -23.007), particlePos = vector3(0.775, -0.03, 0.02), particleType = 'vertical', axis = {0.895, 0.5}, crack = false},
    {lightPos = vector3(3832.21, 3666.14, -23.266), particlePos = vector3(0.775, -0.03, -0.25), particleType = 'vertical', axis = {0.895, 0.375}, crack = false},
    {lightPos = vector3(3832.21, 3666.14, -23.525), particlePos = vector3(0.775, -0.03, -0.52), particleType = 'vertical', axis = {0.895, 0.24}, crack = false},
    {lightPos = vector3(3832.21, 3666.14, -23.784), particlePos = vector3(0.775, -0.03, -0.77), particleType = 'vertical', axis = {0.895, 0.12}, crack = false},
}