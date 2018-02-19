-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Anraphet", 644, 126)
if not mod then return end
mod:RegisterEnableMob(39788)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		{76184, "FLASH"}, -- Alpha Beams
		75622, -- Omega Stance
		75603, -- Nemesis Strike
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AlphaBeams", 76184)
	self:Log("SPELL_AURA_APPLIED", "AlphaBeamsDebuff", 76956)
	self:Log("SPELL_CAST_START", "OmegaStance", 75622)
	self:Log("SPELL_AURA_APPLIED", "NemesisStrike", 75603)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 39788)
end

function mod:OnEngage()
	self:Bar(75622, LW_CL["next"]:format(GetSpellInfo(75622)), 45, 75622)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:AlphaBeams(args)
	self:Message(args.spellId, "Attention", nil, CL.casting:format(args.spellName))
end

function mod:AlphaBeamsDebuff(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(76184, args.destName, "Personal", "Alarm")
		self:Flash(76184)
	end
end

function mod:OmegaStance(args)
	self:Message(args.spellId, "Important", "Alert", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 37)
end

function mod:NemesisStrike(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent")
end
