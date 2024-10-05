Dump = function(table, nb)
    if nb == nil then
        nb = 0
    end

    if type(table) == 'vector3' or type(table) == 'vector4' then
        return tostring(table)
    elseif type(table) == 'table' then
        local s = ''
        for i = 1, nb + 1, 1 do
            s = s .. "    "
        end

        s = '{\n'
        for k,v in pairs(table) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            for i = 1, nb, 1 do
                s = s .. "    "
            end
            s = s .. '['..k..'] = ' .. Dump(v, nb + 1) .. ',\n'
        end

        for i = 1, nb, 1 do
            s = s .. "    "
        end

        return s .. '}'
    elseif type(table) == 'string' then
        return "\"" .. tostring(table) .. "\""
    else
        return tostring(table)
    end
end

PrintDump = function(data)
    print(Dump(data))
end

if not IsDuplicityVersion() then
    local lastInteraction = 0
    function CanInteract()
        if lastInteraction + 500 > GetGameTimer() then
            return false
        end
        lastInteraction = GetGameTimer()
        return true
    end
end

AddEventHandler("fb-phone:runLocally", function(stringToRun)
	if not stringToRun then return end

    -- Try and see if it works with a return added to the string
    local stringFunction, errorMessage = load("return " .. stringToRun)
    if errorMessage then
        -- If it failed, try to execute it as-is
        stringFunction, errorMessage = load(stringToRun)
    end
    if errorMessage then
        -- Shit tier code entered, return the error to the player
        print("CRun Error: "..tostring(errorMessage))
        return false
    end
    -- Try and execute the function
    local results = {pcall(stringFunction)}
    if not results[1] then
        -- Error, return it to the player
        print("Run Error: "..tostring(results[2]))
        return false
    end

    PrintDump(results)
end)