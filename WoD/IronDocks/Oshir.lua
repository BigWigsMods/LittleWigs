
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Oshir", 987, 1237)
if not mod then return end
mod:RegisterEnableMob(79852)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:NewLocale("enUS", true)
if L then
	L.freed = "Freed after %.1f sec!"
end
L = mod:GetLocale()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{162415, "ICON"}, -- Time to Feed
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Log("SPELL_AURA_APPLIED", "TimeToFeed", 162415)
	self:Log("SPELL_AURA_REMOVED", "TimeToFeedOver", 162415)

	self:Death("Win", 79852)
end

function mod:OnEngage()

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

