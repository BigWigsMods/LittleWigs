if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Balakar Khan", 2516, 2477)
if not mod then return end
mod:RegisterEnableMob(186151) -- Balakar Khan
mod:SetEncounterID(2580)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Stage One: Balakar's Might
		376644, -- Iron Spear
		-- TODO Upheaval
		375937, -- Rending Strike
		-- Intermission: Stormwinds
		376730, -- Stormwinds
		-- TODO Lightning?
		-- Stage Two: The Storm Unleashed
		376865, -- Static Spear
		376892, -- Crackling Upheaval
		376827, -- Conductive Strike
	}, {
		[376644] = -25185, -- Stage One: Balakar's Might
		[376730] = -25192, -- Intermission: Stormwinds
		[376865] = -25187, -- Stage Two: The Storm Unleashed
	}
end

function mod:OnBossEnable()

end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

