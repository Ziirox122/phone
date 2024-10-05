RegisterNUICallback('Services', function(data, cb)
    if data.action == 'getCompany' then
        FB.TriggerServerCallback('fb:phone:getCompanyData', cb)
    elseif data.action == 'toggleDuty' then
        FB.ShowNotification('~r~Not implemented')
        -- TODO
    elseif data.action == 'hireEmployee' then
        FB.ShowNotification('~r~Not implemented')
        -- TODO
    elseif data.action == 'setGrade' then
        FB.ShowNotification('~r~Not implemented')
        -- TODO
    elseif data.action == 'fireEmployee' then
        FB.ShowNotification('~r~Not implemented')
        -- TODO
    elseif data.action == 'getMessages' then
        CB.TriggerServerCallback('phone:services:getMessages', function(data)
            cb(data)
        end, data.id, data.page, data.company)
    elseif data.action == 'sendMessage' then
        CB.TriggerServerCallback('phone:services:sendMessage', function(data)
            cb(data)
        end, data.id, data.company, data.content)
    elseif data.action == 'getCompanies' then
        CB.TriggerServerCallback('phone:services:getOnline', function(data)
            cb(data)
        end, data)
    elseif data.action == 'getChannelId' then
        CB.TriggerServerCallback('phone:services:getChannelId', function(data)
            cb(data)
        end, data.company)
    elseif data.action == 'getRecentMessages' then
        CB.TriggerServerCallback('phone:services:getRecentMessages', function(data)
            cb(data)
        end, data.page)
    end
end)

RegisterNetEvent('phone:services:newMessage', function(data)
    SendReactMessage('services:newMessage', data)
end)