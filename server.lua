ESX = nil

AdminList = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addGroupCommand', 'adminmode', 'mod', function(source, args, user)
	local found = nil
	local xPlayer = ESX.GetPlayerFromId(source)
	local name = GetPlayerName(source)
		for i, v in ipairs(AdminList) do
            if v.id == source then
				found = i
				break
			end
        end

        if found == nil then
            TriggerClientEvent('esx:showNotification', source, 'You activated the ~r~admin duty.')
			TriggerEvent('red_adminmode:updatelist', '~r~Server Admin', false, source)
            TriggerClientEvent('red_adminmode:setGodmode', source, true)
            TriggerClientEvent('red_adminmode:setOutfit', source)
        else
            TriggerClientEvent('esx:showNotification', source, 'You deactivated the ~r~admin duty.')
            TriggerEvent('red_adminmode:updatelist', '~r~Server Admin', true, source)
			TriggerClientEvent('red_adminmode:setGodmode', source, false)
			TriggerClientEvent('red_adminmode:zivil', source)
		end
end, function(source, args, user)
    TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'You have no permissions to use this command!' } })
end, {help = 'Toggle the admin duty.'})

ESX.RegisterServerCallback('red_adminmode:isDuty', function(source, cb)
    local found = nil
    for i, v in ipairs(AdminList) do
        if v.id == source then
            found = i
            break
        end
    end

    if found == nil then
        cb(false)
    else
        cb(true)
    end
end)

RegisterServerEvent('red_adminmode:updatelist')
AddEventHandler('red_adminmode:updatelist', function(name2, removebool, id)
	if removebool then
		local found = nil
		for i, v in ipairs(AdminList) do
			if v.id == id then
				found = i
				break
			end
		end
		if found ~= nil then
			table.remove(AdminList, found)
		end
	else
		local found = nil
		for i, v in ipairs(AdminList) do
			if v.id == id then
				found = i
				break
			end
		end
		if found ~= nil then
			table.remove(AdminList, found)
		end
		table.insert(AdminList, {name=name2, id=id})
	end
	
    TriggerClientEvent('red_adminmode:clupdatelist', -1, AdminList)
end) 