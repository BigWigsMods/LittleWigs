-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("King Dred", 600, 590)
if not mod then return end
mod:RegisterEnableMob(27483)
mod:SetEncounterID(mod:Classic() and 373 or 1977)
--mod:SetRespawnTime(0) -- resets, doesn't respawn

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
	self:Log("SPELL_CAST_SUCCESS", "PiercingSlashSuccess", 48878)
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
	self:TargetMessage(args.spellId, "purple", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end

function mod:PiercingSlashSuccess(args)
	self:CDBar(args.spellId, 18.3) -- 18.3 - 27.9s
end

function mod:RaptorCall(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 30.4) -- can randomly skip one cast
end
