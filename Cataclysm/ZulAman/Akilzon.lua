-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Akil'zon", 568, 186)
if not mod then return end
mod:RegisterEnableMob(23574)
mod:SetEncounterID(1189)
mod:SetRespawnTime(60)

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{43648, "ICON"}, -- Electrical Storm
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
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:ElectricalStorm(args)
	self:TargetMessageOld(args.spellId, args.destName, "red", "alert")
	self:Bar(args.spellId, 8)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:ElectricalStormRemoved(args)
	self:PrimaryIcon(args.spellId)
	self:CDBar(args.spellId, 40)
end

function mod:Plucked(args)
	if self:Me(args.destGUID) then
		self:TargetMessageOld(args.spellId, args.destName, "red", "alert")
		self:SecondaryIcon(args.spellId, args.destName)
	end
end

function mod:PluckedRemoved(args)
	self:SecondaryIcon(args.spellId)
end
