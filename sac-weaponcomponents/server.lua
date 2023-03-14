Sentic = {}
Group = {}
Table = {}


ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Group.Whitelist = true
Table.Whitelist = false

Sentic.Admins = {
    "steam:xxxxxx",
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        ESX.RegisterServerCallback('sentic:client:admins', function(source, cb)
            local whitelisted = false
            local xPlayer = ESX.GetPlayerFromId(source)
            local identifiers = GetPlayerIdentifiers(source)
    
            if Table.Whitelist then 
                for k, v in pairs(Sentic.Admins) do
                    if identifiers[1] == v then
                        whitelisted = true
                        break
                    end
                end
                cb(whitelisted)
            else
                if Group.Whitelist then
                    if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' then
                        whitelisted = true
                    end
                end
                cb(whitelisted)
            end
        end)
    end
end)
