
RegisterNUICallback('Tinder', function(data, cb)
    if data.action == 'isLoggedIn' then
        CB.TriggerServerCallback('phone:tinder:isLoggedIn', function(data)
            cb(data)
        end)
    elseif data.action == 'getFeed' then
        CB.TriggerServerCallback('phone:tinder:getFeed', function(data)
            cb(data)
        end, data.page)
    elseif data.action == 'swipe' then
        CB.TriggerServerCallback('phone:tinder:swipe', function(data)
            cb(data)
        end, data.number, data.like)
    elseif data.action == 'sendMessage' then
        CB.TriggerServerCallback('phone:tinder:sendMessage', function(data)
            cb(data)
        end, data.data.recipient, data.data.content, data.data.attachments)
    elseif data.action == 'createAccount' then
        CB.TriggerServerCallback('phone:tinder:createAccount', function(data)
            cb(data)
        end, data.data)
    elseif data.action == 'saveProfile' then
        CB.TriggerServerCallback('phone:tinder:updateAccount', function(data)
            cb(data)
        end, data.data)
    elseif data.action == 'getMessages' then
        CB.TriggerServerCallback('phone:tinder:getMessages', function(data)
            cb(data)
        end, data.number, data.page)
    elseif data.action == 'getMatches' then
        CB.TriggerServerCallback('phone:tinder:getMatches', function(data)
            cb(data)
        end)
    elseif data.action == 'deleteAccount' then
        CB.TriggerServerCallback('phone:tinder:deleteAccount', function(data)
            cb(data)
        end)
    end
end)


RegisterNetEvent('phone:tinder:receiveMessage', function(data)
    SendReactMessage("tinder:newMessage", data)
end)
