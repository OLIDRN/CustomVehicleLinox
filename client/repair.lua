---
--- Generated by Luanalysis
--- Created by olivi.
--- DateTime: 14/02/2023 14:23
---


local zone = {
    {label = "Zone 1 - 5m", radius = 5.0},
    {label = "Zone 2 - 50m", radius = 50.0},
    {label = "Zone 3 - 100m", radius = 100.0},
    {label = "Zone 4 - 150m", radius = 150.0},
}

local InVeh = false

function RepairVehicle()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed, false)
    if InVeh == false then
        RageUI.CloseAll()
        local menuRP = RageUI.CreateMenu("Réparation", "Menu Réparation")
        RageUI.Visible(menuRP, not RageUI.Visible(menuRP))
        while menuRP do
            Citizen.Wait(0)
            RageUI.IsVisible(menuRP, true, true, true, function()
                RageUI.ButtonWithStyle("Réparer", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SetVehicleFixed(GetVehiclePedIsIn(playerPed, false))
                    end
                end)
                for k,v in ipairs(zone) do
                    RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Active then
                            local playerCoords = GetEntityCoords(playerPed, false)
                            DrawMarker(1, playerCoords.x, playerCoords.y, playerCoords.z - 1.0, 0, 0, 0, 0, 0, 0, v.radius, v.radius, 50.0, 0, 255, 0, 100, 0, 0, 0, 0)
                        end
                        if Selected then
                            local vehciles = ESX.Game.GetVehiclesInArea(playerCoords, v.radius)
                            for i = 1, #vehciles, 1 do
                                if DoesEntityExist(vehciles[i]) then
                                    SetVehicleFixed(vehciles[i])
                                end
                            end
                        end
                    end)
                end
            end)
            if not RageUI.Visible(menuRP) then
                menuRP = RMenu:DeleteType("menuRP", true)
            end
        end
    end
end