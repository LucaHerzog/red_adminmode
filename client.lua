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
    SetEntityInvincible(GetPlayerPed(-1), state)
end)

RegisterNetEvent('red_adminmode:setOutfit')
AddEventHandler('red_adminmode:setOutfit', function()
    TriggerEvent('skinchanger:change', "tshirt_1", 15)
    TriggerEvent('skinchanger:change', "tshirt_2", 0)
    TriggerEvent('skinchanger:change', "torso_1", 287)
    TriggerEvent('skinchanger:change', "torso_2", 2)
    TriggerEvent('skinchanger:change', "arms", 3)
    TriggerEvent('skinchanger:change', "pants_1", 114)
    TriggerEvent('skinchanger:change', "pants_2", 2)
    TriggerEvent('skinchanger:change', "shoes_1", 78)
    TriggerEvent('skinchanger:change', "shoes_2", 2)
    TriggerEvent('skinchanger:change', "helmet_1", -1)
    TriggerEvent('skinchanger:change', "helmet_2", 0)
    TriggerEvent('skinchanger:change', "mask_1", 135)
    TriggerEvent('skinchanger:change', "mask_2", 2)
    TriggerEvent('skinchanger:change', "chain_1", 0)
    TriggerEvent('skinchanger:change', "chain_2", 0)
    TriggerEvent('skinchanger:change', "ears_1", 0)
    TriggerEvent('skinchanger:change', "ears_2", 0)
    TriggerEvent('skinchanger:change', "bags_1", 0)
    TriggerEvent('skinchanger:change', "bags_2", 0)
    TriggerEvent('skinchanger:change', "hair_1", 0)
    TriggerEvent('skinchanger:change', "hair_2", 0)
    TriggerEvent('skinchanger:change', "bproof_1", 0)
    TriggerEvent('skinchanger:change', "bproof_2", 0)
    TriggerEvent('skinchanger:change', "sex", 0)
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
			if GetPlayerPed( -1 ) ~= GetPlayerPed( GetPlayerFromServerId(v.id) ) then
				ped = GetPlayerPed(GetPlayerFromServerId(v.id))
				x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
				x2, y2, z2 = table.unpack( GetEntityCoords( ped, true ) )
				
				
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
