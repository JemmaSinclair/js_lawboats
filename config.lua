-- Define multiple points with their respective jobs, radii, and boat spawn details
Config = {
    Points = {
        { -- Saint Denis
            Location = vector3(2950.16, -1251.16, 42.42), -- Replace with your first location
            Radius = 3.0, -- Radius for this point
            RequiredJobs = { "sheriffea", "sheriffwe", "ranger" }, -- Jobs required for this point
            Text = "~color_yellow~Press ~color_green~[G] ~color_yellow~to spawn a Sheriff boat!", -- Custom text for this point
            BoatSpawn = {
                Model = "boatsteam02x", -- Model name of the boat to spawn
                SpawnCoords = vector3(2946.59, -1256.07, 40.33), -- Boat spawn location
                Heading = 276.29 -- Heading for the boat
            }
        },
        { -- Sisika
            Location = vector3(3266.56, -716.11, 42.04), -- Replace with your first location
            Radius = 3.0, -- Radius for this point
            RequiredJobs = { "sheriffea", "sheriffwe", "ranger" }, -- Jobs required for this point
            Text = "~color_yellow~Press ~color_green~[G] ~color_yellow~to spawn a Sheriff boat!", -- Custom text for this point
            BoatSpawn = {
                Model = "boatsteam02x", -- Model name of the boat to spawn
                SpawnCoords = vector3(3263.7, -715.93, 40.3), -- Boat spawn location
                Heading = 11.52 -- Heading for the boat
            }
        },
        { -- Sisika
            Location = vector3(-681.85, -1244.85, 43.12), -- Replace with your first location
            Radius = 3.0, -- Radius for this point
            RequiredJobs = { "sheriffea", "sheriffwe", "ranger" }, -- Jobs required for this point
            Text = "~color_yellow~Press ~color_green~[G] ~color_yellow~to spawn a Sheriff boat!", -- Custom text for this point
            BoatSpawn = {
                Model = "boatsteam02x", -- Model name of the boat to spawn
                SpawnCoords = vector3(-683.95, -1248.64, 40.32), -- Boat spawn location
                Heading = 292.38 -- Heading for the boat
            }
        }
    },
    Debug = false
}


