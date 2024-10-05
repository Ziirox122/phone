local cachedLikes = {}

RegisterNUICallback('Music', function(data, cb)
    if data.action == 'removeSong' then
        CB.TriggerServerCallback('phone:music:removeSong', function(data)
            cb(data)
        end, data.id, data.song)
    elseif data.action == 'getConfig' then
        FB.TriggerServerCallback('fb:music:getConfig', function(data)
            cb(data)
        end, data)
    elseif data.action == 'getPlaylists' then
        CB.TriggerServerCallback('phone:music:getPlaylists', function(data)
            cb(data)
        end, data)
    elseif data.action == 'createPlaylist' then
        CB.TriggerServerCallback('phone:music:createPlaylist', function(data)
            cb(data)
        end, data.name)
    elseif data.action == 'deletePlaylist' then
        CB.TriggerServerCallback('phone:music:deletePlaylist', function(data)
            cb(data)
        end, data.id)
    elseif data.action == 'addSong' then
        CB.TriggerServerCallback('phone:music:addSong', function(data)
            cb(data)
        end, data.id, data.song)
    elseif data.action == 'viewed' then
        TriggerServerEvent('fb:music:viewed', data.songId)
    elseif data.action == 'like' then
        cachedLikes[data.songId] = data.like
        TriggerServerEvent('fb:music:like', data.songId, data.like)
    elseif data.action == 'isLiked' then
        if cachedLikes[data.songId] then return cb(cachedLikes[data.songId]) end
        CB.TriggerServerCallback('phone:music:isLiked', function(like)
            cachedLikes[data.songId] = like
            cb(like)
        end, data.songId)
    end
end)