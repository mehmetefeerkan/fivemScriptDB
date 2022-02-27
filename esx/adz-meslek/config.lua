Jobs = {
    ["Tarihi Eser Kaçakcılığı"] = {
        jobRequired = false, --Meslek zorunluluğunu açar
        jobName = "unemployed", --Meslek isimi
        location = { 
            [1] = { --toplama
                coords = vector3(1921.68, 4803.94, 44.19), --İşlemin yapılacağı kordinat
                blip = {
                    showBlip = true, --Blip'i açar
                    blipName = "Frambuaz Toplama", --Blip adı
                    sprite = 153, --Blip işareti
                    color = 8, --Blip rengi
                    scale = 0.65, --Blip boyutu
                },
                marker = {
                    enable = true, --Marker'ı açar
                    size  = { x = 0.7, y = 0.7, z = 0.4 }, --Marker boyutu
                    color = { r = 255, g = 0, b = 0 }, --Marker rengi
                    type  = 2 --Marker tipi
                },
                draw3dtext = {
                    enable = true, --Drawtexti açar
                    text = "Frambuaz toplamak için ~g~E ~w~bas", --Drawtext text'i
                },
                item = {
                    process = "pickup", --Dokunmayın

                    itemName = "ptx_tarihieser1", --Toplanacak olan eşya
                    addCount = 1, --Toplama başına verilecek adet
                },                
                animation = {
                    enable = true, --Animasyonu açar
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb" --Animasyonun dict'ini girin
                        animName = "car_bomb_mechanic" --Animasyon adını girin
                        Citizen.CreateThread(function() 
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end 
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true, --progress barı açar
                    progText = "Toplanıyor...", --progress bar'ın texti
                    duration = 5000 --İşlem süresi
                }
            },
            [2] = { --işleme
                coords = vector3(-1590.52, 5197.49, 4.91), 
                blip = {
                    showBlip = true,
                    blipName = "Frambuaz İşleme",
                    sprite = 153, 
                    color = 8,
                    scale = 0.65,
                },
                marker = {
                    enable = true,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "Frambuaz islemek için ~g~E ~w~bas",
                },
                item = {
                    process = "exchange", --dokunmayın.
                    
                    addCount = 1, --verilecek adet
                    itemName = "ptx_tarihieser2", --verilecek olan eşya
                    
                    removeCount = 3, --işlem için gerekli adet
                    requiredItem = "ptx_tarihieser1", --işlem için gerekli olan eşya
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "isleniyor...",
                    duration = 8000
                }
            },
            [3] = { --paketleme
                coords = vector3(-1123.01, -2013.09, 13.19), 
                blip = {
                    showBlip = true,
                    blipName = "Frambuaz Paketleme",
                    sprite = 153, 
                    color = 8,
                    scale = 0.65,
                },
                marker = {
                    enable = true,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "Frambuaz paketlemek için ~g~E ~w~bas",
                },
                item = {
                    process = "package", --dokunmayın

                    addCount = 1, --verilecek adet
                    itemName = "ptx_tarihieser3", --verilecek eşya

                    removeCount = 3, --gerekli eşyadan silinecek adet
                    requiredItem = "ptx_tarihieser2", --gerekli eşya
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Frambuaz paketleniyor...",
                    duration = 7000
                }
            }
        },
    },

    ["Kaçak Silah"] = {
        jobRequired = false, --Meslek zorunluluğunu açar
        jobName = "unemployed", --Meslek isimi
        location = { 
            [1] = { --toplama
                coords = vector3(2008.29, 4830.18, 42.7), --İşlemin yapılacağı kordinat
                blip = {
                    showBlip = true, --Blip'i açar
                    blipName = "Üzüm Toplama", --Blip adı
                    sprite = 153, --Blip işareti
                    color = 3, --Blip rengi
                    scale = 0.65, --Blip boyutu
                },
                marker = {
                    enable = true, --Marker'ı açar
                    size  = { x = 0.7, y = 0.7, z = 0.4 }, --Marker boyutu
                    color = { r = 255, g = 0, b = 0 }, --Marker rengi
                    type  = 2 --Marker tipi
                },
                draw3dtext = {
                    enable = true, --Drawtexti açar
                    text = "Üzüm toplamak için ~g~E ~w~bas", --Drawtext text'i
                },
                item = {
                    process = "pickup", --Dokunmayın

                    itemName = "ptx_kacaksilah1", --Toplanacak olan eşya
                    addCount = 1, --Toplama başına verilecek adet
                },                
                animation = {
                    enable = true, --Animasyonu açar
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb" --Animasyonun dict'ini girin
                        animName = "car_bomb_mechanic" --Animasyon adını girin
                        Citizen.CreateThread(function() 
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end 
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true, --progress barı açar
                    progText = "Toplanıyor...", --progress bar'ın texti
                    duration = 5000 --İşlem süresi
                }
            },
            [2] = { --işleme
                coords = vector3(-702.79, 5790.23, 17.52), 
                blip = {
                    showBlip = true,
                    blipName = "Şarap Yapımı",
                    sprite = 153, 
                    color = 3,
                    scale = 0.65,
                },
                marker = {
                    enable = true,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "Sarap Yapmak için ~g~E ~w~bas",
                },
                item = {
                    process = "exchange", --dokunmayın.
                    
                    addCount = 1, --verilecek adet
                    itemName = "ptx_kacaksilah2", --verilecek olan eşya
                    
                    removeCount = 2, --işlem için gerekli adet
                    requiredItem = "ptx_kacaksilah1", --işlem için gerekli olan eşya
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Sarap elde ediliyor...",
                    duration = 8000
                }
            },
            [3] = { --paketleme
                coords = vector3(658.74, 593.25, 129.05), 
                blip = {
                    showBlip = true,
                    blipName = "Şarap Paketleme",
                    sprite = 153, 
                    color = 3,
                    scale = 0.65,
                },
                marker = {
                    enable = true,
                    size  = { x = 0.7, y = 0.7, z = 0.4 },
                    color = { r = 204, g = 204, b = 0 },
                    type  = 2
                },
                draw3dtext = {
                    enable = true,
                    text = "Sarap Paketlemek için ~g~E ~w~bas",
                },
                item = {
                    process = "package", --dokunmayın

                    addCount = 1, --verilecek adet
                    itemName = "ptx_kacaksilah3", --verilecek eşya

                    removeCount = 2, --gerekli eşyadan silinecek adet
                    requiredItem = "ptx_kacaksilah2", --gerekli eşya
                },
                animation = {
                    enable = true,
                    animationFunction = function(ped)
                        animDict = "mp_car_bomb"
                        animName = "car_bomb_mechanic"
                        Citizen.CreateThread(function()
                            RequestAnimDict(animDict) 
                            while not HasAnimDictLoaded(animDict) do Citizen.Wait(10) end
                            TaskPlayAnim(ped, animDict, animName, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        end)
                    end,
                },
                progressbar = {
                    enable = true,
                    progText = "Üzüm Paketleniyor...",
                    duration = 7000
                }
            }
        },
    },
}