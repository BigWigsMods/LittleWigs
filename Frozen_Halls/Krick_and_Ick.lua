-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Krick and Ick", "Pit of Saron")
if not mod then return end
mod.partyContent = true
mod.otherMenu = "The Frozen Halls"
mod:RegisterEnableMob(36476, 36477)
mod.toggleOptions = {
	70274, -- Toxic Waste
	68989, -- Poison Nova
	69263, -- Explosive Barrage
	68987, -- Pursuit
	"bosskill",
}

-------------------------------------------------------------------------------
--  Locals

local barrage = nil
local pursuit = GetSpellInfo(68987)
local pursuitWarned = {}

-------------------------------------------------------------------------------
--  Localization

local BCL = LibStub("AceLocale-3.0"):GetLocale("Big Wigs: Common")
local LCL = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Common")

local L = LibStub("AceLocale-3.0"):NewLocale("Little Wigs: Krick and Ick", "enUS", true)
if L then
	--@do-not-package@
	L["barrage_message"] = "Summoning explosive mines"
	--@end-do-not-package@
	--@localization(locale="enUS", namespace="Frozen_Halls/Krick_and_Ick", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = LibStub("AceLocale-3.0"):GetLocale("Little Wigs: Krick and Ick")
mod.locale = L

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Barrage", 69263)
	self:Log("SPELL_AURA_REMOVED", "BarrageEnd", 69263)
	self:Log("SPELL_AURA_APPLIED", "Toxic", 70274)
	self:Log("SPELL_CAST_START", "Nova", 68989, 70434)
	self:Death("Win", 36476)

	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("UNIT_AURA")
end

function mod:OnEngage()
	barrage = nil
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Barrage(_, spellId, _, _, spellName)
	if barrage then return end
	barrage = true
	self:Message(69263, L["barrage_message"], "Urgent", spellId)
	self:Bar(69263, spellName, 18, spellId)
end

function mod:BarrageEnd(_, _, _, _, spellName)
	barrage = false
	self:SendMessage("BigWigs_StopBar", spellName)
end

function mod:Toxic(player, spellId, _, _, spellName)
	if player ~= pName then return end
	self:LocalMessage(70274, BCL["you"]:format(spellName), "Personal", spellId, "Alarm")
	self:FlashShake(70274)
end

function mod:Nova(_, spellId, _, _, spellName)
	self:Message(68989, LCL["casting"]:format(spellName), "Urgent", spellId)
	self:Bar(68989, spellName, 5, spellId)
end

function mod:UNIT_AURA(event, unit)
	local name, _, icon = UnitDebuff(unit, pursuit)
	local n = UnitName(unit)
	if pursuitWarned[n] and not name then
		pursuitWarned[n] = nil
	elseif name and not pursuitWarned[n] then
		self:TargetMessage(68987, pursuit, n, "Attention", icon)
		pursuitWarned[n] = true
	end
end
