RegisterNUICallback('Notifications', function(data, cb)
    if data.action == 'clearNotifications' then
        TriggerServerEvent('phone:clearNotifications', data.app)
        cb('ok')
    elseif data.action == 'clearAllNotifications' then
        TriggerServerEvent('phone:clearAllNotifications')
        cb('ok')
    elseif data.action == 'deleteNotification' then
        CB.TriggerServerCallback('phone:deleteNotification', function(returnedData)
            cb(returnedData)
        end, data.id)
    elseif data.action == 'getNotifications' then
        CB.TriggerServerCallback('phone:getNotifications', function(returnedData)
            cb(returnedData)
        end)
    end
end)

RegisterNetEvent('phone:sendNotification', function(data)
    SendReactMessage('newNotification', data)
end)