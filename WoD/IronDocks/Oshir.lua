
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Oshir", 1195, 1237)
if not mod then return end
mod:RegisterEnableMob(79852)
mod.engageId = 1750
mod.respawnTime = 33

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.freed = "Freed after %.1f sec!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{162415, "ICON"}, -- Time to Feed
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "TimeToFeed", 162415)
	self:Log("SPELL_AURA_REMOVED", "TimeToFeedOver", 162415)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local t = 0
	function mod:TimeToFeed(args)
		t = GetTime()
		self:TargetMessage(args.spellId, args.destName, "Important", "Alarm")
		self:TargetBar(args.spellId, 20, args.destName)
		self:PrimaryIcon(args.spellId, args.destName)
	end

	function mod:TimeToFeedOver(args)
		self:Message(args.spellId, "Positive", nil, L.freed:format(GetTime()-t))
		self:PrimaryIcon(args.spellId)
		self:StopBar(args.spellId, args.destName)
	end
end
