Config = {}

Config.DataLocation = GetConvar("yg_datalocation", ".data") -- data lokasyonu
Config.DataFlName = "gangsbandana"

Config.BandanaCommand = "bandana"

Config.PedAmmos = {600, 800}

Config.NPCS = {
    [1] = {
        coords = vector3(-139.093, -1559.29, 34.421),
        range = 100,
        create = false,
        bandanaid = 4,
        bandanaName = 'grovebandana',
        npcmodel = {"g_f_y_families_01", "g_m_y_famca_01", "g_m_y_famdnf_01", "g_m_y_famfor_01"},
        animals = {351016938, -1788665315},
        grouphash = GetHashKey("AMBIENT_GANG_FAMILY"),
        weapons = {'WEAPON_PISTOL', 'WEAPON_COMBATPISTOL'},
        job = "gsf",
        currentscenerio = nil,
        Scenerios = {
            [1] = {
                npcs = {
                    [1] = {coord = vector3(-139.093, -1559.29, 34.421), np = nil, heading = 61.2, Task = nil},
                    [2] = {coord = vector3(-139.933, -1560.46, 34.438), np = nil, heading = 61.2, Task = nil},
                    [3] = {coord = vector3(-171.675, -1575.94, 35.262), np = nil, heading = 61.2, Task = nil},
                    [4] = {coord = vector3(-189.175, -1583.53, 34.784), np = nil, heading = 61.2, Task = nil},
                    [5] = {coord = vector3(-172.636, -1576.80, 35.247), np = nil, heading = 61.2, Task = nil},
                    [6] = {coord = vector3(-190.092, -1584.47, 34.762), np = nil, heading = 61.2, Task = nil},
                    [7] = {coord = vector3(-188.591, -1586.64, 34.788), np = nil, heading = 61.2, Task = nil},
                    [8] = {coord = vector3(-177.230, -1630.94, 33.291), np = nil, heading = 61.2, Task = nil},
                    [9] = {coord = vector3(-190.650, -1657.62, 33.674), np = nil, heading = 61.2, Task = nil},
                },
                animals = {
                    [1] = {coord = vector3(-139.093, -1559.29, 34.421), np = nil, heading = 61.2},
                    [2] = {coord = vector3(-139.933, -1560.46, 34.438), np = nil, heading = 61.2},
                },
                Vehicle = {
                    [1] = {create = false, vh = nil, coord = vector3(-1462.53, -2738.46, 13.944), heading = 61.9, model = "windsor"},
                }
            },
            [2] = {
                npcs = {
                    [1] = {coord = vector3(-139.093, -1559.29, 34.421), np = nil, heading = 61.2, Task = nil},
                    [2] = {coord = vector3(-139.933, -1560.46, 34.438), np = nil, heading = 61.2, Task = nil},
                    [3] = {coord = vector3(-171.675, -1575.94, 35.262), np = nil, heading = 61.2, Task = nil},
                    [4] = {coord = vector3(-189.175, -1583.53, 34.784), np = nil, heading = 61.2, Task = nil},
                    [5] = {coord = vector3(-172.636, -1576.80, 35.247), np = nil, heading = 61.2, Task = nil},
                    [6] = {coord = vector3(-190.092, -1584.47, 34.762), np = nil, heading = 61.2, Task = nil},
                    [7] = {coord = vector3(-188.591, -1586.64, 34.788), np = nil, heading = 61.2, Task = nil},
                    [8] = {coord = vector3(-177.230, -1630.94, 33.291), np = nil, heading = 61.2, Task = nil},
                    [9] = {coord = vector3(-190.650, -1657.62, 33.674), np = nil, heading = 61.2, Task = nil},
                },
                animals = {
                    [1] = {coord = vector3(-139.093, -1559.29, 34.421), np = nil, heading = 61.2},
                    [2] = {coord = vector3(-139.933, -1560.46, 34.438), np = nil, heading = 61.2},
                },
                Vehicle = {
                    [1] = {create = false, vh = nil, coord = vector3(-1462.53, -2738.46, 13.944), heading = 61.9, model = "windsor"},
                }
            }
        }
    },
    [2] = {
        coords = vector3(355.1777, -2042.45, 22.009),
        range = 100,
        create = false,
        bandanaid = 1,
        bandanaName = 'vagosbandana',
        npcmodel = {"g_f_importexport_01", "g_m_y_mexgoon_01", "g_m_y_mexgoon_02", "g_m_y_mexgoon_03"},
        animals = {351016938, -1788665315},
        grouphash = GetHashKey("AMBIENT_GANG_MEXICAN"),
        weapons = {'WEAPON_PISTOL', 'WEAPON_COMBATPISTOL'},
        job = "vagos",
        currentscenerio = nil,
        Scenerios = {
            [1] = {
                npcs = {
                    [1] = {coord = vector3(355.1777, -2042.45, 22.009), np = nil, heading = 61.2, Task = nil},
                    [2] = {coord = vector3(354.0399, -2070.13, 21.219), np = nil, heading = 61.2, Task = nil},
                    [3] = {coord = vector3(355.8383, -2067.44, 21.258), np = nil, heading = 61.2, Task = nil},
                    [4] = {coord = vector3(368.3879, -2052.69, 21.686), np = nil, heading = 61.2, Task = nil},
                    [5] = {coord = vector3(370.2891, -2051.12, 21.713), np = nil, heading = 61.2, Task = nil},
                    [6] = {coord = vector3(324.6848, -2046.28, 20.836), np = nil, heading = 61.2, Task = nil},
                    [7] = {coord = vector3(324.1025, -2045.54, 20.834), np = nil, heading = 61.2, Task = nil},
                    [8] = {coord = vector3(319.0085, -2012.50, 20.888), np = nil, heading = 61.2, Task = nil},
                    [9] = {coord = vector3(320.8933, -2013.54, 21.157), np = nil, heading = 61.2, Task = nil}, -- [[Task  ={dict = "", anim = "", type = }]]
                },
                animals = {
                    [1] = {coord = vector3(-139.093, -1559.29, 34.421), np = nil, heading = 61.2},
                    [2] = {coord = vector3(-139.933, -1560.46, 34.438), np = nil, heading = 61.2},
                },
                Vehicle = {
                    [1] = {create = false, vh = nil, coord = vector3(-1462.53, -2738.46, 13.944), heading = 61.9, model = "windsor"},
                }
            },
            [2] = {
                npcs = {
                    [1] = {coord = vector3(355.1777, -2042.45, 22.009), np = nil, heading = 61.2, Task = nil},
                    [2] = {coord = vector3(354.0399, -2070.13, 21.219), np = nil, heading = 61.2, Task = nil},
                    [3] = {coord = vector3(355.8383, -2067.44, 21.258), np = nil, heading = 61.2, Task = nil},
                    [4] = {coord = vector3(368.3879, -2052.69, 21.686), np = nil, heading = 61.2, Task = nil},
                    [5] = {coord = vector3(370.2891, -2051.12, 21.713), np = nil, heading = 61.2, Task = nil},
                    [6] = {coord = vector3(324.6848, -2046.28, 20.836), np = nil, heading = 61.2, Task = nil},
                    [7] = {coord = vector3(324.1025, -2045.54, 20.834), np = nil, heading = 61.2, Task = nil},
                    [8] = {coord = vector3(319.0085, -2012.50, 20.888), np = nil, heading = 61.2, Task = nil},
                    [9] = {coord = vector3(320.8933, -2013.54, 21.157), np = nil, heading = 61.2, Task = nil}, -- [[Task  ={dict = "", anim = "", type = }]]
                },
                animals = {
                    [1] = {coord = vector3(355.1777, -2042.45, 22.009), np = nil, heading = 61.2},
                    [2] = {coord = vector3(354.0399, -2070.13, 21.219), np = nil, heading = 61.2},
                },
                Vehicle = {
                    [1] = {create = false, vh = nil, coord = vector3(-1462.53, -2738.46, 13.944), heading = 61.9, model = "windsor"},
                }
            }
        }
    },
    [3] = {
        coords = vector3(102.7182, -1954.83, 20.711),
        range = 100,
        create = false,
        bandanaid = 2,
        bandanaName = 'ballasbandana',
        npcmodel = {"g_f_y_ballas_01", "g_m_y_ballaeast_01", "g_m_y_ballaorig_01", "g_m_y_ballasout_01"},
        animals = {351016938, -1788665315},
        grouphash = GetHashKey("AMBIENT_GANG_BALLAS"),
        weapons = {'WEAPON_PISTOL', 'WEAPON_COMBATPISTOL'},
        job = "ballas",
        currentscenerio = nil,
        Scenerios = {
            [1] = {
                npcs = {
                    [1] = {coord = vector3(102.7182, -1954.83, 20.711), np = nil, heading = 61.2, Task = nil}, --[[Task = {dict = "random@arrests", anim = "idle_2_hands_up", type = 2}]]
                    [2] = {coord = vector3(118.8402, -1939.26, 20.671), np = nil, heading = 61.2, Task = nil},
                    [3] = {coord = vector3(86.44751, -1915.64, 20.812), np = nil, heading = 61.2, Task = nil},
                    [4] = {coord = vector3(50.81997, -1910.45, 21.636), np = nil, heading = 61.2, Task = nil},
                    [5] = {coord = vector3(56.57231, -1888.34, 21.663), np = nil, heading = 61.2, Task = nil},
                    [6] = {coord = vector3(79.55957, -1932.77, 20.735), np = nil, heading = 61.2, Task = nil},
                    [7] = {coord = vector3(97.52641, -1954.34, 20.755), np = nil, heading = 61.2, Task = nil},
                    [8] = {coord = vector3(117.8389, -1947.16, 20.715), np = nil, heading = 61.2, Task = nil},
                    [9] = {coord = vector3(117.7263, -1948.58, 20.749), np = nil, heading = 61.2, Task = {dict = "random@arrests", anim = "idle_2_hands_up", type = 2}},
                },
                animals = {
                    [1] = {coord = vector3(102.7182, -1954.83, 20.711), np = nil, heading = 61.2}, --[[Task = {dict = "random@arrests", anim = "idle_2_hands_up", type = 2}]]
                    [2] = {coord = vector3(118.8402, -1939.26, 20.671), np = nil, heading = 61.2},
                },
                Vehicle = {
                    [1] = {create = false, vh = nil, coord = vector3(107, -1947.26, 20.671), heading = 61.9, model = "windsor"},
                }
            },
            [2] = {
                npcs = {
                    [1] = {coord = vector3(102.7182, -1954.83, 20.711), np = nil, heading = 61.2, Task = nil}, --[[Task = {dict = "random@arrests", anim = "idle_2_hands_up", type = 2}]]
                    [2] = {coord = vector3(118.8402, -1939.26, 20.671), np = nil, heading = 61.2, Task = nil},
                    [3] = {coord = vector3(86.44751, -1915.64, 20.812), np = nil, heading = 61.2, Task = nil},
                    [4] = {coord = vector3(50.81997, -1910.45, 21.636), np = nil, heading = 61.2, Task = nil},
                    [5] = {coord = vector3(56.57231, -1888.34, 21.663), np = nil, heading = 61.2, Task = nil},
                    [6] = {coord = vector3(79.55957, -1932.77, 20.735), np = nil, heading = 61.2, Task = nil},
                    [7] = {coord = vector3(97.52641, -1954.34, 20.755), np = nil, heading = 61.2, Task = nil},
                    [8] = {coord = vector3(117.8389, -1947.16, 20.715), np = nil, heading = 61.2, Task = nil},
                    [9] = {coord = vector3(117.7263, -1948.58, 20.749), np = nil, heading = 61.2, Task = {dict = "random@arrests", anim = "idle_2_hands_up", type = 2}},
                },
                animals = {
                    [1] = {coord = vector3(102.7182, -1954.83, 20.711), np = nil, heading = 61.2}, --[[Task = {dict = "random@arrests", anim = "idle_2_hands_up", type = 2}]]
                    [2] = {coord = vector3(118.8402, -1939.26, 20.671), np = nil, heading = 61.2},
                },
                Vehicle = {
                    [1] = {create = false, vh = nil, coord = vector3(107, -1947.26, 20.671), heading = 61.9, model = "windsor"},
                }
            }
        }   
    }   
}   