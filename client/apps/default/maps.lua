RegisterNUICallback('Maps', function(data, cb)
    if data.action == 'getCurrentLocation' then
        if data.isGps then
            if IsWaypointActive() then
                cb({
                    x = GetBlipInfoIdCoord(GetFirstBlipInfoId(8)).x,
                    y = GetBlipInfoIdCoord(GetFirstBlipInfoId(8)).y,
                })
            else
                cb(false)
            end
        else
            cb({
                x = GetEntityCoords(PlayerPedId()).x,
                y = GetEntityCoords(PlayerPedId()).y,
            })
        end
    elseif data.action == 'setWaypoint' then
        SetNewWaypoint(tonumber(data.data.x), tonumber(data.data.y))
        FB.ShowNotification('~g~Position marquée sur la carte')
        cb(true)
    end
end)