-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Akil'zon", "Zul'Aman")
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(23574)
mod.toggleOptions = {
	{43648, "FLASHSHAKE", "ICON"}, -- Electrical Storm
	"proximity",
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Storm", 43648)
	self:Log("SPELL_AURA_REMOVED", "StormRemoved", 43648)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 23574)
end

function mod:OnEngage()
	self:Bar(43648, LW_CL["next"]:format(GetSpellInfo(43648)), 50, 43648)
	self:OpenProximity(8)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:Storm(player, spellId, _, _, spellName)
	if UnitIsUnit(player, "player") then self:FlashShake(43648) end
	self:TargetMessage(43648, spellName, player, "Important", spellId, "Alert")
	self:Bar(43648, spellName, 8, spellId)
	self:PrimaryIcon(43648, player)
	self:CloseProximity()
end

function mod:StormRemoved(_, spellId, _, _, spellName)
	self:OpenProximity(8)
	self:PrimaryIcon(43648)
	self:Bar(43648, LW_CL["next"]:format(spellName), 40, spellId)
end

