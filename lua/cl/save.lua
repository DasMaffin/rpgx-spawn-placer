hook.Add("RPGXSP_SaveSpawnPoints", "SaveSpawnPoints", function()
    print("Saving spawn points to file...")
    local spawnPoints = {}
    spawnPoints[game.GetMap()] = {}
    for _, ent in pairs(ents.FindByClass("point_marker")) do
        local pos = ent:GetPos()
        local spawnPoint = {
            position = {x = pos.x, y = pos.y, z = pos.z},
            settings = ent.Settings
        }
        table.insert(spawnPoints[game.GetMap()], spawnPoint)
    end
    if not file.Exists("rpgxspawnpoints", "DATA") then
        file.CreateDir("rpgxspawnpoints")
    end
    local jsonData = util.TableToJSON(spawnPoints, true)
    file.Write("rpgxspawnpoints/spawnpoints.json", jsonData)
    print("Spawn points saved to rpgxspawnpoints/spawnpoints.json")
end)