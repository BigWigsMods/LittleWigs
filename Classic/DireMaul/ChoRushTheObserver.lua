--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Cho'Rush the Observer", 429, 416)
if not mod then return end
mod:RegisterEnableMob(14324) -- Cho'Rush the Observer
mod:SetEncounterID(367)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- XXX revise this module
	}
end

function mod:OnBossEnable()
	-- Cho'Rush the Observer becomes friendly if you defeat King Gordok
	self:Death("Win", 11501) -- King Gordok
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--
