-- XXX Ulic: Other suggestions?

-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Altairus", "The Vortex Pinnacle")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43873)
mod.toggleOptions = {
	88286, -- Downwind of Altairus
	88282, -- Upwind of Altairus
	88308, -- Breath
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local pName = GetUnitName("player")

-------------------------------------------------------------------------------
--  Localization

LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Upwind", 88282)
	self:Log("SPELL_AURA_APPLIED", "Downwind", 88286)
	self:Log("SPELL_CAST_START", "Breath", 88308, 93989)

	self:Death("Win", 43873)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Upwind(unit, spellId, _, _, spellName)
	if pName == GetUnitName(unit) then
		self:LocalMessage(88282, spellName, "Positive", "Info", spellId)
	end
end

function mod:Downwind(unit, spellId, _, _, spellName)
	if pName == GetUnitName(unit) then
		self:LocalMessage(88286, spellName, "Attention", "Alert", spellId)
	end
end

function mod:Breath(unit, spellId, _, _, spellName)
	self:Bar(88308, LCL["next"]:format(spellName, 12), spellId)
	self:Message(88308, LCL["casting"]:format(spellName), "Urgent", spellId)
end