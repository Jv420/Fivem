local prefixes = { 'NL', 'DZ', 'GR', 'DR', 'FR' }

local function randomPlate()
    local p = prefixes[math.random(#prefixes)]
    return string.format('%s-%02d-%s%s%s', p, math.random(10,99), string.char(math.random(65,90)), string.char(math.random(65,90)), string.char(math.random(65,90)))
end

exports('GenerateDutchPlate', randomPlate)

RegisterCommand('kenteken', function()
    lib.notify({ title = 'Kenteken', description = randomPlate(), type = 'inform' })
end)
