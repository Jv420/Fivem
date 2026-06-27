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
    local formats = Config.Formats or { 'XX999X', '99XXX9', 'XXX999' }
    local plate = applyFormat(formats[math.random(#formats)])

    if #plate > 8 then
        plate = plate:sub(1, 8)
    end

    return plate:upper()
end

local function setVehiclePlate(vehicle, plate)
    if not vehicle or vehicle == 0 then return false end
    SetVehicleNumberPlateText(vehicle, plate)
    return true
end

exports('GenerateDutchPlate', generateDutchPlate)
exports('SetVehicleDutchPlate', setVehiclePlate)

RegisterNetEvent('delfzijl_nlplates:setVehiclePlate', function(plate)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)

    if vehicle == 0 then
        lib.notify({ title = 'Kenteken', description = 'Je zit niet in een voertuig.', type = 'error' })
        return
    end

    plate = plate or generateDutchPlate()
    setVehiclePlate(vehicle, plate)

    lib.notify({ title = 'Kenteken', description = 'Kenteken ingesteld: ' .. plate, type = 'success' })
end)

RegisterCommand(Config.GenerateCommand or 'genplate', function()
    local plate = generateDutchPlate()
    lib.notify({ title = 'Kenteken generator', description = plate, type = 'inform' })
end, false)

RegisterCommand(Config.ApplyToCurrentVehicleCommand or 'setnlplate', function(_, args)
    local customPlate = args[1]

    if customPlate and #customPlate > 8 then
        customPlate = customPlate:sub(1, 8)
    end

    TriggerEvent('delfzijl_nlplates:setVehiclePlate', customPlate or generateDutchPlate())
end, false)

CreateThread(function()
    Wait(1000)
    print('[Delfzijl RP] Nederlandse kenteken generator geladen')
end)
