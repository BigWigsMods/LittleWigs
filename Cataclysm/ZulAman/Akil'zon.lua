-------------------------------------------------------------------------------
--  Module Declaration

local mod = BigWigs:NewBoss("Akil'zon", 781)
if not mod then return end
mod.partyContent = true
mod:RegisterEnableMob(23574)
mod.toggleOptions = {
	{43648, "FLASHSHAKE", "ICON"}, -- Electrical Storm
	{97318, "ICON"}, -- Plucked
	"proximity",
	"bosskill",
}

-------------------------------------------------------------------------------
--  Initialization

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Storm", 43648)
	self:Log("SPELL_AURA_REMOVED", "StormRemoved", 43648)
	self:Log("SPELL_AURA_APPLIED", "Plucked", 97318)
	self:Log("SPELL_AURA_REMOVED", "PluckedRemoved", 97318)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 23574)
end

function mod:OnEngage()
	self:Bar(43648, LW_CL["next"]:format(GetSpellInfo(43648)), 50, 43648)
	self:OpenProximity(5)
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
	self:OpenProximity(5)
	self:PrimaryIcon(43648)
	self:Bar(43648, LW_CL["next"]:format(spellName), 40, spellId)
end

function mod:Plucked(player, spellId, _, _, spellName)
	if UnitIsPlayer(player) then
		self:TargetMessage(97318, spellName, player, "Important", spellId, "Alert")
		self:SecondaryIcon(97318, player)
	end
end

function mod:PluckedRemoved()
	self:SecondaryIcon(97318)
end

