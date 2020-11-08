-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Black Stalker", 546, 579)
if not mod then return end
mod:RegisterEnableMob(17882)
mod.engageId = 1948
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		31704, -- Levitate
		{31715, "SAY", "ICON", "PROXIMITY"}, -- Static Charge
		{31717, "SAY", "ICON"}, -- Chain Lightning
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
		self:Say(args.spellId)
		self:OpenProximity(args.spellId, 8)
	else
		self:OpenProximity(args.spellId, 8, args.destName)
	end
	self:TargetMessageOld(args.spellId, args.destName, "red", "warning")
	self:TargetBar(args.spellId, 12, args.destName)
	self:SecondaryIcon(args.spellId, args.destName)
end

function mod:StaticChargeRemoved(args)
	if self:Me(args.destGUID) then
		self:MessageOld(args.spellId, "green", nil, CL.over:format(args.spellName))
	end
	self:CloseProximity(args.spellId)
	self:SecondaryIcon(args.spellId)
	self:StopBar(args.spellName, args.destName)
end

do
	local function announce(self, target, guid)
		if self:Me(guid) then
			self:Say(31717)
		end
		self:TargetMessageOld(31717, target, "yellow")
		self:PrimaryIcon(31717, target)
	end

	function mod:ChainLightning(args)
		self:GetBossTarget(announce, 0.4, args.sourceGUID)
		self:CastBar(args.spellId, 3)
	end

	function mod:ChainLightningSuccess(args)
		self:PrimaryIcon(args.spellId)
	end
end
