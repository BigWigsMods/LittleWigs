-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("King Dred", 600, 590)
if not mod then return end
mod:RegisterEnableMob(27483)
mod.engageId = 1977
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		{48878, "TANK_HEALER"}, -- Piercing Slash
		59416, -- Raptor Call
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "PiercingSlash", 48878)
	self:Log("SPELL_AURA_REMOVED", "PiercingSlashRemoved", 48878)
	self:Log("SPELL_CAST_SUCCESS", "PiercingSlashCastSuccess", 48878)
	self:Log("SPELL_CAST_START", "RaptorCall", 59416)
end

function mod:OnEngage()
	self:CDBar(48878, 18.0) -- Piercing Slash
	self:CDBar(59416, 16.8) -- Raptor Call
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:PiercingSlash(args)
	if self:Me(args.destGUID) or self:Healer() then
		self:TargetMessageOld(args.spellId, args.destName, "orange", "alarm", nil, nil, true)
		self:TargetBar(args.spellId, 10, args.destName)
	end
end

function mod:PiercingSlashRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:PiercingSlashCastSuccess(args)
	self:CDBar(args.spellId, 18.3) -- 18.3 - 27.9s
end

function mod:RaptorCall(args)
	self:MessageOld(args.spellId, "yellow")
	self:CDBar(args.spellId, 30.4) -- can randomly skip one cast
end
