local CachedXEstatesData = {}

RegisterNUICallback("Home", function(data, cb)
    local action = data.action

    if action == "getHomes" then
        FB.TriggerServerCallback('fb:estate:getMyEstates', function(xEstatesData)
            CachedXEstatesData = xEstatesData
            cb(xEstatesData)
        end)
    elseif action == 'toggleLocked' then
        TriggerServerEvent('fb:estate:toggleDoorLock', data.id)
    elseif action == "setWaypoint" then
        FB.TriggerServerCallback('fb:estate:getPositions', function(results)
            for _, position in pairs(results) do
                SetNewWaypoint(tonumber(position.x), tonumber(position.y))
            end
            FB.ShowNotification('~g~Position marquée sur la carte')
            cb('ok')
        end, data.id)
    elseif action == 'changeAccountId' then
        TriggerServerEvent('fb:estate:changeAccountId', data.id)
    elseif action == 'giveOwnership' then
        TriggerServerEvent('fb:estate:giveOwnership', data.id)
    end
end)