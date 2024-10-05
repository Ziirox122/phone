
RegisterNUICallback('Notes', function(data, cb)
    if data.action == 'fetch' then
        CB.TriggerServerCallback('phone:notes:fetchNotes', function(returnedData)
            cb(returnedData)
        end, data)
    elseif data.action == 'create' then
        CB.TriggerServerCallback('phone:notes:createNote', function(returnedData)
            cb(returnedData)
        end, data.data.title, data.data.content, data.data.timestamp)
    elseif data.action == 'save' then
        TriggerServerEvent('phone:notes:saveNote', data.data.id, data.data.title, data.data.content)
    elseif data.action == 'remove' then
        TriggerServerEvent('phone:notes:removeNote', data.id)
    end
end)