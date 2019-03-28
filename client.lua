local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

local PlayerData              = {}
local blackon = true
Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end

    while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end) 

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(8)
        local coords = GetEntityCoords(PlayerPedId())
        local dist = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, 2577.81, 4675.65, 34.08, true)
  
        if dist < 15 then
          DrawMarker(27,2577.81, 4675.65, 33.1 , 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 246, 255, 0, 200, 0, 0, 0, 0)
        end
        if dist < 15 then
          show3dtext(2577.81, 4675.65, 34.08, tostring("Tryck ~r~E~w~ för att öppna svartamarknaden."))
        end
        if dist < 1.3 and IsControlPressed(0, Keys['E']) then
            OpenWeaponMenu()
        end
    end
end)
  
function show3dtext(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.5*scale, 0.5*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150) 
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function OpenWeaponMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weamenu',
    {
        title = 'Svartamarknaden',
        align = 'top-right',
        elements = {
            {label = 'Kniv <span style="color: green;">4567 SEK</span>', value = 'kniv'},
            {label = 'AK 47 <span style="color: green;">45670000 SEK</span>', value = 'ak'},
            {label = 'Handcuffs <span style="color: green;">45670000 SEK</span>', value = 'cuffs'},
        }
    },
    function(data, menu)
        menu.close()
        blackon = true
        local action = data.current.value
        
        if action == 'kniv' then
            TriggerServerEvent('buyWeapon', 'WEAPON_KNIFE', 4567, 1)
        elseif action == 'ak' then
            TriggerServerEvent('buyWeapon', 'WEAPON_ASSAULTRIFLE', 45670000, 5)
        elseif action == 'cuffs' then
            TriggerServerEvent('buyItem', 'handcuffs', 200000, 1) -- handcuffs är itemet, 20000 är vad de ska kosta, 1 är antalet
        end
    end,
    function(data, menu)
        menu.close()
        blackon = true
    end
    )
end


