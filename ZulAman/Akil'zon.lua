-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Akil'zon", "Zul'Aman")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(23574)
mod.toggleOptions = {
	{43648, "FLASHSHAKE", "ICON", "PING"},	-- Electrical Storm
	"proximity",
	"bosskill",
}

--------------------------------------------------------------------------------
--  Locals

local storm = GetSpellInfo(43648)

-------------------------------------------------------------------------------
--  Localization

local L = mod:NewLocale("enUS", true)
if L then
--@do-not-package@
L["ping_message"] = "Storm - Pinging your location!"
--@localization(locale="enUS", namespace="ZulAman/Akil'zon", format="lua_additive_table", handle-unlocalized="ignore")@
end
L = mod:GetLocale()

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Storm", 43648)
	self:Log("SPELL_AURA_REMOVED", "StormRemoved", 43648)
	
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	
	self:Death("Win", 23574)
end

function mod:OnEngage()
	self:Bar(43648, LW_CL["next"]:format(storm), 50, 43648)
	self:OpenProximity(8)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Storm(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then
		self:FlashShake(43648)
		if bit.band(self.db.profile[(GetSpellInfo(43648))], BigWigs.C.PING) == BigWigs.C.PING then
			Minimap:PingLocation()
			BigWigs:Print(L["ping_message"])
		end
	end
	self:TargetMessage(43648, spellName, player, "Attention", spellId, "Alarm")
	self:Bar(43648, spellName..": "..player, 8, spellId)
	self:Bar(43648, LW_CL["next"]:format(storm), 55, spellId)
	self:PrimaryIcon(43648, player)
	self:CloseProximity()
end

function mod:StormRemoved(player, spellId, _, _, spellName)
	self:OpenProximity(8)
	self:Bar(43648, spellName, 40, spellId) -- make sure to remove bar when it takes off
end
