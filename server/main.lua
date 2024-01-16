frameworkObject = nil

Citizen.CreateThread(function()
    frameworkObject, Config.Framework = GetCore()
end)

RegisterNetEvent('oph3z-market:BuyItem', function(data)
    local src = source

    if Config.Framework == 'newqb' or Config.Framework == 'oldqb' then
        local Player = frameworkObject.Functions.GetPlayer(src)
        local PlayerMoney = Player.PlayerData.money.bank
        if tonumber(PlayerMoney) > tonumber(data.price) then
            Player.Functions.RemoveMoney('bank', tonumber(data.price))
            Player.Functions.AddItem(data.name, data.count)
        else
            Config.Notification("You don't have enough money to but this", 'error', src)
        end
    else
        local Player = frameworkObject.GetPlayerFromId(src)
        local PlayerMoney = Player.getMoney()
        if tonumber(PlayerMoney) > tonumber(data.price) then
            Player.removeAccountMoney('bank', tonumber(data.price))
            Player.addInventoryItem(data.name, data.count)
        else
            Config.Notification("You don't have enough money to but this", 'error', src)
        end
    end
end)