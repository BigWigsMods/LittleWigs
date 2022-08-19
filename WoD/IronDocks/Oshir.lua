--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Oshir", 1195, 1237)
if not mod then return end
mod:RegisterEnableMob(79852)
mod:SetEncounterID(1750)
mod:SetRespawnTime(33)

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
		178124, -- Breakout
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_AURA_APPLIED", "TimeToFeed", 162415)
	self:Log("SPELL_AURA_REMOVED", "TimeToFeedOver", 162415)
end

function mod:OnEngage()
	self:CDBar(178124, 18.4) -- Breakout
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 178126 then -- Breakout (Rylak Skyterror)
		self:Message(178124, "yellow", "Breakout (Rylak Skyterror)")
		self:PlaySound(178124, "alert")
		self:CDBar(178124, 40)
	elseif spellId == 178128 then -- Breakout (Ravenous Wolf)
		self:Message(178124, "yellow", "Breakout (Ravenous Wolf)")
		self:PlaySound(178124, "alert")
		self:CDBar(178124, 40)
end

do
	local t = 0
	function mod:TimeToFeed(args)
		t = GetTime()
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "long")
		self:TargetBar(args.spellId, 20, args.destName)
		self:PrimaryIcon(args.spellId, args.destName)
	end

	function mod:TimeToFeedOver(args)
		self:Message(args.spellId, "green", L.freed:format(GetTime()-t))
		self:PlaySound(args.spellId, "info")
		self:PrimaryIcon(args.spellId)
		self:StopBar(args.spellId, args.destName)
	end
end
