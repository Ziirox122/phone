local GetHeadblendFormatted = function()
    local headblend = nil
    local view = DataView.ArrayBuffer(512)

    if Citizen.InvokeNative(0x2746BD9D88C5C5D0, PlayerPedId(), view:Buffer(), Citizen.ReturnResultAnyway()) then
        headblend = {
            shapeFirst = view:GetInt32(0),
            shapeSecond = view:GetInt32(8),
            shapeThird = view:GetInt32(16),
            skinFirst = view:GetInt32(24),
            skinSecond = view:GetInt32(32),
            skinThird = view:GetInt32(40),
            shapeMix = view:GetFloat32(48),
            skinMix = view:GetFloat32(56),
            thirdMix = view:GetFloat32(64),
            hasParent = true,
        }
    end

    if headblend then
        return headblend.shapeFirst .. '|' .. headblend.shapeSecond .. '|' .. math.ceil(headblend.shapeMix*100) .. '|' .. headblend.skinFirst .. '|' .. headblend.skinSecond
    else
        return GetEntityModel(PlayerPedId())
    end
end

local cachedFace = nil

RegisterNetEvent('fb-phone:setPhone', function()
    cachedFace = nil
end)

RegisterNUICallback('Security', function(data, cb)
    if data.action == 'verifyFace' then
        if GetPedDrawableVariation(PlayerPedId(), 1) > 0 then
            return cb(false)
        end

        local headblend = GetHeadblendFormatted()

        if cachedFace and headblend == cachedFace then
            return cb(cachedFace == headblend)
        end

        CB.TriggerServerCallback('phone:security:verifyFace', function(faceId)
            cachedFace = faceId
            cb(faceId == headblend)
        end, data)
    elseif data.action == 'verifyPin' then
        CB.TriggerServerCallback('phone:security:verifyPin', function(data)
            cb(data)
        end, data.pin)
    elseif data.action == 'setPin' then
        cachedFace = nil
        CB.TriggerServerCallback('phone:security:setPin', function(data)
            cb(data)
        end, data.pin, data.oldPin)
    elseif data.action == 'setFaceId' then
        cachedFace = nil
        CB.TriggerServerCallback('phone:security:setFaceId', function(data)
            cb(data)
        end, data.pin, GetHeadblendFormatted())
    elseif data.action == 'removeFaceId' then
        cachedFace = nil
        CB.TriggerServerCallback('phone:security:setFaceId', function(data)
            cb(data)
        end, data.pin, nil)
    elseif data.action == 'removePin' then
        CB.TriggerServerCallback('phone:security:setPin', function(data)
            cb(data)
        end, nil, data.oldPin)
    elseif data.action == 'factoryReset' then
        TriggerServerEvent('phone:factoryReset')
    elseif data.action == 'ejectSim' then
        TriggerServerEvent('fb:simcard:ejectSim')
    end
end)


RegisterNetEvent('phone:factoryReset', function(...)
end)

RegisterNetEvent('phone:security:reset', function(...)
end)