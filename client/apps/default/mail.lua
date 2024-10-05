
RegisterNUICallback('Mail', function(data, cb)
    if data.action == 'getMail' then
        CB.TriggerServerCallback('phone:mail:getMail', function(returnedData)
            cb(returnedData)
        end, data.id)
    elseif data.action == 'isLoggedIn' then
        CB.TriggerServerCallback('phone:mail:isLoggedIn', function(returnedData)
            cb(returnedData)
        end)
    elseif data.action == 'getMails' then
        CB.TriggerServerCallback('phone:mail:getMails', function(returnedData)
            cb(returnedData)
        end, data.page)
    elseif data.action == 'search' then
        CB.TriggerServerCallback('phone:mail:search', function(returnedData)
            cb(returnedData)
        end, data.query, data.page)
    elseif data.action == 'logout' then
        CB.TriggerServerCallback('phone:mail:logout', function(returnedData)
            cb(returnedData)
        end)
    elseif data.action == 'sendMail' then
        CB.TriggerServerCallback('phone:mail:sendMail', function(mailId)
            cb(mailId)
        end, data.data)
    elseif data.action == 'login' then
        CB.TriggerServerCallback('phone:mail:login', function(returnedData)
            cb(returnedData)
        end, data.data.email, data.data.password)
    elseif data.action == 'createMail' then
        CB.TriggerServerCallback('phone:mail:createAccount', function(returnedData)
            cb(returnedData)
        end, data.data.email, data.data.password)
    elseif data.action == 'action' then
        -- TODO
    end
end)


RegisterNetEvent('phone:mail:newMail', function(data)
    SendReactMessage('mail:newMail', data)
end)