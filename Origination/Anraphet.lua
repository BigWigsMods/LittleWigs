-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Anraphet", 759)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(39788)
mod.toggleOptions = {{76184, "FLASHSHAKE"}, 75622, 75603, "bosskill"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Alpha", 76184)
	self:Log("SPELL_AURA_APPLIED", "AlphaDebuff", 76956, 91177)
	self:Log("SPELL_CAST_START", "Omega", 75622, 91208)
	self:Log("SPELL_AURA_APPLIED", "Nemesis", 75603, 91174)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 39788)
end

function mod:OnEngage()
	self:Bar(75622, LW_CL["next"]:format(GetSpellInfo(75622)), 45, 75622)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Alpha(_, spellId, _, _, spellName)
	self:Message(76184, LW_CL["casting"]:format(spellName), "Attention", spellId)
end

function mod:AlphaDebuff(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(76184, LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")["you"]:format(spellName), "Personal", spellId, "Alarm")
		self:FlashShake(76184)
	end
end

function mod:Omega(_, spellId, _, _, spellName)
	self:Message(75622, LW_CL["casting"]:format(spellName), "Important", spellId, "Alert")
	self:Bar(75622, LW_CL["next"]:format(spellName), 37, spellId)
end

function mod:Nemesis(player, spellId, _, _, spellName)
	self:TargetMessage(75603, spellName, player, "Urgent", spellId)
end

