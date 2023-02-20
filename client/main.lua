ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

local veh = {
  {label = "Vehicule", action = "spawn"},
  {label = "Options", action = "options"},
  {label = "Couleur", action = "color"},
  {label = "Amélioration", action = "upgrade"},
  {label = "Réparation", action = "repair"},
  {label = "Suppression", action = "delete"},
}

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    local vehicleCoords = GetEntityCoords(vehicle)
    local distance = GetDistanceBetweenCoords(coords, vehicleCoords, true)
    if IsControlJustPressed(0, 170) then -- F3
        OpenMenu()
    end
  end
end)

function OpenMenu()
    local menumain = RageUI.CreateMenu("Menu Véhicule", "Menu Véhicule")
    RageUI.Visible(menumain, not RageUI.Visible(menumain))
    while menumain do
        Citizen.Wait(0)
        RageUI.IsVisible(menumain, true, true, true, function()
            for k,v in pairs(veh) do
                RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        if v.action == "spawn" then
                            SpawnVehicle()
                        elseif v.action == "options" then
                            OptionsVehicle()
                            SetVehicleModKit(vehicle, 0)
                        elseif v.action == "color" then
                            ColorVehicle()
                        elseif v.action == "upgrade" then
                            UpgradeVehicle()
                        elseif v.action == "repair" then
                            RepairVehicle()
                        elseif v.action == "delete" then
                            DeleteVehicle()
                        end
                    end
                end)
            end
        end)
        if not RageUI.Visible(menumain) then
            menumain = RMenu:DeleteType("menumain", true)
        end
    end
end