local flashlightActive = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        local currentWeapon = GetSelectedPedWeapon(ped)

        for k,v in pairs(Config.Weapons) do
            if currentWeapon == k then
                if DoesEntityExist(ped) and not IsEntityDead(ped) and HasPedGotWeaponComponent(ped, currentWeapon, v) then
                    if IsControlJustPressed(0, Config.Keybind) then
                        flashlightActive = not flashlightActive
                        TriggerEvent("mtf-persistentweapon:client:ToggleFlashlight", ped, flashlightActive)
                    end
                end
            end
        end
    end
end)

RegisterNetEvent("mtf-persistentweapon:client:ToggleFlashlight")
AddEventHandler("mtf-persistentweapon:client:ToggleFlashlight", function(ped, active)
    SetFlashLightEnabled(ped, active)
    SetFlashLightKeepOnWhileMoving(active)
end)
