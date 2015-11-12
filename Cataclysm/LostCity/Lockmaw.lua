
--------------------------------------------------------------------------------
-- Module declaration
--

local mod, CL = BigWigs:NewBoss("Lockmaw", 747, 118)
if not mod then return end
mod:RegisterEnableMob(43614)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		81630, -- Viscous Poison
		{81690, "ICON", "FLASH"}, -- Scent of Blood
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ViscousPoison", 81630)
	self:Log("SPELL_AURA_REMOVED", "ViscousPoisonRemoved", 81630)
	self:Log("SPELL_AURA_APPLIED", "ScentOfBlood", 81690)

	self:Death("Win", 43614)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ViscousPoison(args)
	self:TargetMessage(args.spellId, args.destName, "Attention")
	self:Bar(args.spellId, 12, args.destName)
end

function mod:ViscousPoisonRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:ScentOfBlood(args)
	self:TargetMessage(args.spellId, args.destName, "Important", "Alert")
	self:Bar(args.spellId, 30, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	end
end

