
RegisterNUICallback('Weather', function(data, cb)
    if data.action == 'getData' then
        local background = 'sunset'
        local icon = 'night'
        local temperature = -1

        local Weather = 'EXTRASUNNY'
        local isNight = GlobalState.TimeHour >= 21 and GlobalState.TimeHour <= 5
        local snowy = Weather:find('SNOWLAYER') or Weather == 'XMAS' or Weather == 'SNOWLIGHT'
        local sunny = Weather == 'EXTRASUNNY' or Weather == 'CLEAR' or Weather == 'NEUTRAL'

        if isNight then
            background = 'night'
            icon = 'night'
        elseif sunny then
            background = 'sunny'
            icon = 'sunny'
        end

        if snowy then
            background = 'snow'
            icon = 'snow'
            temperature = math.random(10, 15)
        end

        if Weather == 'CLEARING' or Weather == 'RAIN' then
            background = 'rain'
            icon = 'rain'
        end

        if not isNight and (Weather == 'SMOG' or Weather == 'FOGGY' or Weather == 'CLOUDS') then
            background = 'cloudy'
        end

        if Weather == 'THUNDER' then
            icon = 'thunder'
        elseif Weather == 'BLIZZARD' then
            icon = 'tornado'
        elseif not isNight and (Weather == 'SMOG' or Weather == 'FOGGY' or Weather == 'CLOUDS') then
            icon = 'partly-cloudy-sunny'
        elseif isNight and (Weather == 'SMOG' or Weather == 'FOGGY' or Weather == 'CLOUDS') then
            icon = 'partly-cloudy-night'
        elseif Weather == 'SMOG' or Weather == 'FOGGY' or Weather == 'OVERCAST' then
            icon = 'fog'
        elseif Weather == 'CLEARING' then
            icon = 'drizzle'
        end

        cb({
            background = background,
            icon = icon,
            temperature = temperature,
        })
    end
end)