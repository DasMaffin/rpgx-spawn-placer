ABOVE = true
BELOW = false
RPGXSP.Settings = {
    SelectedNPCs = {},      -- Table of selected NPC class names to spawn
    SelectedHive = {},      -- Table of selected Hive props to spawn
    aboveOrBelow = ABOVE,   -- Do monsters spawn above or below the spawn point? Above if placed on the ground. Below if placed on the ceiling.
    levelMin = 1,           -- Minimum level for spawned monsters
    levelMax = 5,           -- Maximum level for spawned monsters
    spawnInterval = 10,     -- Time (in seconds) to respawn monsters
}