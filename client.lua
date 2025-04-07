local spawnedBoat = nil



-- Function to draw 3D text
local function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextColor(255, 255, 255, 255)
        SetTextCentre(true)
        DisplayText(CreateVarString(10, "LITERAL_STRING", text), _x, _y)
    end
end

local activePoints = {}

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for i, point in ipairs(Config.Points) do
            local inRadius = #(playerCoords - point.Location) < point.Radius

            if inRadius then
                if not activePoints[i] then
                    TriggerServerEvent("lawBoats:VerifyJob", i)
                end
            else
                if activePoints[i] then
                    activePoints[i] = nil
                    TriggerEvent("lawBoats:Clear3DText", i)
                end
            end
        end

        Citizen.Wait(500) -- Check every half second
    end
end)

RegisterNetEvent("lawBoats:Render3DText")
AddEventHandler("lawBoats:Render3DText", function(pointIndex)
    activePoints[pointIndex] = true
    local point = Config.Points[pointIndex]

    Citizen.CreateThread(function()
        while activePoints[pointIndex] do
            Citizen.Wait(0)
            DrawText3D(point.Location.x, point.Location.y, point.Location.z, point.Text)

            -- Check if the player presses G to spawn the boat
            if IsControlJustReleased(0, 0x760A9C6F) then -- [G]
                if spawnedBoat == nil then
                TriggerServerEvent("lawBoats:SpawnBoat", pointIndex)
                else
                    TriggerEvent("chat:addMessage", {
                        args = { "[Boat Manager]", "You already have a boat!" }
                    }) 
                end
            end
        end
    end)
end)

RegisterNetEvent("lawBoats:Clear3DText")
AddEventHandler("lawBoats:Clear3DText", function(pointIndex)
    activePoints[pointIndex] = nil
end)


RegisterNetEvent("lawBoats:CreateBoat")
AddEventHandler("lawBoats:CreateBoat", function(model, spawnCoords, heading)
    local modelHash = GetHashKey(model)
    
    -- Request and load the boat model
    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(0)
        end
    end

    -- Create the boatd
    local boat = CreateVehicle(modelHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, heading, true, false)


    -- Store the spawned boat
    spawnedBoat = boat

    -- Clean up the model
    SetModelAsNoLongerNeeded(modelHash)
end)

RegisterCommand("dismissboat", function()
    if spawnedBoat and DoesEntityExist(spawnedBoat) then
        DeleteEntity(spawnedBoat) -- Delete the boat
        spawnedBoat = nil
        TriggerEvent("chat:addMessage", {
            args = { "[Sheriff Dock]", "Your boat has been dismissed." }
        })
    else
        TriggerEvent("chat:addMessage", {
            args = { "[Sheriff Dock]", "You don't have a boat to dismiss." }
        })
    end
end, false)

AddEventHandler('playerDropped', function (reason)
    DeleteEntity(spawnedBoat)
  end)

RegisterCommand("fixboat", function()
if DoesEntityExist(spawnedBoat) then
    TriggerEvent("chat:addMessage", {
        args = { "[Sheriff Dock]", "Your boat is fine!  Use /dismissboat to remove it!" }
    })
else
    spawnedBoat = nil
    TriggerEvent("chat:addMessage", {
        args = { "[Sheriff Dock]", "You may now spawn a new boat!  Do not abuse this!" }
    })
end
end, false)