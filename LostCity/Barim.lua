-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("High Prophet Barim", "Lost City of the Tol'vir")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(43612)
mod.toggleOptions = {{82622, "FLASHSHAKE", "ICON"}, 82506, {88814, "FLASHSHAKE"}, "bosskill"}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Plague", 82622, 89997) -- Plague of Ages
	self:Log("SPELL_AURA_APPLIED", "Lashings", 82506) -- Fifty Lashings
	self:Log("SPELL_AURA_APPLIED", "Ground", 88814, 90010) -- Hallowed Ground

	self:RegisterEvent("UNIT_HEALTH")

	self:Death("Win", 43612)
end

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["phase_message"] = "Phase 2 soon!"
--@localization(locale="enUS", namespace="LostCity/Barim", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()
local BCL = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Plague(unit, spellId, _, _, spellName)
	if UnitIsUnit(unit, "player") then
		self:LocalMessage(82622, BCL["you"]:format(spellName), "Personal", spellId, "Info")
		self:FlashShake(82622)
	end
	self:PrimaryIcon(82622, unit)
end

function mod:Lashings(_, spellId, _, _, spellName)
	self:Message(82506, spellName, "Important", spellId)
end

function mod:Ground(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:LocalMessage(88814, BCL["you"]:format(spellName), "Urgent", spellId, "Alert")
		self:FlashShake(88814)
	end
end

function mod:UNIT_HEALTH(_, unit)
	if unit ~= "boss1" then return end
	if UnitName(unit) == self.displayName then
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 55 then
			self:Message(88814, L["phase_message"], "Attention")
			self:UnregisterEvent("UNIT_HEALTH")
		end
	end
end

