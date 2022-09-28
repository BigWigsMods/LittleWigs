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
	L.wolves = "Wolves"
	L.rylak = "Rylak"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{162415, "ICON"}, -- Time to Feed
		178124, -- Breakout
		161256, -- Primal Assault
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_AURA_APPLIED", "TimeToFeed", 162415)
	self:Log("SPELL_AURA_REMOVED", "TimeToFeedOver", 162415)
end

function mod:OnEngage()
	self:CDBar(161256, 7.4) -- Primal Assault
	self:CDBar(178124, 18.3, CL.other:format(self:SpellName(178124), L.wolves)) -- Breakout: Wolves
	self:CDBar(162415, 39) -- Time to Feed
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 178126 then -- Breakout (Rylak Skyterror)
		self:Message(178124, "yellow", CL.other:format(self:SpellName(178124), L.rylak)) -- Breakout: Rylak
		self:PlaySound(178124, "alert")
		self:CDBar(178124, 40, CL.other:format(self:SpellName(178124), L.wolves)) -- Breakout: Wolves
	elseif spellId == 178128 then -- Breakout (Ravenous Wolf)
		self:Message(178124, "yellow", CL.other:format(self:SpellName(178124), L.wolves)) -- Breakout: Wolves
		self:PlaySound(178124, "alert")
		self:CDBar(178124, 40, CL.other:format(self:SpellName(178124), L.rylak)) -- Breakout: Rylak
	elseif spellId == 162769 then -- Hamstring Backflip
		self:Message(161256, "orange") -- Primal Assault
		self:PlaySound(161256, "alarm")
		self:CDBar(161256, 26.8)
	end
end

do
	local t = 0
	function mod:TimeToFeed(args)
		t = args.time
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "long", nil, args.destName)
		self:TargetBar(args.spellId, 20, args.destName)
		self:PrimaryIcon(args.spellId, args.destName)
		self:StopBar(args.spellId)
	end

	function mod:TimeToFeedOver(args)
		self:Message(args.spellId, "green", L.freed:format(args.time - t))
		self:PlaySound(args.spellId, "info")
		self:PrimaryIcon(args.spellId)
		self:StopBar(args.spellId, args.destName)
		self:CDBar(args.spellId, 47.4)
	end
end
