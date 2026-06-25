Config = {}
Config.Locale = 'nl'
Config.ServerName = 'Delfzijl RP'
Config.Debug = false

Config.Routes = {
    Weed = {
        gather = vec3(2220.0, 5577.0, 53.8),
        process = vec3(1039.0, -3205.0, -38.2),
        sell = vec3(-1172.0, -1572.0, 4.6)
    },
    Coke = {
        gather = vec3(1389.0, 3604.0, 38.9),
        process = vec3(1093.0, -3196.0, -38.9),
        sell = vec3(243.0, 370.0, 105.7)
    },
    Wash = {
        location = vec3(1135.0, -989.0, 46.1),
        feePercent = 25
    }
}
