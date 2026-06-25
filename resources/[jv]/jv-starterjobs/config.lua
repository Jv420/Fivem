Config = {}

Config.Jobs = {
    garbage = {
        label = 'Vuilnisman',
        reward = { min = 350, max = 850 },
        start = vector3(-321.75, -1545.84, 31.02),
        spots = {
            vector3(-349.18, -1569.89, 25.22),
            vector3(-158.18, -1450.22, 31.14),
            vector3(126.49, -1053.31, 29.19)
        }
    },
    taxi = {
        label = 'Taxi',
        reward = { min = 250, max = 750 },
        start = vector3(903.22, -170.36, 74.08),
        spots = {
            vector3(313.49, -1465.46, 29.97),
            vector3(-1034.61, -2733.61, 20.17),
            vector3(1853.85, 2586.05, 45.67)
        }
    },
    delivery = {
        label = 'Bezorger',
        reward = { min = 300, max = 900 },
        start = vector3(78.94, 111.87, 81.17),
        spots = {
            vector3(8.92, -243.19, 47.66),
            vector3(-561.69, 286.91, 82.18),
            vector3(1151.74, -1529.58, 35.37)
        }
    }
}
