local Core = exports.vorp_core:GetCore()

RegisterNetEvent("lawBoats:VerifyJob")
AddEventHandler("lawBoats:VerifyJob", function(pointIndex)
    local src = source
    local point = Config.Points[pointIndex]
    if not point then return end

    local user = Core.getUser(src) -- Get the player object
    if not user then
        
        debugprint("[js_lawboats] No user found for source:", src)
        return -- Player is not in session or invalid
    end

    local character = user.getUsedCharacter --[[@as Character]]
    if not character then
        debugprint("[js_lawboats] No character found for user:", src)
        TriggerClientEvent("lawBoats:Clear3DText", src, pointIndex)
        return -- Character is not set
    end

    local job = character.job -- Get the character's job
    for _, validJob in ipairs(point.RequiredJobs) do
        if job == validJob then
            TriggerClientEvent("lawBoats:Render3DText", src, pointIndex) -- Render text for this player
            return
        end
    end

    TriggerClientEvent("lawBoats:Clear3DText", src, pointIndex)
    debugprint("[js_lawboats] Player does not meet the job requirements. Job:", job)
end)

RegisterNetEvent("lawBoats:SpawnBoat")
AddEventHandler("lawBoats:SpawnBoat", function(pointIndex)
    local src = source
    local point = Config.Points[pointIndex]
    if not point then return end

    local spawnInfo = point.BoatSpawn
    if not spawnInfo then return end

    local user = Core.getUser(src)
    if not user then return end

    local character = user.getUsedCharacter
    if not character then return end

    local job = character.job
    for _, validJob in ipairs(point.RequiredJobs) do
        if job == validJob then
            -- Spawn the boat
            TriggerClientEvent("lawBoats:CreateBoat", src, spawnInfo.Model, spawnInfo.SpawnCoords, spawnInfo.Heading)
            return
        end
    end
end)

function debugprint(message, src)
if Config.Debug == true then
    print(message, src)
end
end

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    if Config.Debug == true then
        print("[js_lawboats] Debug logging has been enabled.  This will spam the console when a player is within the configured radius of a point and has the wrong job!")
    end
  end)
  