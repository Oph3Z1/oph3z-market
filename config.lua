Config = {}

Config.Framework = "newqb" -- newqb, oldqb, newesx, oldesx
Config.InventoryIMG = 'ps-inventory/html/images'

Config.Items = {
    {name = 'bread', label = 'Bread', price = 10},
    {name = 'weapon_pistol', label = 'Pistol', price = 10},
}

Config.Coords = {
    vector3(25.75, -1347.36, 29.5),
    vector3(373.83, 326.24, 103.57),
}

Config.Notification = function(msg, type, src)
    if Config.Framework == 'newqb' or Config.Framework == 'oldqb' then
        TriggerClientEvent('QBCore:Notify', src, msg, type, 3000)
    else
        TriggerClientEvent('esx:showNotification', src, msg)
    end
end