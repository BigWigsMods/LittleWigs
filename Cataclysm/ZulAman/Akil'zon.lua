-------------------------------------------------------------------------------
--  Module Declaration

local mod, CL = BigWigs:NewBoss("Akil'zon", 568, 186)
if not mod then return end
mod:RegisterEnableMob(23574)

-------------------------------------------------------------------------------
--  Initialization

function mod:GetOptions()
	return {
		{43648, "FLASH", "PROXIMITY"}, -- Electrical Storm
		{97318, "ICON"}, -- Plucked
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ElectricalStorm", 43648)
	self:Log("SPELL_AURA_REMOVED", "ElectricalStormRemoved", 43648)
	self:Log("SPELL_AURA_APPLIED", "Plucked", 97318)
	self:Log("SPELL_AURA_REMOVED", "PluckedRemoved", 97318)

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 23574)
end

function mod:OnEngage()
	self:CDBar(43648, 50)
	self:OpenProximity(43648, 5)
end

-------------------------------------------------------------------------------
--  Event Handlers

function mod:ElectricalStorm(args)
	if self:Me(args.destGUID) then self:Flash(args.spellId) end
	self:TargetMessage(args.spellId, args.destName, "Important", "Alert")
	self:Bar(args.spellId, 8)
	self:PrimaryIcon(args.spellId, args.destName)
	self:CloseProximity(args.spellId)
end

function mod:ElectricalStormRemoved(args)
	self:OpenProximity(args.spellId, 5)
	self:PrimaryIcon(args.spellId)
	self:CDBar(args.spellId, 40)
end

function mod:Plucked(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, args.destName, "Important", "Alert")
		self:SecondaryIcon(args.spellId, args.destName)
	end
end

function mod:PluckedRemoved(args)
	self:SecondaryIcon(args.spellId)
end
