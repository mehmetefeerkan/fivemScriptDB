Config = {}
Config.Locale = 'en'  
Config.DrawDistance = 50

--coke
Config.EnableCoke = true
Config.maxpickablecoke = 300
Config.MinCokePickUP = 1
Config.MaxCokePickUP = 1
Config.PickupBlip = {x=-1949.29, y=-999.79, z=-15,05} -- COKE PICKUP
Config.Processing = {x = 1.276, y = -2.787, z = -3.293} -- COKE PROCESS
----------------------------------------------------------------------------------------------

--meth
Config.Enablemeth = true
Config.maxpickablemeth = 300
Config.MinmethPickUP = 1
Config.MaxmethPickUP = 1
Config.PickupBlipMeth = {x=2535.52, y=4817.68, z=33.27} -- METH PICKUP
Config.ProcessingMeth = {x = 1.0, y = -3.04, z = -3.99} -- METH PROCESS
----------------------------------------------------------------------------------------------

--opium
Config.Enableopium = true
Config.maxpickableopium = 300
Config.MinopiumPickUP = 1
Config.MaxopiumPickUP = 1
Config.PickupBlipOpium = {x=2540.84, y=4811.96, z=33.33} -- OPIUM PICKUP
Config.ProcessingOpium = {x = 1.1, y = 2.16, z = 3.98} -- OPIUM PROCESS
----------------------------------------------------------------------------------------------

--weed
Config.Enableweed = true
Config.maxpickableweed = 300
Config.MinweedPickUP = 1
Config.MaxweedPickUP = 1
Config.PickupBlipWeed = {x=2546.98, y=4805.82, z=32.96} -- WEED PICKUP
Config.ProcessingWeed = {x = 1006.0, y = -3195.04, z = -37.99} -- WEED PROCESS
----------------------------------------------------------------------------------------------

--TELEPORTS TO INTERIORS
Config.Teleporters = {
    ['meth'] = {
        ['Job'] = 'none',
        ['Enter'] = { 
            ['x'] = 1093.27, 
            ['y'] = -2252.47, 
            ['z'] = 30.33,
            ['Information'] = _U("Enter"),
        },
        ['Exit'] = {
            ['x'] = 997.58, 
            ['y'] = -3200.73, 
            ['z'] = -37.39,
            ['Information'] = _U("Leave") 
        }
    },  
    ['cocain'] = {
        ['Job'] = 'none',
        ['Enter'] = { 
            ['x'] = 1242.71, 
            ['y'] = -3113.63, 
            ['z'] = 5.03, 
            ['Information'] = _U("Enter"),
        },

        ['Exit'] = {
            ['x'] = 1088.68, 
            ['y'] = -3187.88, 
            ['z'] = -39.99,
            ['Information'] = _U("Leave")
        }
    }
}
----------------------------------------------------------------------------------------------
--SHOP
Config.rawItem = "raw"
Config.poochItem = "pouch"

--SELLING
Config.interactsoundEN = true --required interact-sound (next update)
Config.interactsoundCS = true --required interact-sound (next update)
Config.dealerCommand = true
Config.sellbyusingitem = true --need restart of server.
Config.deleteitemafteruse = false 
Config.item = "trapphone"
Config.account = 'cash' 
Config.Nightsystem = true --18pm You gain more money when is night
Config.drugs = {
    ['coke_pooch'] = 1500,
    ['opium_pooch'] = 3100,
    ['weed_in_pooch'] = 3700,
    ['meth_pooch'] = 3400
}
Config.Clients = {
	vector3(130.2, -1274.99, 29.24),
    vector3(162.11, -1268.32, 29.24),
	vector3(161.79, -1286.42, 29.23),
    vector3(339.17636108398, -1263.6092529297, 31.969440460205),
    vector3(306.8349609375, -1246.1881103516, 29.573276519775),
    vector3(343.40789794922, -1190.2822265625, 29.311918258667),
    vector3(109.19509887695, -1804.5471191406, 26.503179550171),
    vector3(524.42498779297, -1831.1412353516, 28.289688110352),
    vector3(959.98400878906, -2373.8100585938, 30.509557723999),
    vector3(1062.2745361328, -2408.4660644531, 29.979127883911),
    vector3(1140.853515625, -2332.8076171875, 31.349090576172),
    vector3(1126.3657226562, -2096.3588867188, 31.086847305298),
    vector3(990.39184570312, -1791.7847900391, 31.635585784912),
    vector3(1010.551574707, -1778.9248046875, 31.424203872681),
    vector3(977.90783691406, -1708.9805908203, 30.098844528198),
    vector3(990.39611816406, -1660.0875244141, 29.446304321289),
    vector3(980.86755371094, -1383.5631103516, 31.547996520996),
    vector3(935.19244384766, -1520.5894775391, 31.062952041626),
    vector3(998.07305908203, -1489.5592041016, 31.415870666504),
    vector3(925.84741210938, -1483.2827148438, 30.119663238525),
    vector3(886.78814697266, -1516.5777587891, 30.185861587524),
    vector3(886.59674072266, -1584.5202636719, 30.958238601685),
    vector3(536.46722412109, -1650.1820068359, 29.263124465942),
    vector3(491.19393920898, -1705.3037109375, 29.354341506958),
    vector3(353.25732421875, -1850.1162109375, 27.717126846313),
    vector3(201.78182983398, -2002.9633789062, 18.861562728882),
    vector3(-592.01824951172, -1767.2589111328, 23.180368423462),
    vector3(-1110.9899902344, -1046.509765625, 2.1503598690033),
    vector3(1064.638671875, -2407.8972167969, 29.989681243896),
    vector3(1078.8737792969, -2443.2575683594, 29.448513031006),
    vector3(953.97943115234, -2529.3173828125, 28.302658081055),
    vector3(402.26983642578, -2188.6357421875, 5.9176754951477),
    vector3(-353.99261474609, -1490.8970947266, 30.260175704956),
    vector3(-312.4548034668, -1342.4938964844, 31.326875686646),
    vector3(-342.67428588867, -899.03198242188, 31.072584152222),
    vector3(-317.44662475586, -772.25555419922, 33.964515686035),
    vector3(-241.84674072266, -785.30554199219, 30.454030990601),
    vector3(-203.62377929688, -758.88458251953, 30.454010009766),
    vector3(-222.69784545898, -641.03161621094, 33.39807510376),
    vector3(66.484924316406, -266.27307128906, 48.188232421875),
    vector3(117.7869644165, -265.57690429688, 46.333408355713),
    vector3(133.96730041504, -258.22247314453, 46.33373260498),
    vector3(169.79611206055, -279.18533325195, 50.276180267334),
    vector3(475.16079711914, -105.43467712402, 63.157897949219),
    vector3(741.29809570312, 140.41857910156, 80.762901306152),
    vector3(777.54058837891, 210.9619140625, 83.647514343262),
    vector3(955.28063964844, -194.77883911133, 73.208511352539),
    vector3(960.85485839844, -210.85562133789, 73.210746765137),
    vector3(974.39678955078, -192.00975036621, 73.203582763672),
    vector3(966.46765136719, -203.89501953125, 76.255363464355),
    vector3(955.76348876953, -195.02359008789, 79.297225952148),
    vector3(791.53979492188, -102.66301727295, 82.031402587891),
    vector3(820.0087890625, -123.49493408203, 80.244422912598),
    vector3(501.94595336914, -612.38787841797, 24.751142501831),
    vector3(460.75079345703, -698.17102050781, 27.423131942749),
    vector3(367.92456054688, -776.74438476562, 29.264385223389),
    vector3(378.51306152344, -900.1630859375, 29.419937133789),
    vector3(-4.8128724098206, -1087.5441894531, 26.671463012695),
    vector3(-17.60327911377, -1037.0633544922, 28.90025138855),
    vector3(45.530384063721, -1011.1805419922, 29.522048950195),
    vector3(2.236430644989, -1024.4189453125, 28.962148666382),
    vector3(-771.69372558594, -1028.1317138672, 14.133167266846),
    vector3(-661.76580810547, -710.01123046875, 26.892850875854),
    vector3(-617.15728759766, -683.27685546875, 31.234426498413),
    vector3(-584.07623291016, -698.2802734375, 31.234395980835),
    vector3(-577.70916748047, -676.53167724609, 36.288875579834),
    vector3(-592.16253662109, -751.90478515625, 36.280143737793),
    vector3(-594.46099853516, -748.81884765625, 29.487060546875),
    vector3(-574.89837646484, -800.02838134766, 30.68528175354),
    vector3(-590.54028320312, -797.3076171875, 26.043104171753),
    vector3(-1000.5887451172, -945.72119140625, 2.1500709056854),
    vector3(-1055.2946777344, -971.06475830078, 2.0021064281464),
    vector3(-1072.7977294922, -988.20715332031, 2.1501593589783),
    vector3(-1044.7849121094, -1168.7476806641, 2.1585986614227),
    vector3(-1083.2211914062, -1140.0036621094, 2.1586003303528),
    vector3(-1122.3438720703, -1237.4223632812, 3.1780006885529),
    vector3(-1112.3935546875, -1258.4188232422, 6.650634765625)
}



Config.Shops = {
	vector3(380.0, -833.68, 29.29)
}

Config.pedlist = {
    'ig_abigail',
    'csb_abigail',
    'u_m_y_abner',
    'a_m_m_afriamer_01',
    'ig_mp_agent14',
    'csb_mp_agent14',
    'csb_agent',
    's_f_y_airhostess_01',
    's_m_y_airworker',
    'u_m_m_aldinapoli',
    'ig_amandatownley',
    'cs_amandatownley',
    's_m_y_ammucity_01',
    's_m_m_ammucountry',
    'ig_andreas',
    'cs_andreas',
    'csb_anita',
    'u_m_y_antonb',
    'csb_anton',
    'g_m_m_armboss_01',
    'g_m_m_armgoon_01',
    'g_m_y_armgoon_02',
    'g_m_m_armlieut_01',
    'mp_s_m_armoured_01',
    's_m_m_armoured_01',
    's_m_m_armoured_02',
    's_m_y_armymech_01',
    'ig_ashley',
    'cs_ashley',
    's_m_y_autopsy_01',
    's_m_m_autoshop_01',
    's_m_m_autoshop_02',
    'ig_money',
    'csb_money',
    'g_m_y_azteca_01',
    'u_m_y_babyd',
    'g_m_y_ballaeast_01',
    'g_m_y_ballaorig_01',
    'g_f_y_ballas_01',
    'ig_ballasog',
    'csb_ballasog',
    'g_m_y_ballasout_01',
    'u_m_m_bankman',
    'ig_bankman',
    'cs_bankman',
    's_m_y_barman_01',
    'ig_barry',
    'cs_barry',
    's_f_y_bartender_01',
    'u_m_y_baygor',
    's_f_y_baywatch_01',
    's_m_y_baywatch_01',
    'a_f_m_beach_01',
    'a_f_y_beach_01',
    'a_m_m_beach_01',
    'a_m_o_beach_01',
    'a_m_y_beach_01',
    'a_m_m_beach_02',
    'a_m_y_beach_02',
    'a_m_y_beach_03',
    'a_m_y_beachvesp_01',
    'a_m_y_beachvesp_02',
    'ig_benny',
    'ig_bestmen',
    'ig_beverly',
    'cs_beverly',
    'a_f_m_bevhills_01',
    'a_f_y_bevhills_01',
    'a_m_m_bevhills_01',
    'a_m_y_bevhills_01',
    'a_f_m_bevhills_02',
    'a_f_y_bevhills_02',
    'a_m_m_bevhills_02',
    'a_m_y_bevhills_02',
    'a_f_y_bevhills_03',
    'a_f_y_bevhills_04',
    'u_m_m_bikehire_01',
    'u_f_y_bikerchic',
    's_m_y_blackops_01',
    's_m_y_blackops_02',
    's_m_y_blackops_03',
    'mp_f_boatstaff_01',
    'mp_m_boatstaff_01',
    'a_f_m_bodybuild_01',
    's_m_m_bouncer_01',
    'ig_brad',
    'cs_brad',
    'a_m_y_breakdance_01',
    'ig_bride',
    'csb_bride',
    'u_m_y_burgerdrug_01',
    'csb_burgerdrug',
    's_m_y_busboy_01',
    'u_m_m_rivalpap',
    'a_m_y_roadcyc_01',
    's_m_y_robber_01',
    'ig_roccopelosi',
    'csb_roccopelosi',
    'a_f_y_runner_01',
    'a_m_y_runner_01',
    'a_m_y_runner_02',
    'a_f_y_rurmeth_01',
    'a_m_m_rurmeth_01',
    'ig_russiandrunk',
    'cs_russiandrunk',
    'a_f_m_salton_01',
    'a_f_o_salton_01',
    'a_m_m_salton_01',
    'a_m_o_salton_01',
    'a_m_y_salton_01',
    'a_m_m_salton_02',
    'a_m_m_salton_03',
    'a_m_m_salton_04',
    'g_m_y_salvaboss_01',
    'g_m_y_salvagoon_01',
    'g_m_y_salvagoon_02',
    'g_m_y_salvagoon_03',
    'a_m_y_vinewood_04',
    'u_m_y_corpse_01',
}