CB = {}
CB.TimeoutCount = -1
CB.CancelledTimeouts = {}

CB.SetTimeout = function(msec, cb)
	local id = CB.TimeoutCount + 1

	SetTimeout(msec, function()
		if CB.CancelledTimeouts[id] then
			CB.CancelledTimeouts[id] = nil
		else
			cb()
		end
	end)

	CB.TimeoutCount = id

	return id
end

CB.ClearTimeout = function(id)
	CB.CancelledTimeouts[id] = true
end

if IsDuplicityVersion() then-- SERVER CALLBACKS
    CB.ServerCallbacks = {}

    CB.RegisterServerCallback = function(name, cb)
        CB.ServerCallbacks[name] = cb
    end

    local TriggerServerCallback = function(name, source, cb, ...)
        local phoneNumber = exports.fb:getPhoneNumber(source)

        if CB.ServerCallbacks[name] then
            CB.ServerCallbacks[name](source, phoneNumber, cb, ...)
        else
            print(('Server callback "%s" does not exist. Make sure that the server sided file really is loading, an error in that file might cause it to not load.'):format(name))
        end
    end

    RegisterNetEvent('fb-phone:cb:triggerServerCallback', function(name, requestId, ...)
        local source = source
        TriggerServerCallback(name, source, function(...)
            TriggerClientEvent('fb-phone:cb:serverCallback:' .. name .. ':' .. requestId, source, ...)
        end, ...)
    end)
else
    local ServerCBCurrentRequestId = 0

    CB.TriggerServerCallback = function(name, cb, ...)
        TriggerServerEvent('fb-phone:cb:triggerServerCallback', name, ServerCBCurrentRequestId, ...)

        local eventHandler = nil
        local timeout = nil

        eventHandler = RegisterNetEvent('fb-phone:cb:serverCallback:' .. name .. ':' .. ServerCBCurrentRequestId, function(...)
            RemoveEventHandler(eventHandler)
            CB.ClearTimeout(timeout)
            if not cb then return end
            cb(...)
            cb = nil
        end)

        timeout = CB.SetTimeout(1000 * 10, function()
            cb = nil
            RemoveEventHandler(eventHandler)
            eventHandler = nil
            timeout = nil
        end)

        if ServerCBCurrentRequestId < 65535 then
            ServerCBCurrentRequestId = ServerCBCurrentRequestId + 1
        else
            ServerCBCurrentRequestId = 0
        end
    end

    CB.TriggerServerCallbackSync = function(name, cb, ...)
        local values = nil

        CB.TriggerServerCallback(name, function(...)
            values = {...}
        end, ...)

        repeat Wait(0) until values

        return table.unpack(values)
    end

end