--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lithiel Cinderfury", 2813, 2682)
if not mod then return end
mod:SetEncounterID(3105)
--mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
        -- there are 0 private auras on this fight
    }
end
