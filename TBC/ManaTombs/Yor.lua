
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Yor", 732, 536)
if not mod then return end
mod:RegisterEnableMob(22930)
-- According to comments on wowhead, to engage this boss you need to have compeleted a quest that's only available when you are Revered with The Consortium:
-- mod.engageId = 250 -- from the encounterIDs dump
-- mod.respawnTime = 0 -- no idea

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		34716, -- Stomp
	}
end

function mod:OnBossEnable()
	-- XXX revise this module

	self:Death("Win", 22930)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

