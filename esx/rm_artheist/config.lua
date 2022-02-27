Config = {}
Config['ArtHeist'] = {
    ['nextRob'] = 1800, -- seconds for next heist
    ['startHeist'] ={ -- heist start coords
        pos = vector3(244.346, 374.012, 105.738),
        peds = {
            {pos = vector3(244.346, 374.012, 105.738), heading = 156.39, ped = 's_m_m_highsec_01'},
            {pos = vector3(243.487, 372.176, 105.738), heading = 265.63, ped = 's_m_m_highsec_02'},
            {pos = vector3(245.074, 372.730, 105.738), heading = 73.3, ped = 's_m_m_fiboffice_02'}
        }
    },
    ['sellPainting'] ={ -- sell painting coords
        pos = vector3(288.558, -2981.1, 5.90696),
        peds = {
            {pos = vector3(288.558, -2981.1, 5.90696), heading = 135.88, ped = 's_m_m_highsec_01'},
            {pos = vector3(287.190, -2980.9, 5.72252), heading = 218.0, ped = 's_m_m_highsec_02'},
            {pos = vector3(287.731, -2982.6, 5.82852), heading = 336.08, ped = 's_m_m_fiboffice_02'}
        }
    },
    ['painting'] = {
        {
            rewardItem = 'paintinge', -- u need add item to database
            paintingPrice = '3', -- price of the reward item for sell
            scenePos = vector3(1400.486, 1164.55, 113.4136), -- animation coords
            sceneRot = vector3(0.0, 0.0, -90.0), -- animation rotation
            object = 'ch_prop_vault_painting_01e', -- object (https://mwojtasik.dev/tools/gtav/objects/search?name=ch_prop_vault_painting_01)
            objectPos = vector3(1400.946, 1164.55, 114.5336), -- object spawn coords
            objHeading = 270.0 -- object spawn heading
        },
        {
            rewardItem = 'paintingi',
            paintingPrice = '3', 
            scenePos = vector3(1408.175, 1144.014, 113.4136), 
            sceneRot = vector3(0.0, 0.0, 180.0),
            object = 'ch_prop_vault_painting_01i', 
            objectPos = vector3(1408.175, 1143.564, 114.5336), 
            objHeading = 180.0
        },
        {
            rewardItem = 'paintingh',
            paintingPrice = '3', 
            scenePos = vector3(1407.637, 1150.74, 113.4136), 
            sceneRot = vector3(0.0, 0.0, 0.0),
            object = 'ch_prop_vault_painting_01h', 
            objectPos = vector3(1407.637, 1151.17, 114.5336), 
            objHeading = 0.0
        },
        {
            rewardItem = 'paintingj',
            paintingPrice = '3', 
            scenePos = vector3(1408.637, 1150.74, 113.4136), 
            sceneRot = vector3(0.0, 0.0, 0.0),
            object = 'ch_prop_vault_painting_01j', 
            objectPos = vector3(1408.637, 1151.17, 114.5336), 
            objHeading = 0.0
        },
        {
            rewardItem = 'paintingf',
            paintingPrice = '3', 
            scenePos = vector3(1397.586, 1165.579, 113.4136), 
            sceneRot = vector3(0.0, 0.0, 90.0),
            object = 'ch_prop_vault_painting_01f', 
            objectPos = vector3(1397.136, 1165.579, 114.5336), 
            objHeading = 90.0
        },
        {
            rewardItem = 'paintingg',
            paintingPrice = '3', 
            scenePos = vector3(1397.976, 1165.679, 113.4136), 
            sceneRot = vector3(0.0, 0.0, 0.0),
            object = 'ch_prop_vault_painting_01g', 
            objectPos = vector3(1397.936, 1166.079, 114.5336), 
            objHeading = 0.0
        },
    },
    ['objects'] = { -- dont change (required)
        'hei_p_m_bag_var22_arm_s',
        'w_me_switchblade'
    },
    ['animations'] = { -- dont change (required)
        {"top_left_enter", "top_left_enter_ch_prop_ch_sec_cabinet_02a", "top_left_enter_ch_prop_vault_painting_01a", "top_left_enter_hei_p_m_bag_var22_arm_s", "top_left_enter_w_me_switchblade"},
        {"cutting_top_left_idle", "cutting_top_left_idle_ch_prop_ch_sec_cabinet_02a", "cutting_top_left_idle_ch_prop_vault_painting_01a", "cutting_top_left_idle_hei_p_m_bag_var22_arm_s", "cutting_top_left_idle_w_me_switchblade"},
        {"cutting_top_left_to_right", "cutting_top_left_to_right_ch_prop_ch_sec_cabinet_02a", "cutting_top_left_to_right_ch_prop_vault_painting_01a", "cutting_top_left_to_right_hei_p_m_bag_var22_arm_s", "cutting_top_left_to_right_w_me_switchblade"},
        {"cutting_top_right_idle", "_cutting_top_right_idle_ch_prop_ch_sec_cabinet_02a", "cutting_top_right_idle_ch_prop_vault_painting_01a", "cutting_top_right_idle_hei_p_m_bag_var22_arm_s", "cutting_top_right_idle_w_me_switchblade"},
        {"cutting_right_top_to_bottom", "cutting_right_top_to_bottom_ch_prop_ch_sec_cabinet_02a", "cutting_right_top_to_bottom_ch_prop_vault_painting_01a", "cutting_right_top_to_bottom_hei_p_m_bag_var22_arm_s", "cutting_right_top_to_bottom_w_me_switchblade"},
        {"cutting_bottom_right_idle", "cutting_bottom_right_idle_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_right_idle_ch_prop_vault_painting_01a", "cutting_bottom_right_idle_hei_p_m_bag_var22_arm_s", "cutting_bottom_right_idle_w_me_switchblade"},
        {"cutting_bottom_right_to_left", "cutting_bottom_right_to_left_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_right_to_left_ch_prop_vault_painting_01a", "cutting_bottom_right_to_left_hei_p_m_bag_var22_arm_s", "cutting_bottom_right_to_left_w_me_switchblade"},
        {"cutting_bottom_left_idle", "cutting_bottom_left_idle_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_left_idle_ch_prop_vault_painting_01a", "cutting_bottom_left_idle_hei_p_m_bag_var22_arm_s", "cutting_bottom_left_idle_w_me_switchblade"},
        {"cutting_left_top_to_bottom", "cutting_left_top_to_bottom_ch_prop_ch_sec_cabinet_02a", "cutting_left_top_to_bottom_ch_prop_vault_painting_01a", "cutting_left_top_to_bottom_hei_p_m_bag_var22_arm_s", "cutting_left_top_to_bottom_w_me_switchblade"},
        {"with_painting_exit", "with_painting_exit_ch_prop_ch_sec_cabinet_02a", "with_painting_exit_ch_prop_vault_painting_01a", "with_painting_exit_hei_p_m_bag_var22_arm_s", "with_painting_exit_w_me_switchblade"},
    },
}

Strings = {
    ['steal_blip'] = 'Madrazo Mansion',
    ['sell_blip'] = 'Painting Customers',
    ['start_stealing'] = 'Press ~INPUT_CONTEXT~ to stealing',
    ['cute_right'] = 'Press ~INPUT_CONTEXT~ to cut right',
    ['cute_left'] = 'Press ~INPUT_CONTEXT~ to cut left',
    ['cute_down'] = 'Press ~INPUT_CONTEXT~ to cut down',
    ['go_steal'] = 'Go to Madrazo Mansion and steal painting.',
    ['go_sell'] = 'Go to blip and sell painting.',
    ['already_cuting'] = 'You already stealing.',
    ['already_heist'] = 'You already start heist. Wait until its over.',
    ['start_heist'] = 'Press ~INPUT_CONTEXT~ to start heist',
    ['sell_painting'] = 'Press ~INPUT_CONTEXT~ to sell painting',
    ['wait_nextrob'] = 'You have to wait this long to undress again',
    ['minute'] = 'Minute',
    ['police_alert'] = 'Art stealing alert! Check your gps.',
}