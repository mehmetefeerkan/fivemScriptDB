### Contact
- Discord: FanonX#4879

### Requirements
- ESX
- mythic notify (free on github / [https://github.com/JayMontana36/mythic_notify])
- progressBars (free on github / [https://github.com/Hamza8700/fivem_scripts/tree/master/progressBars])
- jsfour-idcard and his requirements (OPTIONAL free on github / [https://forum.cfx.re/t/release-jsfour-idcard-esx/169787])

### Installation
1) Drag & drop the fanonx_hunting into your `resources` server folder.
2) Configure the config file.
3) Import the SQL file into your database.
4) Install and ensure the requirements.
5) Drag and drop images on the various script folders.
6) Add `start fanonx_hunting` to your server config.

### Showcase
- https://youtu.be/c83Yb-vxpkA

### License
To show the license (to you and to others) you need to do some changes on jsfour script:

`SERVER file (from line 6 till bottom)`:

    RegisterServerEvent('jsfour-idcard:open')
    AddEventHandler('jsfour-idcard:open', function(ID, targetID, type)
        local identifier = ESX.GetPlayerFromId(ID).identifier
        local _source 	 = ESX.GetPlayerFromId(targetID).source
        local show       = false

        MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
        function (user)
            if (user[1] ~= nil) then
                MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier},
                function (licenses)
                    if type ~= nil then
                        for i=1, #licenses, 1 do
                            if type == 'driver' then
                                if licenses[i].type == 'drive' or licenses[i].type == 'drive_bike' or licenses[i].type == 'drive_truck' then
                                    show = true
                                end
                            elseif type =='weapon' then
                                if licenses[i].type == 'weapon' then
                                    show = true
                                end
                            elseif type =='hunt' then
                                if licenses[i].type == 'hunt' then
                                    show = true
                                end
                            end
                        end
                    else
                        show = true
                    end

                    if show then
                        local array = {
                            user = user,
                            licenses = licenses
                        }
                        TriggerClientEvent('jsfour-idcard:open', _source, array, type)
                    else
                        TriggerClientEvent('esx:showNotification', _source, "You don't have that type of license..")
                    end
                end)
            end
        end)
    end)

_____________________

`CLIENT file (replace the all file with this)`:

    local open = false

    ESX = nil

    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(10)
        end
    end)

    -- Open ID card
    RegisterNetEvent('jsfour-idcard:open')
    AddEventHandler('jsfour-idcard:open', function( data, type )
        open = true
        SendNUIMessage({
            action = "open",
            array  = data,
            type   = type
        })
    end)

    -- Key events
    Citizen.CreateThread(function()
        while true do
            Wait(5)
            if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
                SendNUIMessage({
                    action = "close"
                })
                open = false
            end
        end
    end)

    function openMenu()
        ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'id_card_menu',
        {
            title    = 'ID menu',
            elements = {
                {label = 'Check your ID', value = 'checkID'},
                {label = 'Show your ID', value = 'showID'},
                {label = 'Check your driver license', value = 'checkDriver'},
                {label = 'Show your driver license', value = 'showDriver'},
                {label = 'Check your firearms license', value = 'checkFirearms'},
                {label = 'Show your firearms license', value = 'showFirearms'},
                {label = 'Check your hunting license', value = 'checkHunting'},
                {label = 'Show your hunting license', value = 'showHunting'}
            }
        },
        function(data, menu)
            local val = data.current.value
            
            if val == 'checkID' then
                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
            elseif val == 'checkDriver' then
                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
            elseif val == 'checkFirearms' then
                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
            elseif val == 'checkHunting' then
                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'hunt')
            else
                local player, distance = ESX.Game.GetClosestPlayer()
                
                if distance ~= -1 and distance <= 3.0 then
                    if val == 'showID' then
                            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
                    elseif val == 'showDriver' then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
                    elseif val == 'showFirearms' then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
                    elseif val == 'showHunting' then
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'hunt')
                    end
                else
                ESX.ShowNotification('No players nearby')
                end
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
    end

    -- Key events
    Citizen.CreateThread(function()
        while true do
            Wait(5)
            if IsControlJustReleased(0, 344) then
                SendNUIMessage({
                    action = "open"
                })
                open = true
                openMenu()
            end
        end
    end)


_____________________

`jsfour-idcard\html\assets\js\init.js (add this else if on line 58)`:

    else if ( type == 'hunt' ) {
        $('img').hide();
        $('#name').css('color', '#d9d9d9');
        $('#name').text(userData.firstname + ' ' + userData.lastname);
        $('#dob').text(userData.dateofbirth);
        $('#signature').text(userData.firstname + ' ' + userData.lastname);

        $('#id-card').css('background', 'url(assets/images/hunting.png)');
    }


_____________________


To give hunting license just trigger server event `'fanonx-hunting:server:giveLicense'` and pass `server id of the closest player`: 

    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('fanonx-hunting:server:giveLicense', GetPlayerServerId(closestPlayer))
    end

An example can be with `esx_policejob`, replace from line `290` to `341` with this:

    local elements = {
        {label = _U('id_card'), value = 'identity_card'},
        {label = _U('search'), value = 'search'},
        {label = _U('handcuff'), value = 'handcuff'},
        {label = _U('drag'), value = 'drag'},
        {label = _U('put_in_vehicle'), value = 'put_in_vehicle'},
        {label = _U('out_the_vehicle'), value = 'out_the_vehicle'},
        {label = _U('fine'), value = 'fine'},
        {label = _U('unpaid_bills'), value = 'unpaid_bills'},
        {label = "Release Hunting License", value = 'hunting_license'}
    }

    if Config.EnableLicenses then
        table.insert(elements, {label = _U('license_check'), value = 'license'})
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
        title    = _U('citizen_interaction'),
        align    = 'top-left',
        elements = elements
    }, function(data2, menu2)
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 3.0 then
            local action = data2.current.value

            if action == 'identity_card' then
                OpenIdentityCardMenu(closestPlayer)
            elseif action == 'search' then
                OpenBodySearchMenu(closestPlayer)
            elseif action == 'handcuff' then
                TriggerServerEvent('esx_policejob:handcuff', GetPlayerServerId(closestPlayer))
            elseif action == 'drag' then
                TriggerServerEvent('esx_policejob:drag', GetPlayerServerId(closestPlayer))
            elseif action == 'put_in_vehicle' then
                TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
            elseif action == 'out_the_vehicle' then
                TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
            elseif action == 'fine' then
                OpenFineMenu(closestPlayer)
            elseif action == 'license' then
                ShowPlayerLicense(closestPlayer)
            elseif action == 'unpaid_bills' then
                OpenUnpaidBillsMenu(closestPlayer)
            elseif action == 'hunting_license' then
                TriggerServerEvent('fanonx-hunting:server:giveLicense', GetPlayerServerId(closestPlayer))
            end
        else
            ESX.ShowNotification(_U('no_players_nearby'))
        end
    end, function(data2, menu2)
        menu2.close()
    end)
