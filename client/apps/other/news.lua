
RegisterNUICallback('News', function(data, cb)
    FB.TriggerServerCallback('fb:ads:getAds', function(data)
        cb(data)
    end, data.query or data.page)
end)