Config = {}

Config['PacificHeist'] = {
    ['requiredPoliceCount'] = 7, -- Required police count for start heist
    ['nextRob'] = 7200, -- Seconds for next heist
    ['requiredItems'] = { -- Add this items to database or shared. Don't change the order, you can change the item names
        'drill',
        'bag',
        'pliers',
        'c4_bank',
        'thermal_charge',
        'laptop_h',
        'flashDrive'
    },
    ['rewardItems'] = { -- Add this items to database or shared. Don't change the order, you can change the item names. Also dont forget glass cutting and painting item names.(in bottom)
        {itemName = 'gold', sellPrice = 10},
        {itemName = 'diamond', sellPrice = 5},
        {itemName = 'coke', sellPrice = 3},
    },
    ['drillReward'] = function()
        local random = math.random(1, 3)
        return Config['PacificHeist']['rewardItems'][random]['itemName'], 5
    end,
    ['trollyMoneyReward'] = 10, -- This is the amount of money per roll
    ['stackRewards'] = { -- This is stacks rewards. (not trolly) You can just change count(after =).
        gold = 2,
        money = 25
    },
    ['black_money'] = false, -- If change true, all moneys will convert to black
    ['startHeist'] ={ -- heist start coords
        pos = vector3(-622.70, 328.733, 85.3010),
        peds = {
            {pos = vector3(-622.70, 328.733, 85.2510), heading = 315.22, ped = 's_m_m_highsec_01'},
            {pos = vector3(-621.71, 328.410, 85.2510), heading = 23.78, ped = 's_m_m_highsec_02'},
            {pos = vector3(-622.89, 329.701, 85.2510), heading = 228.42, ped = 's_m_m_fiboffice_02'}
        }
    },
    ['finishHeist'] = {
        buyerPos = vector3(-1228.0, -662.41, 39.3575)
    }
}

Config['PacificSetup'] = {
    ['freezeDoorList'] = { -- dont change
        {model = -222270721,  pos = vector3(257.10, 220.30, 106.28), heading = 340.0, lock = true, action = 'plant', scene = {pos = vector3(257.40, 220.20, 106.35), rot = vector3(0.0, 0.0, 336.48), ptfx = vector3(257.39, 221.20, 106.29)}}, -- pacific enter 1
        {model = 746855201,   pos = vector3(262.35, 223.00, 107.05), heading = 250.0, lock = true, action = 'plant', scene = {pos = vector3(261.75, 221.420, 106.35), rot = vector3(0.0, 0.0, 255.48), ptfx = vector3(261.80, 222.470, 106.283)}}, -- pacific enter 2
        {model = 615294389,   pos = vector3(257.572, 227.826, 101.683), lock = true, action = 'hacking', scene = nil}, -- extended enter
        {model = 2774049745, pos = vector3(256.764, 241.272, 101.693), heading = 160.0, lock = true, action = 'vault', scene = {pos = vector3(257.35, 240.312, 102.0), rot = vector3(0.0, 0.0, 340.0)}}, -- extended vault
        {model = 1008631277,  pos = vector3(262.804, 258.266, 101.709), lock = true, action = 'hacking', scene = nil}, -- extended secret
        {model = -1508355822, pos = vector3(252.72, 220.95, 101.68), heading = 160.0,   lock = true, action = 'plant', scene = {pos = vector3(252.95, 220.70, 101.76), rot = vector3(0.0, 0.0, 160.0), ptfx = vector3(252.985, 221.70, 101.72)}}, -- main vault gate 1
        {model = -1508355822, pos = vector3(261.01, 215.01, 101.68), heading = 250.0, lock = true, action = 'plant', scene = {pos = vector3(261.65, 215.60, 101.76), rot = vector3(0.0, 0.0, 252.0), ptfx = vector3(261.68, 216.63, 101.75)}}, -- main vault gate 2
        {model = 961976194,   pos = vector3(253.154, 228.344, 101.683), lock = true, action = 'vault', scene = nil}, -- main vault
    },
    ['cellGates'] = { -- extended vault inside
        {pos = vector3(260.399, 242.955, 101.801), rot = vector3(0.0, 0.0, 250.0), plant = false},
        {pos = vector3(262.399, 248.455, 101.801), rot = vector3(0.0, 0.0, 250.0), plant = false},
        {pos = vector3(264.409, 254.055, 101.801), rot = vector3(0.0, 0.0, 250.0), plant = false},
    
        {pos = vector3(255.205, 244.726, 101.801), rot = vector3(0.0, 0.0, 70.0), plant = false},
        {pos = vector3(257.205, 250.276, 101.801), rot = vector3(0.0, 0.0, 70.0), plant = false},
        {pos = vector3(259.225, 255.886, 101.801), rot = vector3(0.0, 0.0, 70.0), plant = false},
    },
    ['mainStack'] = {model = 'h4_prop_h4_cash_stack_01a', pos = vector3(264.265, 213.735, 101.531), heading = 250.0},
    ['drills'] = {
        {pos = vector3(258.267, 213.848, 101.883), rotation = vector3(0.0, 0.0, 160.0)},
        {pos = vector3(259.682, 218.327, 101.883), rotation = vector3(0.0, 0.0, 350.0)},
    },
    ['trollys'] = { -- you can add new trolly but dont change first 4 trolly because for this extended vault fixed trollys
        {model = 'ch_prop_diamond_trolly_01c', pos = vector3(266.334, 255.849, 101.691), heading = nil},
        {model = 'ch_prop_diamond_trolly_01c', pos = vector3(269.230, 254.744, 101.691), heading = nil},
        {model = 'ch_prop_diamond_trolly_01c', pos = vector3(268.085, 251.274, 101.723), heading = nil},
        {model = 'ch_prop_diamond_trolly_01c', pos = vector3(266.076, 252.015, 101.691), heading = nil},
        
        {model = 'ch_prop_ch_cash_trolly_01b',  pos = vector3(266.351, 215.192, 100.683), heading = 115.0},
        {model = 'ch_prop_gold_trolly_01a',     pos = vector3(265.107, 211.960, 100.683), heading = 35.0},
        {model = 'imp_prop_impexp_coke_trolly', pos = vector3(261.623, 213.510, 100.683), heading = 300.0},
        {model = 'ch_prop_diamond_trolly_01c',  pos = vector3(262.819, 216.429, 100.683), heading = 200.0},
    },
    ['stacks'] = {
        {model = 'h4_prop_h4_cash_stack_01a', pos = vector3(265.812, 241.233, 101.581), heading = 250.0},
        {model = 'h4_prop_h4_cash_stack_01a', pos = vector3(268.112, 247.533, 101.581), heading = 250.0},
        {model = 'h4_prop_h4_cash_stack_01a', pos = vector3(254.062, 258.454, 101.581), heading = 70.0},

        {model = 'h4_prop_h4_gold_stack_01a', pos = vector3(250.019, 247.602, 101.581), heading = 70.0},
        {model = 'h4_prop_h4_gold_stack_01a', pos = vector3(251.988, 252.979, 101.581), heading = 70.0},
    },
    ['glassCutting'] = {
        displayPos = vector3(263.925, 260.656, 100.633),
        displayHeading = 340.0,
        rewardPos = vector3(263.925, 260.656, 101.6721),
        rewardRot = vector3(360.0, 0.0, 70.0),
        rewards = {
            -- {
            --     object = {model = 'h4_prop_h4_diamond_01a', rot = -53.06},
            --     displayObj = {model = 'h4_prop_h4_diamond_disp_01a', rot = vector3(360.0, 0.0, 70.0)},
            --     item = 'vanDiamond',
            --     price = 3,
            -- },
            -- {
            --     object = {model = 'h4_prop_h4_art_pant_01a', rot = -53.06},
            --     displayObj = nil,
            --     item = 'vanPanther',
            --     price = 3,
            -- },
            -- {
            --     object = {model = 'h4_prop_h4_necklace_01a', rot = 340.06},
            --     displayObj = {model = 'h4_prop_h4_neck_disp_01a', rot = vector3(360.0, 0.0, 340.0)},
            --     item = 'vanNecklace',
            --     price = 3,
            -- },
            -- {
            --     object = {model = 'h4_prop_h4_t_bottle_02b', rot = 340.06},
            --     displayObj = nil,
            --     item = 'vanBottle',
            --     price = 1,
            -- },
            {
                object = {model = 'vw_prop_vw_pogo_gold_01a', rot = 340.06},
                displayObj = nil,
                item = 'vanPogo',
                price = 3,
            },
        }
    },
    ['painting'] = {
        {
            rewardItem = 'paintingg', -- u need add item to database
            paintingPrice = '3', -- price of the reward item for sell
            scenePos = vector3(266.575, 259.565, 101.663), -- animation coords
            sceneRot = vector3(0.0, 0.0, 250.0), -- animation rotation
            object = 'h4_prop_h4_painting_01e', -- object model
            objectPos = vector3(267.025, 259.545, 101.853), -- object spawn coords
            objHeading = 250.0 -- object spawn heading
        },
        {
            rewardItem = 'paintingf',
            paintingPrice = '3',
            scenePos = vector3(261.302, 261.792, 101.663),
            sceneRot = vector3(0.0, 0.0, 70.0),
            object = 'h4_prop_h4_painting_01f', 
            objectPos = vector3(260.842, 261.932, 101.853), 
            objHeading = 70.85
        },
    },
}

Strings = {
    ['e_start'] = 'Press ~INPUT_CONTEXT~ to Start Pacific Heist',
    ['start_heist'] = 'Go to Pacific Bank',
    ['start_heist2'] = 'Required things for robbery: Laptop, Hack USB, Cutter, C4 & Thermite, Bag, Drill',
    ['plant'] = 'Press ~INPUT_CONTEXT~ to plant thermite',
    ['plant_bomb'] = 'Press ~INPUT_CONTEXT~ to plant C4',
    ['detonate_bombs'] = 'Press ~INPUT_CONTEXT~ to detonate bombs',
    ['grab'] = 'Press ~INPUT_CONTEXT~ to grab',
    ['hacking'] = 'Press ~INPUT_CONTEXT~ to use hack usb',
    ['vault'] = 'Press ~INPUT_CONTEXT~ to open vault',
    ['drill'] = 'Press ~INPUT_CONTEXT~ to use drill',
    ['wait_nextrob'] = 'You have to wait this long to undress again',
    ['minute'] = 'minute.',
    ['start_stealing'] = 'Press ~INPUT_CONTEXT~ to stealing',
    ['cute_right'] = 'Press ~INPUT_CONTEXT~ to cut right',
    ['cute_left'] = 'Press ~INPUT_CONTEXT~ to cut left',
    ['cute_down'] = 'Press ~INPUT_CONTEXT~ to cut down',
    ['glass_cut'] = 'Press ~INPUT_CONTEXT~ to cut the glass',
    ['need_switchblade'] = 'You need the switchblade.',
    ['need_this'] = 'You need this: ',
    ['deliver_to_buyer'] = 'Deliver the loot to the buyer. Check gps.',
    ['buyer_blip'] = 'Buyer',
    ['need_police'] = 'Not enough police in the city.',
    ['total_money'] = 'You got this: ',
    ['police_alert'] = 'Pacific Bank robbery alert! Check your gps.',
}

--Dont change because those main and required things.
Planting = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s'
    },
    ['animations'] = {
        {'thermal_charge', 'bag_thermal_charge'}
    },
    ['scenes'] = {},
    ['sceneObjects'] = {}
}

LaptopAnimation = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s',
        'hei_prop_hst_laptop',
        'hei_prop_heist_card_hack_02'
    },
    ['animations'] = {
        {'hack_enter', 'hack_enter_bag', 'hack_enter_laptop', 'hack_enter_card'},
        {'hack_loop', 'hack_loop_bag', 'hack_loop_laptop', 'hack_loop_card'},
        {'hack_exit', 'hack_exit_bag', 'hack_exit_laptop', 'hack_exit_card'}
    },
    ['scenes'] = {},
    ['sceneObjects'] = {}
}

GrabCash = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s'
    },
    ['animations'] = {
        {'enter', 'enter_bag'},
        {'grab', 'grab_bag', 'grab_cash'},
        {'grab_idle', 'grab_idle_bag'},
        {'exit', 'exit_bag'},
    },
    ['scenes'] = {},
    ['scenesObjects'] = {}
}

TrollyAnimation = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s'
    },
    ['animations'] = {
        {'intro', 'bag_intro'},
        {'grab', 'bag_grab', 'cart_cash_dissapear'},
        {'exit', 'bag_exit'}
    },
    ['scenes'] = {},
    ['scenesObjects'] = {}
}

LaserDrill = {
    ['animations'] = {
        {'intro', 'bag_intro', 'intro_drill_bit'},
        {'drill_straight_start', 'bag_drill_straight_start', 'drill_straight_start_drill_bit'},
        {'drill_straight_end_idle', 'bag_drill_straight_idle', 'drill_straight_idle_drill_bit'},
        {'drill_straight_fail', 'bag_drill_straight_fail', 'drill_straight_fail_drill_bit'},
        {'drill_straight_end', 'bag_drill_straight_end', 'drill_straight_end_drill_bit'},
        {'exit', 'bag_exit', 'exit_drill_bit'},
    },
    ['scenes'] = {}
}

Overheat = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s',
        'h4_prop_h4_cutter_01a',
    },
    ['animations'] = {
        {'enter', 'enter_bag', 'enter_cutter', 'enter_glass_display'},
        {'idle', 'idle_bag', 'idle_cutter', 'idle_glass_display'},
        {'cutting_loop', 'cutting_loop_bag', 'cutting_loop_cutter', 'cutting_loop_glass_display'},
        {'overheat_react_01', 'overheat_react_01_bag', 'overheat_react_01_cutter', 'overheat_react_01_glass_display'},
        {'success', 'success_bag', 'success_cutter', 'success_glass_display_cut'},
    },
    ['scenes'] = {},
    ['sceneObjects'] = {},
}

ArtHeist = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s',
        'w_me_switchblade'
    },
    ['animations'] = { 
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
    ['scenes'] = {},
    ['sceneObjects'] = {}
}

HackKeypad = {
    ['animations'] = {
        {'action_var_01', 'action_var_01_ch_prop_ch_usb_drive01x', 'action_var_01_prop_phone_ing'},
        {'hack_loop_var_01', 'hack_loop_var_01_ch_prop_ch_usb_drive01x', 'hack_loop_var_01_prop_phone_ing'},
        {'success_react_exit_var_01', 'success_react_exit_var_01_ch_prop_ch_usb_drive01x', 'success_react_exit_var_01_prop_phone_ing'},
        {'fail_react', 'fail_react_ch_prop_ch_usb_drive01x', 'fail_react_prop_phone_ing'},
        {'reattempt', 'reattempt_ch_prop_ch_usb_drive01x', 'reattempt_prop_phone_ing'},
    },
    ['scenes'] = {}
}