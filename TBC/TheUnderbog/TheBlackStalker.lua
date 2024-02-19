-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Black Stalker", 546, 579)
if not mod then return end
mod:RegisterEnableMob(17882)
mod:SetEncounterID(1948)
--mod:SetRespawnTime(0) -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		31704, -- Levitate
		{31715, "SAY", "ICON"}, -- Static Charge
		{31717, "SAY", "ICON", "CASTBAR"}, -- Chain Lightning
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Levitate", 31704)
	self:Log("SPELL_AURA_REMOVED", "LevitateRemoved", 31704)
	self:Log("SPELL_AURA_APPLIED", "StaticCharge", 31715)
	self:Log("SPELL_AURA_REMOVED", "StaticChargeRemoved", 31715)

	self:Log("SPELL_CAST_START", "ChainLightning", 31717)
	self:Log("SPELL_CAST_SUCCESS", "ChainLightningSuccess", 31717)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:Levitate(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange")
	self:TargetBar(args.spellId, 6, args.destName)
end

function mod:LevitateRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:StaticCharge(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId, nil, nil, "Static Charge")
	end
	self:TargetMessageOld(args.spellId, args.destName, "red", "warning")
	self:TargetBar(args.spellId, 12, args.destName)
	self:SecondaryIcon(args.spellId, args.destName)
end

function mod:StaticChargeRemoved(args)
	if self:Me(args.destGUID) then
		self:MessageOld(args.spellId, "green", nil, CL.over:format(args.spellName))
	end
	self:SecondaryIcon(args.spellId)
	self:StopBar(args.spellName, args.destName)
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) then
			self:Say(31717, nil, nil, "Chain Lightning")
		end
		self:TargetMessageOld(31717, name, "yellow")
		self:PrimaryIcon(31717, name)
	end

	function mod:ChainLightning(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CastBar(args.spellId, 3)
	end

	function mod:ChainLightningSuccess(args)
		self:PrimaryIcon(args.spellId)
	end
end
