
-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Ozruk", "The Stonecore")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(42188)
mod.toggleOptions = {
	78939, -- Elementium Bulwark
	80467, -- Enrage
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local enraged

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["engage_trigger"] = "None may pass into the World's Heart!"--@end-do-not-package@
--@localization(locale="enUS", namespace="Stonecore/Ozruk", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Bulwark", 78939, 92659)
	self:Log("SPELL_AURA_REMOVED", "BulwarkRemoved", 78939, 92659)

	self:Log("SPELL_AURA_APPLIED", "Enraged", 80467)
	self:RegisterEvent("UNIT_HEALTH")

	self:Yell("Engage", L["engage_trigger"])

	self:Death("Win", 42188)
end

function mod:OnEngage()
	enraged = nil
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Bulwark(player, spellId, _, _, spellName)
	if player == self.displayName then --we only warn if the boss gains it, not a mage spell stealing
		self:Message(78939, spellName, "Important", spellId)
		self:Bar(78939, spellName, 10, spellId)
	end
end

function mod:BulwarkRemoved(_, _, _, _, spellName)
	self:SendMessage("BigWigs_StopBar", self, spellName) --stop the bar early if dispelled
end

function mod:UNIT_HEALTH(_, unit)
	if unit ~= "boss1" then return end --if it's not the boss, don't do anything
	if enraged then
		self:UnregisterEvent("UNIT_HEALTH")
		return
	end
	if UnitName(unit) == self.displayName then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp <= 27 and not enraged then
			self:Message(80467, LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")["soon"]:format(GetSpellInfo(80467)), "Attention", 80467)
			enraged = true
		end
	end
end

function mod:Enraged(_, spellId, _, _, spellName)
	self:Message(80467, spellName, "Important", spellId, "Long")
end

