ESX = nil

AdminList = {}

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end)

RegisterNetEvent('red_adminmode:clupdatelist')
AddEventHandler('red_adminmode:clupdatelist', function(list) 
    AdminList = list
end)

RegisterNetEvent('red_adminmode:setGodmode')
AddEventHandler('red_adminmode:setGodmode', function(state)
    SetEntityInvincible(PlayerPedId(), state)
end)

RegisterNetEvent('red_adminmode:setOutfit')
AddEventHandler('red_adminmode:setOutfit', function()
    SetPedComponentVariation(PlayerPedId(), 0, 1, 1, 0)
    SetPedComponentVariation(PlayerPedId(), 1, 135, 2, 0)
    SetPedComponentVariation(PlayerPedId(), 2, 1, 1, 0)
    SetPedComponentVariation(PlayerPedId(), 3, 42, 1, 0)
    SetPedComponentVariation(PlayerPedId(), 4, 114, 2, 0)
    SetPedComponentVariation(PlayerPedId(), 5, 0, 1, 0)
    SetPedComponentVariation(PlayerPedId(), 6, 78, 2, 0)
    SetPedComponentVariation(PlayerPedId(), 7, 0, 1, 0)
    SetPedComponentVariation(PlayerPedId(), 8, 15, 1, 0)
    SetPedComponentVariation(PlayerPedId(), 9, 0, 1, 0)
    SetPedComponentVariation(PlayerPedId(), 10, 0, 1, 0)
    SetPedComponentVariation(PlayerPedId(), 11, 287, 2, 0)
    SetPedPropIndex(PlayerPedId(), 0, -1, 0, 0)
end)

RegisterNetEvent('red_adminmode:zivil')
AddEventHandler('red_adminmode:zivil', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end)

Citizen.CreateThread(function () 
	while true do
        for i, v in ipairs(AdminList) do
			if PlayerPedId() ~= GetPlayerPed( GetPlayerFromServerId(v.id) ) then
				ped = GetPlayerPed(GetPlayerFromServerId(v.id))
				x1, y1, z1 = table.unpack( GetEntityCoords( PlayerPedId(), true ) )
				x2, y2, z2 = table.unpack( GetEntityCoords( PlayerPedId(GetPlayerFromServerId(v.id)), true ) )
				
				
				distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
				
				if (distance < 50) then
					DrawText3D(x2, y2, z2 + 1.25, 255, 55, 55, v.name)
				end
			end
		end
		
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    while true do
    Wait(300000)

    ESX.TriggerServerCallback('red_adminmode:isDuty', function(enabled)
        if enabled then
            TriggerEvent("chatMessage", "", {255,0,0}, 'You still have your admin mode on. Please remember not to exploit it.')
        end
    end)
    end
end)

function DrawText3D(x,y,z, red, green, blue, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
		World3dToScreen2d(x,y,z, 0) 
        DrawText(_x,_y)
    end
end
