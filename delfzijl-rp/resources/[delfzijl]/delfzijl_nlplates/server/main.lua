local function randomLetter()
    return string.char(math.random(65, 90))
end

local function randomNumber()
    return tostring(math.random(0, 9))
end

local function applyFormat(format)
    local plate = ''

    for i = 1, #format do
        local char = format:sub(i, i)
        if char == 'X' then
            plate = plate .. randomLetter()
        elseif char == '9' then
            plate = plate .. randomNumber()
        else
            plate = plate .. char
        end
    end

    return plate
end

local function generateDutchPlate()
    math.randomseed(os.time() + math.random(1000, 9999))
    local formats = Config.Formats or { 'XX999X', '99XXX9', 'XXX999' }
    local plate = applyFormat(formats[math.random(#formats)])

    if #plate > 8 then
        plate = plate:sub(1, 8)
    end

    return plate:upper()
end

exports('GenerateDutchPlate', generateDutchPlate)

lib.callback.register('delfzijl_nlplates:generate', function()
    return generateDutchPlate()
end)

RegisterNetEvent('delfzijl_nlplates:requestSetPlate', function()
    local src = source
    TriggerClientEvent('delfzijl_nlplates:setVehiclePlate', src, generateDutchPlate())
end)

print('[Delfzijl RP] Nederlandse kenteken server geladen')
