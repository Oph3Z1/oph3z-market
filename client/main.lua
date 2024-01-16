frameworkObject = false
AlreadyOpen = false

Citizen.CreateThread(function()
    frameworkObject, Config.Framework = GetCore()
    while not frameworkObject do
        Citizen.Wait(0)
    end
    Citizen.Wait(1500)
    SendNUIMessage({
        action = 'Setup',
        data = GetCurrentResourceName()
    })
end)

Citizen.CreateThread(function ()
    while true do
        local sleep = 1000
        for i = 1, #Config.Coords, 1 do
            local coords = GetEntityCoords(PlayerPedId())
            if #(coords - vector3(Config.Coords[i].x,Config.Coords[i].y,Config.Coords[i].z)) <= 2.0 then
                if not AlreadyOpen then
                    sleep = 0
                    DrawText3D("~INPUT_PICKUP~ - Market", vector3(Config.Coords[i].x,Config.Coords[i].y,Config.Coords[i].z))
                    if IsControlJustReleased(0, 38) then
                        OpenUI()
                        AlreadyOpen = true
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

function OpenUI()
    SendNUIMessage({
        action = "OpenUI",
        data = Config.Items,
        inventoryimg = Config.InventoryIMG
    })
    SetNuiFocus(true, true)
end

RegisterNUICallback('Pay', function(data, cb)
    TriggerServerEvent('oph3z-market:BuyItem', data)
end)

RegisterNUICallback('CloseUI', function()
    SetNuiFocus(false, false)
    AlreadyOpen = false
end)

DrawText3D = function (msg, coords)
    AddTextEntry('esxFloatingHelpNotification', msg)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('esxFloatingHelpNotification')
    EndTextCommandDisplayHelp(2, false, false, -1)
end