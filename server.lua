ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('buyWeapon')
AddEventHandler('buyWeapon', function(weapon, price, ammo)

    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.getMoney() >= price then
        xPlayer.addWeapon(weapon, ammo)
        xPlayer.removeMoney(price)
    else
        local slutcash = price - xPlayer.getMoney()
        TriggerEvent("pNotify:SendNotification", {text = "De saknas " .. slutcash .. "Kr", type = "success", timeout = 5100, layout = "BottomCenter"})
    end
end)

RegisterServerEvent('buyItem')
AddEventHandler('buyItem', function(item, price, qtty)

    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.getMoney() >= price then
        xPlayer.addInventoryItem(item, qtty)
        xPlayer.removeMoney(price)
    else
        local slutcash = price - xPlayer.getMoney()
        TriggerEvent("pNotify:SendNotification", {text = "De saknas " .. slutcash .. "Kr", type = "success", timeout = 5100, layout = "BottomCenter"})
    end
end)