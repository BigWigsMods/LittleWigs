-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Foe Reaper 5000", "The Deadmines")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43778)
mod.toggleOptions = {91830, 88481, 88495, 91720, "bosskill"}
mod.optionHeaders = {
	[91830] = "Adds",
	[88481] = "general",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Fixate", 91830)
	self:Log("SPELL_CAST_START", "Overdrive", 88481)
	self:Log("SPELL_CAST_START", "Harvest", 88495)
	self:Log("SPELL_CAST_SUCCESS", "Safety", 91720)

	self:Death("Win", 43778)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
end

function mod:VerifyEnable()
	if GetInstanceDifficulty() == 2 then return true end
end

function mod:OnEngage()
	self:Bar(88481, GetSpellInfo(88481), 10, 88481)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Overdrive(_, spellId, _, _, spellName)
	self:Message(88481, spellName, "Important", spellId, "Alarm")
	self:Bar(88481, spellName, 53, spellId)
end

function mod:Harvest(_, spellId, _, _, spellName)
	self:Message(88495, spellName, "Attention", spellId, "Alert")
	self:Bar(88495, spellName, 56, spellId)
end

function mod:Safety(_, spellId, _, _, spellName)
	self:Message(91720, spellName, "Long", spellId, "Info")
end

function mod:Fixate(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(91830, LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")["you"]:format(spellName), "Personal", spellId)
		self:Bar(91830, spellName, 10, spellId)
	end
end

