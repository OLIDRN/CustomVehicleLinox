---
--- Generated by Luanalysis
--- Created by olivi.
--- DateTime: 14/02/2023 00:30
---

local PharesXenonColor = {
    {label = "Blanc", value = 0},
    {label = "Bleu", value = 1},
    {label = "Electric Blue", value = 2},
    {label = "Mint Green", value = 3},
    {label = "Lime Green", value = 4},
    {label = "Jaune", value = 5},
    {label = "Golden Shower", value = 6},
    {label = "Orange", value = 7},
    {label = "Red", value = 8},
    {label = "Pony Pink", value = 9},
    {label = "Hot Pink", value = 10},
    {label = "Purple", value = 11},
    {label = "Blacklight", value = 12},
}

function XenonColor()
    local playerPed = PlayerPedId()
    local veh = GetVehiclePedIsIn(playerPed, false)
    if IsPedInAnyVehicle(playerPed, false) then
        RageUI.CloseAll()
        local menuXenonColor = RageUI.CreateMenu("Xenon Color", "Menu Xenon Color")
        RageUI.Visible(menuXenonColor, not RageUI.Visible(menuXenonColor))
        while menuXenonColor do
            Citizen.Wait(0)
            RageUI.IsVisible(menuXenonColor, true, true, true, function()
                for k,v in pairs(PharesXenonColor) do
                    RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            ToggleVehicleMod(veh, 22, true)
                            SetVehicleXenonLightsColor(veh, v.value)
                        end
                    end)
                end
            end)
            if not RageUI.Visible(menuXenonColor) then
                menuXenonColor = RMenu:DeleteType("menuXenonColor", true)
            end
        end
    end
end