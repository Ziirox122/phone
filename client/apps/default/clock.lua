RegisterNUICallback('Clock', function(data, cb)
    if data.action == 'getAlarms' then
        CB.TriggerServerCallback('phone:clock:getAlarms', function(alarms)
            cb(alarms)
        end)
    elseif data.action == 'createAlarm' then
        CB.TriggerServerCallback('phone:clock:createAlarm', function(createdAlarm)
            cb(createdAlarm)
        end, data.label, data.hours, data.minutes)
    elseif data.action == 'deleteAlarm' then
        CB.TriggerServerCallback('phone:clock:deleteAlarm', function(success)
            cb(success)
        end, data.id)
    end
end)