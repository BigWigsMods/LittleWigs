-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Akil'zon", 568, 186)
if not mod then return end
mod:RegisterEnableMob(23574)
mod.engageId = 1189
mod.respawnTime = 60

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{43622, "PROXIMITY"}, -- Static Disruption
		{43648, "PROXIMITY"}, -- Electrical Storm
		{97318, "ICON"}, -- Plucked
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ElectricalStorm", 43648)
	self:Log("SPELL_AURA_REMOVED", "ElectricalStormRemoved", 43648)
	self:Log("SPELL_AURA_APPLIED", "Plucked", 97318)
	self:Log("SPELL_AURA_REMOVED", "PluckedRemoved", 97318)
end

function mod:OnEngage()
	self:CDBar(43648, 50) -- Electrical Storm
	self:OpenProximity(43622, 5) -- Static Disruption
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:ElectricalStorm(args)
	self:CloseProximity(43622) -- Static Disruption
	if not self:Me(args.destGUID) then
		self:OpenProximity(args.spellId, 20, args.destName, true)
	end
	self:TargetMessage(args.spellId, args.destName, "Important", "Alert")
	self:Bar(args.spellId, 8)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:ElectricalStormRemoved(args)
	self:CloseProximity(args.spellId)
	self:OpenProximity(43622, 5) -- Static Disruption
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
