ESX = nil
Sentic = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- example

Sentic.WeaponComponents = {
    {weaponname = "weapon_pistol", components = "Default Clip: COMPONENT_PISTOL_CLIP_01 Extended Clip: COMPONENT_PISTOL_CLIP_02 Flashlight: COMPONENT_AT_PI_FLSH Suppressor: COMPONENT_AT_PI_SUPP_02 Yusuf Amir Luxury Finish COMPONENT_PISTOL_VARMOD_LUXE"},
    {weaponname = "weapon_minismg", components = "Default Clip: COMPONENT_MINISMG_CLIP_01 Clip: COMPONENT_MINISMG_CLIP_02"},
    {weaponname = "weapon_assaultrifle", components = "Default Clip: COMPONENT_ASSAULTRIFLE_CLIP_01 Extended Clip: COMPONENT_ASSAULTRIFLE_CLIP_02 Drum Magazine: COMPONENT_ASSAULTRIFLE_CLIP_03 Flashlight: COMPONENT_AT_AR_FLSH Scope: COMPONENT_AT_SCOPE_MACRO	Suppressor: COMPONENT_AT_AR_SUPP_02	Grip: COMPONENT_AT_AR_AFGRIP Yusuf Amir Luxury Finish: COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"}
}

RegisterCommand("componentlist", function(source, args)
    ESX.TriggerServerCallback('sentic:client:admins', function(whitelisted)
        if whitelisted then
            local wapen = args[1]
            for k, v in pairs(Sentic.WeaponComponents) do
                if wapen == v.weaponname then
                    print(json.encode(v.components))
                    ESX.ShowNotification("Wapen Components: Check je f8")
                    return
                end
            end
            ESX.ShowNotification("Dit wapen bestaat niet!")
        else
            ESX.ShowNotification("Je hebt geen premisie om dit te doen!")
        end
    end)
end)

TriggerEvent('chat:addSuggestion', '/componentlist', 'help suggesties', {
    { name="wapen naam"},
})

TriggerEvent('chat:addSuggestion', '/giveweaponcomponent', 'help suggesties', {
    { name="wapen naam"},
    { name="wapen component"}
})


RegisterCommand("giveweaponcomponent", function(source, args)
    local speler = PlayerPedId()
    local wapen = args[1]
    local component = args[2]
    
    ESX.TriggerServerCallback('sentic:client:admins', function(whitelisted)
        if whitelisted then
            if HasPedGotWeapon(speler, wapen) then
                if HasPedGotWeaponComponent(speler, wapen, component) then
                    RemoveWeaponComponentFromPed(speler, wapen, component)
                    ESX.ShowNotification("Wapen Component Verwijderd!")
                else
                    GiveWeaponComponentToPed(speler, wapen, component)
                    ESX.ShowNotification("Wapen Component Toegevoegd!")
                end
            else
                ESX.ShowNotification("Je bent niet in het bezit van dit wapen!: "..wapen.."")
            end  
        else
            ESX.ShowNotification("Je hebt geen premisie om dit te doen!")
        end
    end)
end)