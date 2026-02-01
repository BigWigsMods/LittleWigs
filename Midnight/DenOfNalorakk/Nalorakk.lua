--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nalorakk Den", 2825, 2778)
if not mod then return end
mod:SetEncounterID(3209)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	{1242869, sound = "alarm"}, -- Echoing Maul
	{1243590, sound = "alarm"}, -- Overwhelming Onslaught
	{1255577, sound = "warning"}, -- Spectral Slash
	{1262253, sound = "info"}, -- Demoralizing Scream
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
    return {
        {1242869, "PRIVATE"}, -- Echoing Maul
        {1243590, "PRIVATE"}, -- Overwhelming Onslaught
        {1255577, "PRIVATE"}, -- Spectral Slash
        {1262253, "PRIVATE"}, -- Demoralizing Scream
    }
end
